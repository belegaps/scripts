#!/usr/bin/env bash

# Version of Xalan to use
XALAN_VERSION=2.7.2

# Required JAR files for executing processor
XALAN_JAR=~/.m2/repository/xalan/xalan/$XALAN_VERSION/xalan-$XALAN_VERSION.jar
SERIALIZER_JAR=~/.m2/repository/xalan/serializer/$XALAN_VERSION/serializer-$XALAN_VERSION.jar

# Use Maven to download Xalan jar and it's dependency (serializer)
if [ ! -f $XALAN_JAR -o ! -f $SERIALIZER_JAR ]; then
	mvn dependency:get -Dartifact=xalan:xalan:$XALAN_VERSION
fi

# Execute XML transformation processor
java -cp $XALAN_JAR:$SERIALIZER_JAR org.apache.xalan.xslt.Process $*
