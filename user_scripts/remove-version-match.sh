#!/bin/sh
if [ -z $1 ]; then
	echo "Must specify a file to modify..."
	exit 1
fi
regex='^=?(\S+)(?:-[[:digit:]]+\S*)(\s)(\S+)$'
sub='\1\2\3'
perl -pe "s;$regex;$sub;gm" -i "${1}"
