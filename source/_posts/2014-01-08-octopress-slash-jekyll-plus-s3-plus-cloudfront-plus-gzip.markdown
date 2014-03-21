---
layout: post
title: "Octopress/Jekyll + S3 + CloudFront + gzip"
date: 2014-01-08 11:12:29 +0100
author: Aron
comments: true
permalink: /octopress-jekyll-s3-cloudfront-gzip
categories:
  - Octopress
  - hosting
  - post
tags:
  - Octopress
  - CDN
  - S3
  - CloudFront
  - s3cmd
  - AWS
---
We recently moved this blog from WordPress to Octopress. Static pages FTW! And because we have static pages we want to use every [CDN](http://de.wikipedia.org/wiki/Content_Delivery_Network) power we can get. We choose to use [AWS CloudFront](http://aws.amazon.com/cloudfront/). There are some fine tutorials on the interweb how to make all this work:

[Blogging with Jekyll + S3 + CloudFront](http://www.maxmasnick.com/2012/01/21/jekyll_s3_cloudfront/)  
[Quick Tip for Easily Deploying Octopress Blog on Amazon CloudFront](http://www.jerome-bernard.com/blog/2011/08/20/quick-tip-for-easily-deploying-octopress-blog-on-amazon-cloudfront/)

One open thing was to enable gzipped content. Zipping is certainly the most obvious performance optimization. Usually the webserver takes care of it, but we don't have a webserver here. We have a CDN and like every CDN CloudFront doesn't "process" request, it just serves files. Meaning that by definition it does not compress files when requested by a client. However that only means that we need to create zipped files when we deploy the Octopress files. A very good starting point:

[gzip your Octopress](http://www.furida.mu/blog/2012/02/29/gzip-your-octopress/)

I made some modifications regarding CloudFront. Also ```rename``` is not available on OSX so I changed it around a bit.

{% gist 8298023 gziped_sync.sh aronwoost %}