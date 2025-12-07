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

	<xsl:template match="nonroutines">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Nonroutine definitions'" />
		</xsl:call-template>

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Nonroutine definitions'" />
			<xsl:with-param
				name="right"
				select="''" />
		</xsl:call-template>

		<xsl:apply-templates select="definitions" />

	</xsl:template>

	<xsl:template match="definitions">

		<fo:table
			border="1pt solid grey"
			width="100%"
			font-size="8px"
			table-layout="fixed"
			text-align="center">

			<fo:table-column column-width="20mm	" />
			<fo:table-column column-width="40mm" />
			<fo:table-column column-width="20mm	" />
			<fo:table-column
				column-width="proportional-column-width(1)" />
			<fo:table-column column-width="20mm	" />
			<fo:table-column column-width="20mm	" />
			<fo:table-column
				column-width="proportional-column-width(1)" />
			<fo:table-column column-width="20mm	" />


			<fo:table-header>
				<fo:table-row
					background-color="darkblue"
					color="white"
					height="5mm"
					display-align="center"
					text-align="center">

					<fo:table-cell>
						<fo:block>Department</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Component</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Label</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>2nd label</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Position</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>AC type</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Optional</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>AC Reg</fo:block>
					</fo:table-cell>

				</fo:table-row>

			</fo:table-header>
			<fo:table-body>
				<xsl:choose>
					<xsl:when test="definition">
						<xsl:apply-templates select="definition" />
					</xsl:when>
					<xsl:otherwise>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:otherwise>
				</xsl:choose>
			</fo:table-body>
		</fo:table>


	</xsl:template>

	<xsl:template match="definition">

		<fo:table-row>

			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="department/name" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="component" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="name" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="ULabel" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="position" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="acType" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="propertiesAsString" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="acreg" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>


</xsl:stylesheet>


