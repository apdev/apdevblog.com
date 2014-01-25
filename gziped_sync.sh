#!/bin/bash

# compress the files if they aren't
find public/ -iname '*.html' -exec ./gzip_if_not_gzipped.sh {} \;
find public/ -iname '*.js' -exec ./gzip_if_not_gzipped.sh {} \;
find public/ -iname '*.css' -exec ./gzip_if_not_gzipped.sh {} \;

# change their name back
find public -iname '*.gz' -exec bash -c 'mv $0 ${0/.gz/}' {} \;
echo "gzipping successful"

echo "syncing html (gzipped)"
s3cmd sync --acl-public --reduced-redundancy --cf-invalidate --verbose --cf-invalidate-default-index --mime-type='text/html; charset=utf-8' --add-header 'Content-Encoding:gzip' --add-header 'Cache-Control:public;max-age=3600' public/* s3://$1/ --exclude '*.*' --include '*.html'
echo "syncing html (gzipped) complete"

echo "syncing js and css (gzipped)"
s3cmd sync --acl-public --reduced-redundancy --cf-invalidate --verbose --add-header 'Content-Encoding:gzip' --add-header 'Cache-Control:public;max-age=3600' public/* s3://$1/ --exclude '*.*' --include '*.js' --include '*.css'
echo "syncing js and css (gzipped) complete"

echo "syncing images"
s3cmd sync --acl-public --reduced-redundancy --cf-invalidate --verbose --add-header 'Cache-Control:public;max-age=31536000' public/* s3://$1/ --exclude '*.*' --include '*.jpg' --include '*.png' --include '*.gif'
echo "syncing images complete"

echo "syncing rest"
s3cmd sync --acl-public --reduced-redundancy --cf-invalidate --verbose --add-header 'Cache-Control:public;max-age=3600' public/* s3://$1/ --exclude '*.html' --exclude '*.js' --exclude '*.css' --exclude '*.jpg' --exclude '*.png' --exclude '*.gif'
echo "syncing rest complete"