<?xml version="1.0" encoding="UTF-8"?>


<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0"
	fo:schemaLocation="/xsd/fop.xsd">

	<xsl:import href="xsl-fo/common_fo.xsl" />

	<xsl:include href="xsl-fo/record_various_fo.xsl" />

	<xsl:template match="/shiftloadjobs">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Schichtübergabeblatt'" />
		</xsl:call-template>

		<xsl:if test="aircrafts/aircraft">
			<xsl:apply-templates select="aircrafts" />
		</xsl:if>

		<xsl:if test="workshops/workshopjob">
			<xsl:apply-templates select="workshops" />
		</xsl:if>
	
	
		<xsl:apply-templates select="various" />
	
	</xsl:template>

	<xsl:template name="catalog">

		<xsl:param name="count" />
		<xsl:param name="max" />

		<xsl:if test="$count &lt;= $max">

			<fo:table-cell border="1pt solid grey">
				<xsl:choose>
					<xsl:when
						test="catalogs/catalog[position = $count]">
						<fo:block>
							<xsl:value-of
								select="catalogs/catalog[position = $count]/hours" />
						</fo:block>
					</xsl:when>
					<xsl:otherwise>
						<fo:block>0</fo:block>
					</xsl:otherwise>
				</xsl:choose>
			</fo:table-cell>

			<xsl:call-template name="catalog">
				<xsl:with-param
					name="count"
					select="$count + 1" />
				<xsl:with-param
					name="max"
					select="$max" />
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<xsl:template match="aircrafts">

		<fo:table
			space-after="2cm"
			width="95%"
			font-size="8"
			table-layout="fixed">

			<fo:table-column />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="6cm" />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />

			<fo:table-header
				space-after="0.5cm"
				display-align="center">

				<fo:table-row>
					<fo:table-cell
						number-columns-spanned="3"
						border="1pt solid grey">
						<fo:block>Registration</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="3"
						text-align="center"
						border="1pt solid grey">
						<fo:block>Soll</fo:block>
					</fo:table-cell>

					<fo:table-cell
						text-align="center"
						border="1pt solid grey"
						number-columns-spanned="7">
						<fo:block></fo:block>
					</fo:table-cell>
				</fo:table-row>

				<fo:table-row text-align="center">

					<fo:table-cell>
						<fo:block></fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>Work Order</fo:block>
						<fo:block>Reference No</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>Beschreibung</fo:block>
						<fo:block>Auftrag/Beanstandung</fo:block>
					</fo:table-cell>

					<fo:table-cell
						column-number="5"
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>(1)</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>(2)</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>(3)</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>(4)</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>(5)</fo:block>
					</fo:table-cell>


					<fo:table-cell
						column-number="10"
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>Bemerkung</fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-rows-spanned="2"
						border="1pt solid grey">
						<fo:block>MA-Name</fo:block>
					</fo:table-cell>

				</fo:table-row>

				<fo:table-row>

					<fo:table-cell>
						<fo:block></fo:block>
					</fo:table-cell>

				</fo:table-row>

			</fo:table-header>

			<fo:table-body display-align="center">

				<xsl:for-each select="aircraft">

					<fo:table-row
						text-align="center"
						keep-with-next="always">
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="acreg" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

					<xsl:choose>
						<xsl:when test="jobs/job[highlight = 'true']">

							<xsl:for-each
								select="jobs/job[highlight = 'true']">

								<fo:table-row
									text-align="center"
									keep-with-next="always">

									<fo:table-cell>
										<fo:block></fo:block>
									</fo:table-cell>

									<fo:table-cell
										border="1pt solid grey">
										<fo:block>
											<xsl:value-of
												select="workno" />
										</fo:block>
									</fo:table-cell>

									<fo:table-cell
										border="1pt solid grey">
										<fo:block>
											<xsl:value-of select="text" />
										</fo:block>
									</fo:table-cell>

									<fo:table-cell
										border="1pt solid grey">
										<fo:block>
											<xsl:value-of
												select="planhours" />
										</fo:block>
									</fo:table-cell>

									<xsl:call-template name="catalog">
										<xsl:with-param
											name="count"
											select="1" />
										<xsl:with-param
											name="max"
											select="5" />
									</xsl:call-template>

									<fo:table-cell
										border="1pt solid grey">
										<fo:block>
											<xsl:value-of
												select="remarks" />
										</fo:block>
									</fo:table-cell>

									<fo:table-cell
										border="1pt solid grey">
										<fo:block>
											<xsl:value-of
												select="shortinfo" />
										</fo:block>
									</fo:table-cell>

								</fo:table-row>

							</xsl:for-each>

							<fo:table-row>

								<fo:table-cell
									column-number="2"
									number-columns-spanned="2"
									border="1pt solid grey">
									<fo:block>
										Kurzzeitbeanstandunggen &lt; 2h
										gesamt =
										<xsl:variable
											name="small"
											select="sum(jobs/job/catalogs/catalog[position = 6]/hours)" />
										<xsl:value-of
											select="floor($small)" />
										<xsl:text>:</xsl:text>
										<xsl:value-of
											select="format-number( ($small - round($small)) * 60, '00')" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell column-number="10">
									<fo:block>

									</fo:block>
								</fo:table-cell>

								<fo:table-cell column-number="11">
									<fo:block></fo:block>
								</fo:table-cell>

							</fo:table-row>
							
						</xsl:when>
						<xsl:otherwise>
							<fo:table-row>
								<fo:table-cell
									number-columns-spanned="11">
									<fo:block>
										<xsl:value-of select="'There are no jobs for this aircraft'" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:otherwise>
					</xsl:choose>

					<fo:table-row>
						<fo:table-cell
							number-columns-spanned="11"
							height="0.5cm">
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>

				</xsl:for-each>

			</fo:table-body>

		</fo:table>

	</xsl:template>

	<xsl:template match="workshops">

		<fo:table
			space-after="2cm"
			width="95%"
			font-size="8"
			table-layout="fixed"
			display-align="center">

			<fo:table-column />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="6cm" />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />

			<fo:table-header
				space-after="0.5cm"
				display-align="center">

	
				<fo:table-row>
					<fo:table-cell
						number-columns-spanned="11"
						column-number="1"
						border="1pt solid grey">
						<fo:block>Werkstattaufträge</fo:block>
					</fo:table-cell>
				</fo:table-row>

				<fo:table-row text-align="center">
					<fo:table-cell
						column-number="2"
						border="1pt solid grey">
						<fo:block>CS - Auftrag</fo:block>
					</fo:table-cell>

					<fo:table-cell
						column-number="3"
						border="1pt solid grey">
						<fo:block>Beschreibung</fo:block>
					</fo:table-cell>

					<fo:table-cell
						column-number="5"
						number-columns-spanned="5"
						border="1pt solid grey">
						<fo:block>Ist</fo:block>
					</fo:table-cell>

					<fo:table-cell
						column-number="10"
						border="1pt solid grey">
						<fo:block>Bemerkung</fo:block>
					</fo:table-cell>

					<fo:table-cell
						column-number="11"
						border="1pt solid grey">
						<fo:block>MA-Name</fo:block>
					</fo:table-cell>
				</fo:table-row>

			</fo:table-header>

			<fo:table-body>

				<xsl:for-each select="workshopjob">
					<fo:table-row text-align="center">
						<fo:table-cell
							column-number="2"
							border="1pt solid grey">
							<fo:block>
								<xsl:value-of select="aun" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell
							column-number="3"
							border="1pt solid grey">
							<fo:block>
								<xsl:value-of select="shorttext" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell
							column-number="5"
							number-columns-spanned="5"
							border="1pt solid grey">
							<fo:block>
								<xsl:value-of
									select="format-number(seconds div 3600,'0.00')" />
							</fo:block>
						</fo:table-cell>

						<fo:table-cell
							column-number="10"
							border="1pt solid grey">
							<fo:block>
								<xsl:value-of select="remarks" />
							</fo:block>
						</fo:table-cell>

						<fo:table-cell
							column-number="11"
							border="1pt solid grey">
							<fo:block>
								<xsl:value-of select="shortinfo" />
							</fo:block>
						</fo:table-cell>

					</fo:table-row>
				</xsl:for-each>

			</fo:table-body>
		</fo:table>

	</xsl:template>


</xsl:stylesheet>
