#!/usr/bin/env bash
if [ ! -f ~/.m2/repository/xalan/xalan/2.7.2/xalan-2.7.2.jar ]; then
	mvn dependency:get -Dartifact=xalan:xalan:2.7.2
fi

java -cp ~/.m2/repository/xalan/xalan/2.7.2/xalan-2.7.2.jar org.apache.xalan.xslt.Process $*
