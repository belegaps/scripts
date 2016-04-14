# Generate Escenic Syndication

## NAME

generate-ece-syndication

## SYNOPSIS

generate-ece-syndication.sh <content-type-file> <content-type>...

## DESCRIPTION

The script loads the given content-type file and generates a skeleton import file for Escenic, containing a content item for each content type given as argument.  A content type can be given multiple times to generate multiple content items for that type.

## EXAMPLES

The following command generates an import file containing one "picture" content item and one "story" content type.  The file doesn't link the content items by relations.  This is left as an exercise for the user.

	$ generate-ece-syndication.sh content-type.xml picture story > import.xml
