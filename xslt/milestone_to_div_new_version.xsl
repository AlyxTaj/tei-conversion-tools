<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" >
    <xsl:output method="xml" encoding="UTF-8" exclude-result-prefixes="#all"/>
    <xsl:template match="node()|@*|comment()">
        <!-- Copy the current node -->
        <xsl:copy>
            <!-- Including any child nodes it has and any attributes -->
            <xsl:apply-templates select="node()|@*|comment()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="div">
        <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@n" />
            <xsl:attribute name="type">textpart</xsl:attribute>
            <xsl:attribute name="subtype" select="current()/@type" />
            <xsl:for-each-group select="node()" group-starting-with="milestone">
                <div xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:sequence select="current()/@n"/>
                    <xsl:attribute name="type">textpart</xsl:attribute>
                    <xsl:attribute name="subtype">card</xsl:attribute>
                    <xsl:apply-templates select="current-group()[not(self::milestone)]"/>
                </div>
            </xsl:for-each-group>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
