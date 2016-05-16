---
layout: post
title: "Building a node web app at scale with AWS Lambda"
date: 2016-05-15 11:00:00 +0000
comments: true
categories: digest
---

Recently I build a web app for the [Eurovision Song Contest](http://www.eurovision.tv). Here the things I would like to have known 6 week ago.

Some days into the project [Node 4.3 support was added](https://aws.amazon.com/de/about-aws/whats-new/2016/04/aws-lambda-supports-node-js-4-3/). Previously the only supported Node version was 0.10 and the lack of generators made the code super messy. Without Node 4.3 this blogpost probably would look kinda different.

## Lambda is not a web server!

The signature of a [Lambda function](http://docs.aws.amazon.com/lambda/latest/dg/nodejs-prog-model-handler.html):

```js
exports.handler = function(event, context, callback) {
}
```

Lambda function can be triggered from different sources ([S3](http://docs.aws.amazon.com/lambda/latest/dg/with-s3.html), [DynamoDB](http://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html), [Scheduled Events](http://docs.aws.amazon.com/lambda/latest/dg/with-scheduled-events.html) and more). For processing HTTP requests another service is needed: [API Gateway](https://aws.amazon.com/de/api-gateway/).

API Gateway is not tied to Lambda can be used for various kinds of backends. Buttom line: The API Gateway/Lambda stack has very little to do with something like Express. On the contrary, mastering API Gateway is hard and I underestimated that. As a matter of fact most debugging and cursing happend on API Gateway side and not because of Lambda.

## How to get requests into Lambda

API Gateway provides a graphical interface where you (basically) setup endpoint and method and map it to a Lambda function.

![api-gateway-method-endpoint](/images/2016/api-gateway-method-endpoint.png)

By default API Gateway only passes the request payload (in case of a `POST`/`PUT`) to the `event` parameter (see above) of a Lambda function. And for a `GET` request nothing is passed!

### Input mapping

In order to get all the request meta data into Lambda (like path, method, ip, headers etc.) a input "Body Mapping Templates" must be setuped. This is the mapping I used:

```js
{
  "method": "$context.httpMethod",
  "body" : $input.json('$'),
  "path": "$context.resourcePath",
  "ip": "$context.identity.sourceIp",
  "headers": {
    #foreach($param in $input.params().header.keySet())
      "$param.toLowerCase()": "$util.escapeJavaScript($input.params().header.get($param))" #if($foreach.hasNext),#end
    #end
  },
  "queryParams": {
    #foreach($param in $input.params().querystring.keySet())
      "$param": "$util.escapeJavaScript($input.params().querystring.get($param))" #if($foreach.hasNext),#end
    #end
  },
  "pathParams": {
    #foreach($param in $input.params().path.keySet())
      "$param": "$util.escapeJavaScript($input.params().path.get($param))" #if($foreach.hasNext),#end
    #end
  }  
}
```

This values are then available in the `event` parameter of the Lambda handler function.

## How to get responses out of Lambda

For success response it's quite easy. From Lambda do:

```js
exports.handler = function(event, context, callback) {
  // do the work here

  let responseData = {};
  callback(null, responseData);
}
```

`response` is what your user will receive as response payload.

### How to setup non-default (200) reponses

Probably the most annoying thing with API Gateway (and the thing that produces the most Lambda related issue in the API Gateway forums) is how to setup custom HTTP response codes. It works by regex'ing over the error reponse from Lambda.

Suppose you want to respond with a 404. From Lambda you call:

```js
exports.handler = function(event, context, callback) {
  // do the work here

  callback("404 happened");
}
```

Since the first parameter of the callback function is used, API Gateway understands it as an error. In API Gateway you setup a "Lambda Error Regex" with regex `.*404.*` and the user will receive status code 404.

So how to not only set the correct status code but also pass a response to the client? You can pass the status code and response body as sparate properties:

```js
exports.handler = function(event, context, callback) {
  // do the work here

  callback({
    status: 403,
    body: JSON.stringify({
      message: "you're not allowed to do that"
    })
  });
}
```

In API Gateway I then setup a "Lambda Error Regex" where the regex is `.*\"status\":403.*` and the following output "Body Mapping Template" ("Body Mapping Template" maps the reponse from Lambda to the response body that is passed to the user from API Gateway):

```js
#set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')))
$errorMessageObj.body
```

`$.errorMessage` is the error data coming from Lambda.

This needs be done for all response codes. You'll end up with something like this:

![api-gateway-error-codes](/images/2016/api-gateway-error-codes.png)

### How to set response headers

Suppose you want to set a set-cookie or a location header. How to do that? You can set "Header Mappings" where you map a property from the Lambda response object to a header set in API Gateway.

![api-gateway-header-mapping-set-cookie](/images/2016/api-gateway-header-mapping-set-cookie.png)

Here is the catch: that does only work with the default response (see 200 from above) but not with the "Lambda Error Regex" workaround since the "Header Mapping" can not access the `$.errorMessage` property.

That means that you can currently only have one response code (the one that you defined as default) to set headers. I'm sure AWS is currently working on that. Because this is bad.

## Get used to swagger config file early

While the graphical user interface of API Gateway is fine at the beginning when starting to work with and understanding API Gateway it gets super annoying down the road, because you ending up copy-pasting stuff all the time. For instance you will likely want to have the same "Lambda Error Regex" for most of your endpoints. And you definettly need to have the input "Body Mapping Templates" from above on every endpoint.

I resisted way to long agains using a swagger config file, since I was unfamiliar with it and thought I already need to learn enough new stuff. However, it's easy to understand since it provides the same settings as the graphical user interface. I suggest you set a your basic setting with the GUI and then export it via "Stages" -> "Your stage name" -> "Export" -> "Export as Swagger + API Gateway Extensions".

Then you can edit the swagger config file locally and push it with:

```
aws apigateway put-rest-api --rest-api-id <your_api_id> --mode overwrite --body file://<path_to_swagger_file.json>
```

## Serving static files

Most parts of the site were dynamic (the admin interface and the API), but there were also static ones (the homepage). API Gateway can be used to serve static content by using the "AWS Service Proxy" Integration type. With that static files can be proxied from S3.

But it's slow! And requests count agains the API Gateway throttling limits. Instead you should use subdomains for requests that should be handled by API Gateway Lambda (i.e. api.your_domain.com and admin.your_domain.com) and map the homepage (your_domain.com) to CloudFront. This is specially true since API Gateway *can not* server binary files (i.e. images).

Note: I did not test the API Gateway cache.

## How to run Lambda functions locally?

I didn't do it. Being able to run the tests locally was enough for me. Final tests I did on production. I understand that this would not be suitable for larger and more complex projects.

## What to use for deployment?

I went with [node-lambda](https://github.com/motdotla/node-lambda). I haven't really test the alternatives. node-lambda does what I needed (deploy the function). Their ENV variables handling is nice.

## At scale

If you're expecting a lot of traffic you might want to contact AWS support to increase API Gateway and Lambda limits.

Lambda is smart in reusing the spawed Lambda nodes. So if your Lambda function executes relatively fast (~300ms, typical for API requests) and the traffic is moderate the default Lambda limit (100 concurent Lambdas) should be fine.

## No gzip

:(

## Conclusion

While Lambda is easy to get used to, having to proxy request through API Gateway make everything hard are which is super-easy in plain node (with the help of [express](http://expressjs.com/de) or friends). Now that I went through all the pain everything seams obvious. But it was a hard process.

Still, serverless is the new cool kid on the block and I enjoyed not needing to deal with privisioning servers (and make them scale). AWS is the leader and they actively improving Lambda and API Gateway.

I'm also very exited about zeit.co. With them you can just deploy your express app. Need to look into that soon.