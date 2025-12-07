<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:java="http://xml.apache.org/xslt/java"
	version="1.0">

	<xsl:import href="xsl-fo/common_fo.xsl" />
	<xsl:import href="xsl-fo/groundtimes_common_fo.xsl" />

	<xsl:template match="/zeussevents">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Zeuss Events'" />
		</xsl:call-template>

		<xsl:apply-templates select="events/event" />

	</xsl:template>

	<xsl:template match="event" >

		<fo:table
			space-after="5mm"
			width="95%"
			font-size="8"
			background-color="#E5E5E5"
			table-layout="fixed"
			border="1pt solid grey"
			space-before.conditionality="retain"
			display-align="center"
			keep-together="always">

			<fo:table-column column-width="1.5cm" />
			<fo:table-column column-width="2cm" />
			<fo:table-column column-width="2cm" />
			<fo:table-column column-width="1.5cm" />
			<fo:table-column column-width="2cm" />
			<fo:table-column column-width="2cm" />
			<fo:table-column column-width="2cm" />
			<fo:table-column column-width="1.5cm" />

			<fo:table-column  column-width="proportional-column-width(1)"/>			
																					
			<fo:table-body>

				<fo:table-row text-align="center">
					<!-- picture of plane -->
					<fo:table-cell background-color="white">
						<fo:block></fo:block>
					</fo:table-cell>

					<fo:table-cell
						border="1pt solid white"
						number-columns-spanned="7"
						color="white"
						background-color="darkblue"
						padding="1mm">
						<fo:block></fo:block>
					</fo:table-cell>

					<fo:table-cell
						border="1pt solid white"
						color="white"
						background-color="darkblue"
						padding="1mm">
						<fo:block>Summary</fo:block>
					</fo:table-cell>

				</fo:table-row>

				<fo:table-row text-align="center">

					<fo:table-cell
						border="1pt solid white"
						background-color="white">
						<fo:block>
							<xsl:value-of select="acReg" />
						</fo:block>
						<fo:block>
							<xsl:value-of select="checkName" />
						</fo:block>
					</fo:table-cell>

					<xsl:call-template name="groundtime-core" />

					<fo:table-cell border="1pt solid white">
						<fo:block font-weight="bold">P</fo:block>
						<fo:block>
							<xsl:value-of
								select="format-number(planned,'0.0')" />
						</fo:block>
					</fo:table-cell>

				</fo:table-row>

			</fo:table-body>
		</fo:table>

	</xsl:template>

</xsl:stylesheet>
