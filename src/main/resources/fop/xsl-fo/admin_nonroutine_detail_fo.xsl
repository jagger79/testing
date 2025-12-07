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

	<xsl:template match="nonroutine">

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

		<xsl:apply-templates select="definition" />

	</xsl:template>

	<xsl:template match="definition">

		<fo:table
			border="1pt solid grey"
			width="100%"
			font-size="8px"
			table-layout="fixed"
			text-align="center">

			<fo:table-column
				column-width="60mm" />
			<fo:table-column
				column-width="proportional-column-width(1)" />

			<fo:table-body>
				<fo:table-row>

					<fo:table-cell padding="1mm">
						<fo:block>
							Department
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="department/name" />
						</fo:block>
					</fo:table-cell>
					
				</fo:table-row>
				<fo:table-row>
					
					<fo:table-cell padding="1mm">
						<fo:block>
							Component
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="component" />
						</fo:block>
					</fo:table-cell>
					
				</fo:table-row>
				<fo:table-row>

					<fo:table-cell padding="1mm">
						<fo:block>
							Label
						</fo:block>
					</fo:table-cell>				
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="name" />
						</fo:block>
					</fo:table-cell>
					
				</fo:table-row>
				<fo:table-row>
				
					<fo:table-cell padding="1mm">
						<fo:block>
							2nd label
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="ULabel" />
						</fo:block>
					</fo:table-cell>
					
				</fo:table-row>
				<fo:table-row>
				
					<fo:table-cell padding="1mm">
						<fo:block>
							Position
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="position" />
						</fo:block>
					</fo:table-cell>
					
				</fo:table-row>
				<fo:table-row>

					<fo:table-cell padding="1mm">
						<fo:block>
							AC type
						</fo:block>
					</fo:table-cell>				
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="acType" />
						</fo:block>
					</fo:table-cell>
				
				</fo:table-row>
				<fo:table-row>
				
					<fo:table-cell padding="1mm">
						<fo:block>
							Optional
						</fo:block>
					</fo:table-cell>	
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="propertiesAsString" />
						</fo:block>
					</fo:table-cell>
				
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell padding="1mm">
						<fo:block>
							AC reg.
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="acreg" />
						</fo:block>
					</fo:table-cell>
				</fo:table-row>

			</fo:table-body>
		</fo:table>


	</xsl:template>

</xsl:stylesheet>


