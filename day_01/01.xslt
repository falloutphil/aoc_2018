<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:map="http://www.w3.org/2005/xpath-functions/map"  exclude-result-prefixes="xs map">
    <!-- hint: Saxon 9.9.1.5 works. java -classpath /usr/local/share/java/saxon9ee.jar net.sf.saxon.Transform -it -xsl:01.xslt -->
    
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template name="xsl:initial-template">
        <xsl:variable name="freqs" select="unparsed-text-lines('input.txt', 'UTF-8')!xs:integer(.)"/>
        <xsl:message select="sum($freqs)"/>
        <xsl:variable name="hash" select="map{}" as="map(xs:integer, xs:boolean)"/>        
        <xsl:call-template name="find-repeated-cs">
            <xsl:with-param name="freqs" select="$freqs"/>
            <xsl:with-param name="cs-hash" select="$hash"/>
        </xsl:call-template>        
    </xsl:template>

    <xsl:template name="find-repeated-cs">
        <xsl:param name="freqs" as="xs:integer*"/>
        <xsl:param name="cs-hash" as="map(xs:integer, xs:boolean)"/>
        <xsl:param name="cs" select="0" as="xs:integer"/>
        <xsl:param name="i" select="1" as="xs:integer"/>
        <xsl:variable name="new-cs" select="$cs + $freqs[$i]" as="xs:integer"/>
        <xsl:variable name="new-i" select="if ($i >= count($freqs)) then 1 else $i + 1" as="xs:integer"/>
        <xsl:choose>
            <xsl:when test="map:contains($cs-hash, $new-cs)">
                <xsl:value-of select="$new-cs"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="find-repeated-cs">
                    <xsl:with-param name="freqs" select="$freqs"/>
                    <xsl:with-param name="cs-hash" select="map:put($cs-hash,$new-cs,true())"/>
                    <xsl:with-param name="cs" select="$new-cs"/>
                    <xsl:with-param name="i" select="$new-i"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
