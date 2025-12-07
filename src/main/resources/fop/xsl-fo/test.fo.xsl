<?xml version="1.0" encoding="utf-8"?>

<!DOCTYPE xsl:stylesheet [
        <!ENTITY nbsp "&#160;">
        ]>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                fo:schemaLocation="/xsd/fop.xsd">

    <xsl:include href="common_fo.xsl"/>

    <!--    <xsl:output method="xml" indent="yes"/>-->
    <xsl:template match="name">
        <xsl:call-template name="header">
            <xsl:with-param
                    name="userInfo"
                    select="userInfo"/>
            <xsl:with-param
                    name="caption"
                    select="'Others Report'"/>
        </xsl:call-template>

        <!--            <fo:layout-master-set>-->
        <!--                <fo:simple-page-master master-name="A4-portrait"-->
        <!--                                       page-height="29.7cm" page-width="21.0cm" margin="2cm">-->
        <!--                    <fo:region-body/>-->
        <!--                </fo:simple-page-master>-->
        <!--            </fo:layout-master-set>-->
        <fo:block>
            Hello, <xsl:value-of select="."/>!
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
