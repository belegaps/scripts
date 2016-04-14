# Xalan XML Transformer

## NAME

xalan

## SYNOPSIS

xalan.sh <xalan-options>

## DESCRIPTION

Executes the Xalan XML transformer processor passing along all arguments given to the script.

If the processor is not available on the system, the script will use Maven to fetch the Xalan library and it's dependencies.  If maven is not installed on the system, the script will fail.

## EXAMPLES

The following command transforms an XML file using a stylesheet.

	$ xalan.sh -in input.xml -xsl stylesheet.xsl -out output.xml
