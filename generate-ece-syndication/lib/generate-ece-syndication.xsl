<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
		xmlns="http://xmlns.escenic.com/2009/import"
		xmlns:ct="http://xmlns.escenic.com/2008/content-type"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		exclude-result-prefixes="ct">

	<xsl:output encoding="UTF-8" indent="yes" method="xml" />
	<xsl:param name="content-types"/>

	<xsl:template match="/">
		<escenic version="2.0">
			<xsl:call-template name="generate-content">
				<xsl:with-param name="content-types" select="$content-types"/>
			</xsl:call-template>
		</escenic>
	</xsl:template>
	
	<xsl:template name="generate-content">
		<xsl:param name="content-types"/>
		
		<xsl:if test="$content-types != ''">
			<xsl:variable name="content-type">
				<xsl:choose>
					<xsl:when test="contains($content-types, ',')">
						<xsl:value-of select="substring-before($content-types, ',')" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$content-types" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:apply-templates select="/ct:content-types/ct:content-type[@name=$content-type]"/>

			<xsl:if test="contains($content-types, ',')">
				<xsl:call-template name="generate-content">
					<xsl:with-param name="content-types" select="substring-before($content-types, ',')" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
