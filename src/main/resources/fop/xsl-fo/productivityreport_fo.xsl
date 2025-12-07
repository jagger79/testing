<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0"
	fo:schemaLocation="/xsd/fop.xsd">

	<xsl:include href="xsl-fo/common_fo.xsl" />

	<xsl:template match="/productivityreport">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Productivity Report'" />
		</xsl:call-template>

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Productivity Report'" />
			<xsl:with-param
				name="right"
				select="''" />
		</xsl:call-template>

		<fo:table
			border="1pt solid grey"
			width="100%"
			font-size="8px"
			table-layout="fixed"
			text-align="center">

			<fo:table-column column-width="40mm	" />
			<fo:table-column column-width="40mm	" />
			<fo:table-column column-width="40mm	" />

			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							From:
							<xsl:value-of select="dateFrom" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							To:
							<xsl:value-of select="dateTo" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							Target:
							<xsl:value-of select="target" />
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>


		<xsl:variable name="productivity">
			<xsl:text>http://lww-b.lht.fra.dlh.de:2005/?@_FILEzeuss/productivity.pcxml@_PCSCRIPT</xsl:text>
			<xsl:value-of select="productivity" /><xsl:text>@_JPEG</xsl:text>
		</xsl:variable>
		
		<fo:external-graphic content-width="27cm" >
			<xsl:attribute name="src">
				<xsl:value-of select="$productivity" />
			</xsl:attribute>
		</fo:external-graphic>		

	</xsl:template>
</xsl:stylesheet>


