#!/bin/bash

# compress the files if they aren't
find public/ -iname '*.html' -exec ./gzip_if_not_gzipped.sh {} \;
find public/ -iname '*.js' -exec ./gzip_if_not_gzipped.sh {} \;
find public/ -iname '*.css' -exec ./gzip_if_not_gzipped.sh {} \;

# change their name back
find public -iname '*.gz' -exec bash -c 'mv $0 ${0/.gz/}' {} \;
echo "gzipping successful"

echo "syncing gzipped files"
s3cmd sync --acl-public --reduced-redundancy --cf-invalidate --verbose --cf-invalidate-default-index --add-header 'Content-Encoding:gzip' public/* s3://$1/ --exclude '*.*' --include '*.html' --include '*.js' --include '*.css'
echo "syncing gzipped files complete"

echo "syncing non-gzipped files"
s3cmd sync --acl-public --reduced-redundancy --cf-invalidate --verbose public/* s3://$1/ --exclude '*.html' --exclude '*.js' --exclude '*.css'
echo "syncing non-gzipped files complete"