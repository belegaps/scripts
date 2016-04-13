<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
		xmlns="http://xmlns.escenic.com/2009/import"
		xmlns:ct="http://xmlns.escenic.com/2008/content-type"
		xmlns:rep="http://xmlns.escenic.com/2009/representations"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		exclude-result-prefixes="ct rep">

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
					<xsl:with-param name="content-types" select="substring-after($content-types, ',')" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ct:content-type">
		<content type="{@name}" state="published">
			<section-ref unique-name="ece_incoming" home-section="true"/>

			<xsl:apply-templates select="ct:panel"/>
		</content>
	</xsl:template>

	<xsl:template match="ct:field[@type='link']">
		<field name="{@name}" title="">
			<xsl:comment>URI of image</xsl:comment>
		</field>
	</xsl:template>

	<xsl:template match="ct:field[@type='enumeration']">
		<field name="{@name}">
			<value>
				<xsl:comment>
					<xsl:text> One of: </xsl:text>
					<xsl:for-each select="ct:enumeration">
						<xsl:value-of select="concat(@value, ', ')" />
					</xsl:for-each>
					<xsl:text> </xsl:text>
				</xsl:comment>
			</value>
		</field>
	</xsl:template>

	<xsl:template match="ct:field[ct:array]">
		<field name="{@name}">
			<value>
				<xsl:comment>Array value</xsl:comment>
			</value>
		</field>
	</xsl:template>

	<xsl:template match="ct:field[@mime-type='application/json']">
		<field name="{@name}">
			<xsl:apply-templates select="rep:representations"/>
		</field>
	</xsl:template>

	<xsl:template match="rep:representations">
		<xsl:text>{</xsl:text>
		<xsl:apply-templates select="rep:representation"/>
		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template match="rep:representation">
		<xsl:value-of select="concat('&quot;', @name, '&quot;: {')"/>
		<xsl:text>}, </xsl:text>
	</xsl:template>

	<xsl:template match="ct:field">
		<field name="{@name}"/>
	</xsl:template>

	<xsl:template match="ct:ref-field-group">
		<xsl:apply-templates select="/ct:content-types/ct:field-group[@name=current()/@name]"/>
	</xsl:template>

	<xsl:template match="ct:*">
		<xsl:apply-templates select="*"/>
	</xsl:template>

	<xsl:template match="*"/>

</xsl:stylesheet>
