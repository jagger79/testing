<?xml version="1.0" encoding="UTF-8"?>
<!--
	/**
	* Serves for layout of the page.
	*
	* @author Roman Krejci
	* @version 1.0
	* 
	* date: Mar 18, 2007
	*/
-->

<!DOCTYPE xsl:stylesheet [
        <!ENTITY nbsp "&#160;">
        ]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <xsl:output omit-xml-declaration="no" indent="no"/>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-portrait"
                                       page-height="29.7cm" page-width="21cm" margin-top="0.5cm"
                                       margin-bottom="1cm" margin-left="3mm" margin-right="3mm">

                    <fo:region-body margin-top="5cm" margin-bottom="3mm"
                                    margin-left="0mm" margin-right="0mm"/>

                    <fo:region-before extent="20mm"/>
                    <!-- šířka vyplněné oblasti -->
                    <fo:region-after extent="20mm"/>
                    <fo:region-start extent="0mm"/>
                    <fo:region-end extent="0mm"/>

                </fo:simple-page-master>

                <fo:simple-page-master master-name="A4_Landscape"
                                       page-height="21cm" page-width="29.7cm" margin-top="5mm"
                                       margin-bottom="5mm" margin-left="3mm" margin-right="3mm">

                    <fo:region-body margin-top="13mm"
                                    margin-bottom="0mm" margin-left="0mm" margin-right="0mm"/>

                    <fo:region-before extent="20mm"/>
                    <!-- šířka vyplněné oblasti -->
                    <fo:region-after extent="20mm"/>
                    <fo:region-start extent="0mm"/>
                    <fo:region-end extent="0mm"/>

                </fo:simple-page-master>

            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4-portrait">

                <fo:static-content flow-name="xsl-region-before">
                    <!-- here should be top = HEADER -->

                    <fo:table width="100%" height="10mm"
                              table-layout="fixed">

                        <fo:table-column column-width="50%"/>
                        <fo:table-column column-width="50%"/>

                        <fo:table-body>

                            <fo:table-row>
                                <fo:table-cell text-align="left">
                                    <fo:block>
                                        <fo:external-graphic
                                                src="url(/img/vodafone.png)"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell text-align="right">
                                    <fo:block>
                                        <fo:external-graphic
                                                src="url(img/logos/lht_logo.jpg)"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                        </fo:table-body>
                    </fo:table>

                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <!-- here should be bootom = FOOTER -->
                    <fo:block/>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <!-- here is BODY -->
                    <fo:block font-size="11pt">
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:flow>

            </fo:page-sequence>
        </fo:root>

    </xsl:template>

    <!-- ================= Template for page header          =============== -->

    <xsl:template name="header">

        <xsl:param name="caption"/>
        <xsl:param name="userInfo"/>

        <fo:table table-layout="fixed" width="100%" space-after="0.5cm">

            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="25%"/>
            <fo:table-column column-width="25%"/>

            <fo:table-body>

                <fo:table-row>
                    <fo:table-cell number-rows-spanned="3" text-align="center" display-align="center">
                        <fo:block>
                            <xsl:value-of select="$caption"/>
                        </fo:block>
                    </fo:table-cell>

                    <fo:table-cell>
                        <fo:block>Name:</fo:block>
                    </fo:table-cell>

                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$userInfo/firstName"/>
                            <xsl:value-of select="$userInfo/lastName"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

                <fo:table-row>

                    <fo:table-cell column-number="2">
                        <fo:block>Department / Workgroup</fo:block>
                    </fo:table-cell>

                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$userInfo/department/name"/> /
                            <xsl:value-of select="$userInfo/workgroup/name"/>
                        </fo:block>
                    </fo:table-cell>

                </fo:table-row>

                <fo:table-row>

                    <fo:table-cell column-number="2">
                        <fo:block>Shift:</fo:block>
                    </fo:table-cell>

                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$userInfo/shift/name"/> /
                            <xsl:value-of select="$userInfo/shift/shiftDate"/>
                        </fo:block>
                    </fo:table-cell>

                </fo:table-row>

            </fo:table-body>
        </fo:table>
    </xsl:template>

    <!-- ================= Template for rendering a header =============== -->
    <xsl:template name="header_orange">
        <xsl:param name="left"/>
        <xsl:param name="right"/>

        <fo:table table-layout="fixed" width="100%">

            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="50%"/>

            <fo:table-body>

                <fo:table-row color="white" background-color="orange"
                              font-weight="bold" height="5mm">

                    <fo:table-cell text-align="left"
                                   display-align="center" padding-left="1.5mm">
                        <fo:block>
                            <xsl:value-of select="$left"/>
                        </fo:block>
                    </fo:table-cell>

                    <fo:table-cell text-align="right"
                                   display-align="center" padding-right="1.5mm">
                        <fo:block>
                            <xsl:value-of select="$right"/>
                        </fo:block>
                    </fo:table-cell>

                </fo:table-row>

            </fo:table-body>
        </fo:table>

    </xsl:template>


    <!-- ================= Template for rendering a blue header =============== -->
    <xsl:template name="header_blue_jobs">

        <fo:table-row color="white" background-color="darkblue"
                      font-weight="bold" height="4mm">

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Pos</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Work No/Text/Remarks</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Mat/Info</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Status/DT</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block/>
            </fo:table-cell>

            <xsl:for-each
                    select="jobitem[position() = 1]/professions/profession">
                <fo:table-cell text-align="center"
                               display-align="center">
                    <fo:block>
                        <xsl:value-of select="professionName"/>
                    </fo:block>
                </fo:table-cell>
            </xsl:for-each>

        </fo:table-row>

    </xsl:template>

    <!-- ============ Template for rendering a blue header for nonroutines ======== -->
    <xsl:template name="header_blue_jobs_nr">

        <fo:table-row color="white" background-color="darkblue"
                      font-weight="bold" height="4mm">

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Section</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Reference/Text</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Mat/Info</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Status/DT</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block/>
            </fo:table-cell>

            <xsl:for-each
                    select="jobitem[position() = 1]/professions/profession">
                <fo:table-cell text-align="center"
                               display-align="center">
                    <fo:block>
                        <xsl:value-of select="professionName"/>
                    </fo:block>
                </fo:table-cell>
            </xsl:for-each>

        </fo:table-row>

    </xsl:template>

    <!-- ============ Template for rendering a blue header for support ======== -->
    <xsl:template name="header_blue_jobs_support">

        <fo:table-row color="white" background-color="darkblue"
                      font-weight="bold" height="4mm">

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Type</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block>Work done</fo:block>
            </fo:table-cell>

            <fo:table-cell text-align="center" display-align="center">
                <fo:block/>
            </fo:table-cell>

        </fo:table-row>

    </xsl:template>

</xsl:stylesheet>
