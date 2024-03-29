<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:aoc2018="http://www.beadling.co.uk/aoc2018" exclude-result-prefixes="xs map aoc2018">
    <!-- hint: Saxon 9.9.1.5, takes about 1.4sec. 
         java -classpath /usr/local/share/java/saxon9ee.jar net.sf.saxon.Transform -it -xsl:01.xslt 
        
         For Saxon-EEC1.1.2 it works out the box - runs in about 1.1sec.
         /path/to/Saxonica/Saxon-EEC1.1.2/command/transform -it -xsl:01.xslt

         See:
         https://stackoverflow.com/questions/58385867/tail-call-optimization-in-xslt-saxon -->
    
    <xsl:function name="aoc2018:find-repeated-cs">
        <xsl:param name="freqs" as="xs:integer*"/>
        <xsl:param name="cs-hash" as="map(xs:integer, xs:boolean)"/>
        <xsl:param name="cs" as="xs:integer"/>
        <xsl:param name="i" as="xs:integer"/>
        <xsl:variable name="new-cs" select="$cs + $freqs[$i]" as="xs:integer"/>
        <xsl:variable name="new-i" select="if ($i >= count($freqs))
                                           then 1 
                                           else $i + 1" as="xs:integer"/>
        <xsl:sequence select="if (map:contains($cs-hash, $new-cs))
                              then $new-cs
                              else aoc2018:find-repeated-cs($freqs, map:put($cs-hash,$new-cs,true()), $new-cs, $new-i)"/>
    </xsl:function>

    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="freqs" select="unparsed-text-lines('input.txt', 'UTF-8')!xs:integer(.)"/>
        <xsl:message select="sum($freqs)"/>
        <xsl:variable name="hash" select="map{}" as="map(xs:integer, xs:boolean)"/>
        <xsl:message select="aoc2018:find-repeated-cs($freqs, $hash, 0, 1)"/>
    </xsl:template>

</xsl:stylesheet>
