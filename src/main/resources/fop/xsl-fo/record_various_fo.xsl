<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0"
	fo:schemaLocation="/xsd/fop.xsd">

	<xsl:import href="xsl-fo/common_fo.xsl" />

	<xsl:template
		match="various" 
		xmlns:fo="http://www.w3.org/1999/XSL/Format">


		<xsl:if test="count(unspecifiedJobs/unspecifiedJob) &gt; 0">
			<fo:block
				border="1pt solid grey"
				space-after="0.5cm">

				<xsl:call-template name="header_orange">
					<xsl:with-param
						name="left"
						select="'New unspecified work'" />
					<xsl:with-param
						name="right"
						select="''" />
				</xsl:call-template>

				<xsl:apply-templates select="unspecifiedJobs" />
			</fo:block>
		</xsl:if>

		<xsl:if
			test="count(predefinedCustomerJobs/predefinedJob) &gt; 0">
			<fo:block
				border="1pt solid grey"
				space-after="0.5cm">

				<xsl:variable name="sumPredefinedCustomerJobs">
					P: <xsl:value-of select="sumPredefinedCustomerJobs/planHours" />
					NR: <xsl:value-of select="sumPredefinedCustomerJobs/currentHours" />
					Sum: <xsl:value-of select="sumPredefinedCustomerJobs/remainingHours" />										
				</xsl:variable>

				<xsl:call-template name="header_orange">
					<xsl:with-param
						name="left"
						select="'Maintenance Customers'" />
					<xsl:with-param
						name="right"
						select="$sumPredefinedCustomerJobs" />
				</xsl:call-template>

				<xsl:for-each select="predefinedCustomerJobs">
					<xsl:call-template name="predefinedJob" />
				</xsl:for-each>
			</fo:block>
		</xsl:if>

		<xsl:if test="count(predefinedDLHJobs/predefinedJob) &gt; 0">
			<fo:block
				border="1pt solid grey"
				space-after="0.5cm">

				<xsl:variable name="sumPredefinedDlhJobs">
					P: <xsl:value-of select="sumPredefinedDlhJobs/planHours" />
					NR: <xsl:value-of select="sumPredefinedDlhJobs/currentHours" />
					Sum: <xsl:value-of select="sumPredefinedDlhJobs/remainingHours" />										
				</xsl:variable>

				<xsl:call-template name="header_orange">
					<xsl:with-param
						name="left"
						select="'Call-in-Maintenance DLH'" />
					<xsl:with-param
						name="right"
						select="$sumPredefinedDlhJobs" />
				</xsl:call-template>

				<xsl:for-each select="predefinedDLHJobs">
					<xsl:call-template name="predefinedJob" />
				</xsl:for-each>
			</fo:block>
		</xsl:if>

	</xsl:template>

	<!--  ================== rendering of predefined jobs ===================-->

	<xsl:template name="predefinedJob">
		<fo:block>
			<xsl:if test="count(predefinedJob) &gt; 0">

				<fo:table
					width="100%"
					font-size="8px"
					table-layout="fixed">


					<fo:table-column column-width="15mm	" />
					<fo:table-column column-width="15mm" />
					<fo:table-column column-width="15mm" />
					<fo:table-column column-width="30mm" />
					<fo:table-column
						column-width="proportional-column-width(3)" />
					<fo:table-column
						column-width="proportional-column-width(1)" />

					<xsl:for-each
						select="//various/professions/profession">
						<fo:table-column
							column-width="proportional-column-width(1)" />
					</xsl:for-each>

					<xsl:call-template
						name="header_blue_various_predefined" />

					<fo:table-body>

						<xsl:for-each select="predefinedJob">

							<fo:table-row
								display-align="center"
								text-align="center"
								height="10mm">

								<fo:table-cell text-align="center">
									<fo:block>
										<xsl:value-of select="customer" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="fleet" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="acreg" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="work" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="text" />
									</fo:block>
								</fo:table-cell>

								<fo:table-cell>

									<fo:table
										background-color="#E5E5E5"
										table-layout="fixed"
										width="100%">

										<fo:table-column
											column-width="proportional-column-width(1)" />

										<fo:table-body>
											<fo:table-row
												height="5mm">
												<fo:table-cell>
													<fo:block keep-with-next.within-page="always">
														NR
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row
												height="5mm">
												<fo:table-cell>
													<fo:block keep-with-previous.within-page="always">
														SUM
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:table-cell>

								<xsl:call-template
									name="job_predefined_hours">
									<xsl:with-param
										name="item_hours"
										select="hours" />
								</xsl:call-template>

							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
		</fo:block>
	</xsl:template>


	<!--  ================== rendering of header for predefined jobs ===================-->

	<xsl:template name="header_blue_various_predefined">

		<fo:table-header text-align="center">

			<fo:table-row
				background-color="darkblue"
				color="white"
				height="7mm"
				display-align="center"
				text-align="center">

				<fo:table-cell border="1pt solid white">
					<fo:block>Customer</fo:block>
				</fo:table-cell>

				<fo:table-cell border="1pt solid white">
					<fo:block>Fleet</fo:block>
				</fo:table-cell>

				<fo:table-cell border="1pt solid white">
					<fo:block>AC Reg</fo:block>
				</fo:table-cell>

				<fo:table-cell border="1pt solid white">
					<fo:block>Work</fo:block>
				</fo:table-cell>

				<fo:table-cell border="1pt solid white">
					<fo:block>Text</fo:block>
				</fo:table-cell>

				<fo:table-cell border="1pt solid white">
					<fo:block></fo:block>
				</fo:table-cell>

				<xsl:for-each select="/various/professions/profession">
					<fo:table-cell border="1pt solid white">
						<fo:block>
							<xsl:value-of select="."/>
						</fo:block>
					</fo:table-cell>
				</xsl:for-each>

			</fo:table-row>

		</fo:table-header>
	</xsl:template>


	<xsl:template name="job_predefined_hours">

		<xsl:param name="item_hours" />

		<xsl:for-each select="//various/professions/profession">
			<xsl:call-template name="job_predefined_hours_cell">
				<xsl:with-param name="item_hours" select="$item_hours"/>
				<xsl:with-param name="profession" select="."/>				
			</xsl:call-template>
		</xsl:for-each>
	
	</xsl:template>

	<xsl:template name="job_predefined_hours_cell">
		
		<xsl:param name="item_hours" />
		<xsl:param name="profession" />
				
		<fo:table-cell>

				<fo:table
					background-color="#E5E5E5"
					table-layout="fixed"
					width="100%">

					<fo:table-column
						column-width="proportional-column-width(1)" />

					<fo:table-body>
						<xsl:choose>
							<xsl:when
								test="$item_hours/entry/value[professionName = $profession]">
								<xsl:call-template
									name="predefined-cell" >
									<xsl:with-param name="value" select="$item_hours/entry/value[professionName = $profession]" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template
									name="predefined-cell-empty" />
							</xsl:otherwise>
						</xsl:choose>
					</fo:table-body>

				</fo:table>

		</fo:table-cell>
	</xsl:template>

	<xsl:template name="predefined-cell">

		<xsl:param name="value" />

		<fo:table-row height="5mm">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="$value/currentHours" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row height="5mm">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="$value/remainingHours" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template name="predefined-cell-empty">

		<fo:table-row height="5mm">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="'0'" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row height="5mm">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="'0'" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="unspecifiedJobs">

		<xsl:if test="count(unspecifiedJob) &gt; 0">
			<fo:table
				table-layout="fixed"
				width="100%"
				font-size="8px">

				<fo:table-column
					column-width="proportional-column-width(1)" />
				<fo:table-column column-width="33mm" />
				<fo:table-column column-width="13mm" />
				<fo:table-column column-width="20mm" />

				<xsl:call-template
					name="header_blue_various_unspecified" />

				<fo:table-body>
					<xsl:for-each select="unspecifiedJob">

						<fo:table-row
							height="7mm"
							display-align="center"
							text-align="center">
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="text" />
								</fo:block>

							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="aun" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of
										select="proffesionName" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="currentHours" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="header_blue_various_unspecified">

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
					<fo:block>AUN</fo:block>
				</fo:table-cell>

				<fo:table-cell
					border="1pt solid white"
					number-columns-spanned="2">
					<fo:block>Sum Mh</fo:block>
				</fo:table-cell>

			</fo:table-row>

		</fo:table-header>
	</xsl:template>


</xsl:stylesheet>
