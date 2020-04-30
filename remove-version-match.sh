#!/bin/sh
if [ -z $1 ]; then
	echo "Must specify a file to modify..."
	exit 1
fi
perl -pe 's;^=?(\S+)(?:-[[:digit:]]+\.\S+)(\s)(\S+)$;\1\2\3;' -i "${1}"
