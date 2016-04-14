#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [ -z "$2" ]; then
	echo "Usage: `basename $0` <content-type-file> <content-type>..." 1>&2
	exit 1
fi

CONTENT_TYPE_FILE=$1
shift 1

while [ -n "$1" ]; do
	CONTENT_TYPES="${CONTENT_TYPES:+$CONTENT_TYPES,}$1"
	shift 1
done

xalan -in $CONTENT_TYPE_FILE -xsl $DIR/../lib/generate-ece-syndication.xsl -param content-types "$CONTENT_TYPES"

