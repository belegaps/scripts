#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

XALAN="java -cp ~/Development/Java/xalan-j_2_7_1/xalan.jar org.apache.xalan.xslt.Process"

