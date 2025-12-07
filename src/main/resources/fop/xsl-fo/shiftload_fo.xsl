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

	<xsl:include href="xsl-fo/record_detail_fo.xsl" />

	<xsl:template match="/shiftloadjobs">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Shiftload'" />
		</xsl:call-template>

		<xsl:apply-templates select="/shiftloadjobs/planning" />
		
		<xsl:apply-templates select="/shiftloadjobs/mramp" />

		<xsl:apply-templates select="/shiftloadjobs/acWork" />
		
		<xsl:apply-templates select="/shiftloadjobs/various" />

		<xsl:apply-templates select="/shiftloadjobs/nonAcWork" />

	</xsl:template>


	<xsl:template match="planning">
		<fo:table
			table-layout="fixed"
			width="100%"
			space-after="10mm">

			<fo:table-column column-width="25%" />
			<fo:table-column column-width="35%" />
			<fo:table-column column-width="35%" />

			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:apply-templates
								select="presence" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<xsl:apply-templates
							select="assistance" />
					</fo:table-cell>
					<fo:table-cell>
						<xsl:call-template name="planningTotal" />
					</fo:table-cell>

				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<xsl:template match="presence">

		<fo:table
			width="100%"
			table-layout="fixed"
			font-size="8px"
			text-align="center"
			display-align="center">

			<fo:table-column column-width="33mm" />
			<fo:table-column column-width="13mm" />
			<fo:table-column column-width="20mm" />

			<fo:table-header>

				<fo:table-row
					height="5mm"
					color="white"
					background-color="darkblue"
					font-weight="bold">
					<fo:table-cell>
						<fo:block>Presence</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Number</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Amount</fo:block>
					</fo:table-cell>
				</fo:table-row>

			</fo:table-header>

			<fo:table-body>
				<xsl:for-each select="presenceItem">
					<fo:table-row>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="name" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="amount" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of
									select="format-number(hours,'0.0')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
				<fo:table-row>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="'Total'" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="sum(presenceItem/amount)" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="format-number(sum(presenceItem/hours),'0.0')" />
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="'Ares'" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="'0'" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="'0'" />
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>

	</xsl:template>

	<xsl:template match="assistance">

		<fo:table
			width="100%"
			table-layout="fixed"
			margin-left="5mm"
			margin-right="5mm"
			font-size="8px"
			text-align="center"
			display-align="center">

			<fo:table-column column-width="25mm" />
			<fo:table-column column-width="20mm" />

			<fo:table-column column-width="10mm" />
			<fo:table-column column-width="3mm" />
			<fo:table-column column-width="15mm" />
			<fo:table-column column-width="20mm" />

			<fo:table-header>

				<fo:table-row
					color="white"
					height="5mm"
					background-color="darkblue"
					font-weight="bold">
					<fo:table-cell>
						<fo:block>Help.hands</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Number</fo:block>
					</fo:table-cell>
					<fo:table-cell number-columns-spanned="3">
						<fo:block>Amount</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Dist</fo:block>
					</fo:table-cell>
				</fo:table-row>

			</fo:table-header>

			<fo:table-body>

				<xsl:for-each select="assistanceItem">
					<fo:table-row>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="helpWg/name" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="amount" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of
									select="format-number(hours,'0.0')" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:text>/</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of select="helpingHandsSum" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1mm">
							<fo:block>
								<xsl:value-of
									select="format-number(distribute, '0.0')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

				</xsl:for-each>

				<fo:table-row>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="'Total'" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="format-number(sum(assistanceItem/amount), '0.0')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="format-number(sum(assistanceItem/hours), '0.0')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:text>/</xsl:text>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="format-number(sum(assistanceItem/helpingHandsSum), '0.0')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="format-number(sum(assistanceItem/distribute), '0.0')" />
						</fo:block>
					</fo:table-cell>

				</fo:table-row>

			</fo:table-body>

		</fo:table>

	</xsl:template>

	<xsl:template name="planningTotal">

		<fo:table
			table-layout="fixed"
			width="100%"
			margin-left="10mm"
			font-size="8px"
			text-align="center"
			display-align="center">

			<fo:table-column column-width="10mm" />
			<fo:table-column column-width="15mm" />
			<fo:table-column column-width="15mm" />
			<fo:table-column column-width="15mm" />

			<fo:table-header>
				<fo:table-row
					color="white"
					background-color="darkblue"
					height="5mm"
					font-weight="bold">
					<fo:table-cell>
						<fo:block></fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Planned</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Recorded</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Difference</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>

			<fo:table-body>
				<fo:table-row>
					<fo:table-cell padding="1mm">
						<fo:block>WG</fo:block>
					</fo:table-cell>
					<xsl:variable
						name="planned"
						select="format-number(sum(presence/presenceItem/hours), '0.0')" />
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of select="$planned" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block padding="1mm">
							<xsl:value-of
								select="format-number(recordedHours, '0.0')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1mm">
						<fo:block>
							<xsl:value-of
								select="$planned - number(aresHours)" />
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>

	</xsl:template>

	<xsl:template match="acWork">

		<fo:table
			table-layout="fixed"
			width="100%"
			font-size="8px"
			text-align="center"
			display-align="center"
			border="1pt solid grey"
			space-after="10mm">

			<fo:table-column column-width="50%" />
			<fo:table-column column-width="50%" />

			<xsl:call-template name="acWorkHeader">
				<xsl:with-param
					name="caption"
					select="'DLH'" />
			</xsl:call-template>

			<fo:table-body>
				<xsl:choose>
					<xsl:when test="dlhAircrafts/aircraft">
						<xsl:for-each select="dlhAircrafts/aircraft">

							<xsl:apply-templates
								select="aircraftSummary" />
							<xsl:apply-templates select="aircraftJobs" />

						</xsl:for-each>
					</xsl:when>
					<!-- empty row to have valid table -->
					<xsl:otherwise>
						<fo:table-row>
							<fo:table-cell>
								<fo:block></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:otherwise>
				</xsl:choose>

			</fo:table-body>
		</fo:table>

		<fo:table
			table-layout="fixed"
			width="100%"
			border="1pt solid grey"
			font-size="8px"
			text-align="center"
			display-align="center"
			space-after="10mm">

			<fo:table-column column-width="50%" />
			<fo:table-column column-width="50%" />

			<xsl:call-template name="acWorkHeader">
				<xsl:with-param
					name="caption"
					select="'Customer'" />
			</xsl:call-template>

			<fo:table-body>

				<xsl:choose>
					<xsl:when test="customerAircrafts/aircraft">					
						<xsl:for-each
							select="customerAircrafts/aircraft">
							
								<xsl:apply-templates
									select="aircraftSummary" />
								<xsl:apply-templates
									select="aircraftJobs" />

						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-row>
							<fo:table-cell>
								<fo:block></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:otherwise>
				</xsl:choose>
			</fo:table-body>
		</fo:table>


	</xsl:template>

	<xsl:template name="acWorkHeader">

		<xsl:param name="caption" />

		<fo:table-header>
			<fo:table-row
				color="white"
				background-color="orange"
				font-weight="bold"
				height="5mm"
				text-align="center">
				<fo:table-cell padding="1mm">
					<fo:block>
						<xsl:value-of select="$caption" />
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
		</fo:table-header>


	</xsl:template>

	<xsl:template match="aircraftSummary">
		<fo:table-row
			color="white"
			background-color="darkblue"
			border="1pt solid grey"
			font-weight="bold">
			<fo:table-cell padding="1mm">
				<fo:block>
					<xsl:value-of select="acreg" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell padding="1mm">
				<fo:block>
					P:
					<xsl:value-of
						select="format-number(hoursSummary/planHours, '0.0')" />
					A:
					<xsl:value-of
						select="format-number(hoursSummary/currentHours, '0.0')" />
					R:
					<xsl:value-of
						select="format-number(hoursSummary/remainingHours, '0.0')" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="nonAcWork">

		<xsl:variable name="sumNonAcWork">
			E:
			<xsl:value-of select="summaryNonAcJobs/planHours" />
			A:
			<xsl:value-of select="summaryNonAcJobs/currentHours" />
			R:
			<xsl:value-of select="summaryNonAcJobs/remainingHours" />
		</xsl:variable>

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Non Ac. related work'" />
			<xsl:with-param
				name="right"
				select="$sumNonAcWork" />
		</xsl:call-template>

		<fo:table
			width="100%"
			font-size="8px"
			table-layout="fixed"
			border="1pt solid grey"
			space-after="10mm">

			<fo:table-column column-width="100mm" />
			<fo:table-column column-width="20mm" />

			<xsl:for-each select="//nonAcWork/professions/profession">
				<fo:table-column
					column-width="proportional-column-width(1)" />
			</xsl:for-each>

			<fo:table-header text-align="center">

				<fo:table-row
					background-color="darkblue"
					color="white"
					height="7mm"
					display-align="center"
					text-align="center">

					<fo:table-cell border="1pt solid white">
						<fo:block>Text</fo:block>
					</fo:table-cell>

					<fo:table-cell border="1pt solid white">
						<fo:block></fo:block>
					</fo:table-cell>

					<xsl:for-each
						select="//nonAcWork/professions/profession">
						<fo:table-cell border="1pt solid white">
							<fo:block>
								<xsl:value-of select="." />
							</fo:block>
						</fo:table-cell>
					</xsl:for-each>
				</fo:table-row>
			</fo:table-header>

			<fo:table-body>
				<xsl:choose>
					<xsl:when test="nonAcJobs/nonAcJob">

						<xsl:for-each select="nonAcJobs/nonAcJob">
							<fo:table-row text-align="center">

								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="text" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell>
									<fo:block>A</fo:block>
								</fo:table-cell>

								<xsl:call-template
									name="nonacreg_hours">
									<xsl:with-param
										name="item_hours"
										select="professions" />
								</xsl:call-template>

							</fo:table-row>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-row>
							<fo:table-cell>
								<fo:block></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:otherwise>
				</xsl:choose>
			</fo:table-body>

		</fo:table>

	</xsl:template>

	<xsl:template name="nonacreg_hours">

		<xsl:param name="item_hours" />

		<xsl:for-each select="//nonAcWork/professions/profession">
			<xsl:call-template name="nonAcWork_hours_cell">
				<xsl:with-param
					name="item_hours"
					select="$item_hours" />
				<xsl:with-param
					name="profession"
					select="." />
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="nonAcWork_hours_cell">

		<xsl:param name="item_hours" />
		<xsl:param name="profession" />


		<fo:table-cell background-color="#E5E5E5">

			<xsl:choose>
				<xsl:when
					test="$item_hours/profession[professionName = $profession]">
					<fo:block>
						<xsl:value-of
							select="$item_hours/profession[professionName = $profession]/currentHours" />
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block>
						<xsl:value-of select="'0'" />
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:table-cell>
	</xsl:template>

	<xsl:template name="nonac-cell">

		<xsl:param name="value" />

		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="$value/currentHours" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template name="nonac-cell-empty">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="'0'" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template match="aircraftJobs">

		<fo:table-row border="1pt solid grey">
			<fo:table-cell number-columns-spanned="2">
				<fo:block padding-top="2mm" />

				<xsl:apply-templates select="letterchecks" />

				<fo:block padding-top="2mm" />

				<xsl:apply-templates select="additionals" />

				<fo:block padding-top="2mm" />

				<xsl:apply-templates select="nonroutines" />

				<fo:block padding-top="2mm" />

				<xsl:apply-templates select="supports" />

				<fo:block padding-top="2mm" />
			</fo:table-cell>
		</fo:table-row>

	</xsl:template>

	<xsl:template match="mramp">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'m/ramp'" />
			<xsl:with-param
				name="right"
				select="''" />
		</xsl:call-template>

		<fo:table
			width="100%"
			font-size="8px"
			border="1pt solid grey"
			table-layout="fixed"
			space-after="10mm">

			<fo:table-column column-width="20%" />
			<fo:table-column column-width="10%" />
			<fo:table-column column-width="10%" />
			<fo:table-column column-width="60%" />

			<fo:table-header>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>

						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block></fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>A</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>Corrected</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<xsl:for-each select="mrampItem">
					<fo:table-row>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="type" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of
									select="format-number(usedHours, '0.0')" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:if test="position() = 1">
									<xsl:value-of
										select="format-number(correction, '0.0')" />
								</xsl:if>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="text" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
			</fo:table-body>
		</fo:table>

	</xsl:template>

</xsl:stylesheet>
