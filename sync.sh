#!/bin/bash

echo "syncing html"
aws s3 sync public/. s3://$1/ --acl "public-read" --cache-control "public,max-age=43200" --exclude '*.*' --include '*.html'
echo "syncing html complete"

echo "syncing js and css"
aws s3 sync public/. s3://$1/ --acl "public-read" --cache-control "public,max-age=43200" --exclude '*.*' --include '*.js' --include '*.css'
echo "syncing js and css complete"

echo "syncing images"
aws s3 sync public/. s3://$1/ --acl "public-read" --cache-control "public,max-age=31536000" --exclude '*.*' --include '*.jpg' --include '*.png' --include '*.gif'
echo "syncing images complete"

echo "syncing rest"
aws s3 sync public/. s3://$1/ --acl "public-read" --cache-control "public,max-age=43200" --exclude '*.html' --exclude '*.js' --exclude '*.css' --exclude '*.jpg' --exclude '*.png' --exclude '*.gif'
echo "syncing rest complete"

aws cloudfront create-invalidation --distribution-id EGOQYHI9D5FFP --paths /.
