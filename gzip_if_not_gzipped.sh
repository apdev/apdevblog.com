#!/bin/bash
file $1 | grep "gzip compressed data" > /dev/null
if [[ $? != 0 ]] ; then
    # only gzip if it's not already gzipped
    gzip -nf $1
fi