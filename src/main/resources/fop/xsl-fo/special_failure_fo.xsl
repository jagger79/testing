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

	<xsl:template match="/failureList">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Zeuss Events'" />
		</xsl:call-template>


		<xsl:apply-templates select="failures" />

	</xsl:template>

	<xsl:template match="failures">
		
		<xsl:apply-templates select="failure" />

	</xsl:template>

	<xsl:template match="failure">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="acReg" />
			<xsl:with-param
				name="right"
				select="''" />
		</xsl:call-template>

		<fo:table
			border="1pt solid grey"
			width="100%"
			font-size="8px"
			table-layout="fixed">

			<fo:table-column column-width="20mm	" />
			<fo:table-column column-width="40mm" />
			<fo:table-column
				column-width="proportional-column-width(1)" />
			<fo:table-column
				column-width="proportional-column-width(1)" />
			<fo:table-column
				column-width="proportional-column-width(1)" />
			<fo:table-column column-width="40mm" />
			<fo:table-column column-width="40mm" />
			<fo:table-column column-width="40mm" />

			<fo:table-header>

				<fo:table-row
					background-color="darkblue"
					color="white"
					height="5mm"
					display-align="center"
					text-align="center">
					<fo:table-cell>
						<fo:block>Pos</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Work.No.</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Text</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Date</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Reason</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>CS AUN</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>WG</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block></fo:block>
					</fo:table-cell>

				</fo:table-row>
			</fo:table-header>

			<fo:table-body>
				<xsl:for-each select="failureJobs/failureJob">
					<fo:table-row
						display-align="center"
						text-align="center">
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="position()" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="workNumber" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="text" />
							</fo:block>
						</fo:table-cell>
						<!-- date not implemented -->
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="date" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="errorReason" />
							</fo:block>
						</fo:table-cell>
						
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="aun" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="wg" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="professions/profession[position() = 1]/professionName" />
								P
								<xsl:text> </xsl:text>
								<xsl:value-of select="professions/profession[position() = 1]/planHours" />
								
							</fo:block>
						</fo:table-cell>						
					</fo:table-row>
				</xsl:for-each>
			</fo:table-body>

		</fo:table>

	</xsl:template>




</xsl:stylesheet>


