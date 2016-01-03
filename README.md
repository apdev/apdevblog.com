# apdevblog.com
```
rake generate   # Generates posts and pages into the public directory
rake watch      # Watches source/ and sass/ for changes and regenerates
rake preview    # Watches, and mounts a webserver at http://localhost:4000
rake deploy     # Deploy to s3

rake new_post["post title"]     # Create new post
```
In order for `rake deploy` to work, [aws-cli](https://github.com/aws/aws-cli) must be installed and configured. With the dev-env this is already done.
