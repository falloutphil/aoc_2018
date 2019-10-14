<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aoc2018="http://www.beadling.co.uk/aoc2018" exclude-result-prefixes="xs aoc2018">
        <!-- hint: java -classpath /usr/local/share/java/saxon9ee.jar net.sf.saxon.Transform -it -xsl:01.xslt -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template name="xsl:initial-template">
		<xsl:variable name="freqs" select="unparsed-text-lines('input.txt', 'UTF-8')!xs:integer(.)"/>
		<xsl:value-of select="sum($freqs)"/>
	</xsl:template>
</xsl:stylesheet>
