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

	<xsl:template match="/operationControl">

		<xsl:for-each select="ocGroundtimes/ocGroundtime">

			<fo:block keep-together="always">
				<xsl:apply-templates select="." />
			</fo:block>

		</xsl:for-each>

		<xsl:apply-templates select="plannedPresence" />
		<xsl:apply-templates select="plannedVarious" />

	</xsl:template>

	<xsl:template match="groundtime">

		<fo:table
			space-after="0cm"
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

			<fo:table-column column-width="1.5cm" />
			<fo:table-column column-width="1.5cm" />
			<fo:table-column column-width="1.5cm" />
			<fo:table-column column-width="1.5cm" />
			<fo:table-column column-width="1.5cm" />

			<fo:table-column
				column-width="proportional-column-width(1)" />

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
						number-columns-spanned="5"
						color="white"
						background-color="darkblue"
						padding="1mm">
						<fo:block>Summary</fo:block>
					</fo:table-cell>

					<fo:table-cell
						border="1pt solid white"
						number-columns-spanned="3"
						color="white"
						background-color="darkblue"
						padding="1mm">
						<fo:block>Product</fo:block>
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
					<xsl:call-template name="summary"/>
						
					<fo:table-cell border="1pt solid white">
						<fo:block font-weight="bold">
							<xsl:value-of select="product/name" />
						</fo:block>
					</fo:table-cell>

				</fo:table-row>

				<fo:table-row text-align="left">

					<fo:table-cell background-color="white">
						<fo:block></fo:block>
					</fo:table-cell>

					<fo:table-cell
						number-columns-spanned="15"
						border="1pt solid white"
						padding="1mm">
						<fo:block>
							<xsl:for-each
								select="professions/profession[position() &lt;= 3]">
								<fo:inline>
									&nbsp;
								</fo:inline>
								<fo:inline font-weight="bold">
									<xsl:value-of
										select="professionName" />
								</fo:inline>
								<fo:inline>
									| P
									<xsl:value-of
										select="format-number(planHours,'0.0')" />
								</fo:inline>
								<fo:inline>
									| A
									<xsl:value-of
										select="format-number(currentHours,'0.0')" />
								</fo:inline>
								<fo:inline>
									| R
									<xsl:value-of
										select="format-number(remainingHours,'0.0')" />
									&nbsp;
								</fo:inline>
							</xsl:for-each>
						</fo:block>
					</fo:table-cell>


				</fo:table-row>

			</fo:table-body>
		</fo:table>


		<xsl:call-template name="tooltip" />

	</xsl:template>

	<xsl:template
		match="groundtimePlannedHours"
		name="groundtimePlannedHours">

		<xsl:variable
			name="workerHours"
			select="/operationControl/workerHours" />

		<xsl:if test="groundtimePlanHour">
			<fo:table
				space-after="0.5cm"
				width="95%"
				font-size="8"
				table-layout="fixed"
				border="1pt solid grey"
				space-before.conditionality="retain"
				display-align="center"
				text-align="center">

				<fo:table-column column-width="2cm" />

				<xsl:for-each
					select="groundtimePlanHour[position() = 1]/professionHour/entry">
					<fo:table-column column-width="2cm" />
				</xsl:for-each>

				<fo:table-column
					column-width="proportional-column-width(1)" />

				<fo:table-header>

					<fo:table-row
						background-color="orange"
						height="5mm"
						color="white">
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>

						<xsl:for-each
							select="groundtimePlanHour[position() = 1]/professionHours/entry">
							<fo:table-cell>
								<fo:block>
									<xsl:value-of
										select="key" />
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>

				</fo:table-header>

				<fo:table-body>

					<fo:table-row height="4mm">
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>

					<xsl:for-each select="groundtimePlanHour">
						<fo:table-row height="4mm">

							<fo:table-cell background-color="white">
								<fo:block>
									<xsl:value-of select="wg/name" />
								</fo:block>
							</fo:table-cell>

							<xsl:for-each
								select="professionHours/entry">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="value/plannedHours" />
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>

							<fo:table-cell>
								<fo:block></fo:block>
							</fo:table-cell>

						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>

		</xsl:if>

	</xsl:template>


	<xsl:template match="plannedPresence">

		<xsl:if test="presence">

			<xsl:variable
				name="workerHours"
				select="/operationControl/workerHours" />

			<fo:table
				width="95%"
				table-layout="fixed"
				space-after="0.5cm"
				space-before.conditionality="retain"
				keep-together="always"
				background-color="#E5E5E5"
				border="1pt solid grey"
				display-align="center"
				text-align="center"
				font-size="8">

				<fo:table-header>

					<fo:table-row
						color="white"
						background-color="orange"
						font-weight="bold"
						height="5mm">

						<fo:table-cell border="1pt solid white">
							<xsl:attribute
								name="number-columns-spanned">
								<xsl:value-of
									select="1 + (2 * count(presence[position() = 1]/presenceHours/professionHours/entry))" />
							</xsl:attribute>
							<fo:block>Presence</fo:block>
						</fo:table-cell>

						<fo:table-cell border="1pt solid white">
							<xsl:attribute
								name="number-columns-spanned">
								<xsl:value-of
									select="count(presence[position() = 1]/productWorkload/entry/value/professionHours/entry)" />
							</xsl:attribute>
							<fo:block>Workload</fo:block>
						</fo:table-cell>

						<fo:table-cell border="1pt solid white">
							<xsl:attribute
								name="number-columns-spanned">
								<xsl:value-of
									select="count(presence[position() = 1]/remain/professionHours/entry)" />
							</xsl:attribute>
							<fo:block>Remain</fo:block>
						</fo:table-cell>

					</fo:table-row>

					<fo:table-row
						color="white"
						background-color="darkblue"
						font-weight="bold"
						height="4mm">

						<fo:table-cell border="1pt solid white">
							<fo:block></fo:block>
						</fo:table-cell>

						<xsl:for-each
							select="presence[position() = 1]/presenceHours/professionHours/entry">
							<fo:table-cell
								border="1pt solid white"
								number-columns-spanned="2">
								<fo:block></fo:block>
							</fo:table-cell>
						</xsl:for-each>

						<xsl:for-each
							select="presence[position() = 1]/productWorkload/entry">
							<fo:table-cell border="1pt solid white">
								<xsl:attribute
									name="number-columns-spanned">
									<xsl:value-of
										select="count(value/professionHours/entry)" />
								</xsl:attribute>
								<fo:block>
									<xsl:value-of select="key/name" />
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						<xsl:for-each
							select="presence[position() = 1]/remain/professionHours/entry">
							<fo:table-cell border="1pt solid white">
								<fo:block></fo:block>
							</fo:table-cell>
						</xsl:for-each>


					</fo:table-row>

					<fo:table-row
						color="white"
						background-color="darkblue"
						font-weight="bold"
						height="4mm">

						<fo:table-cell border="1pt solid white">
							<fo:block></fo:block>
						</fo:table-cell>

						<xsl:for-each
							select="presence[position() = 1]/presenceHours/professionHours/entry">
							<fo:table-cell
								border="1pt solid white"
								number-columns-spanned="2">
								<fo:block>
									<xsl:value-of
										select="value/professionName" />
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						<xsl:for-each
							select="presence[position() = 1]/productWorkload/entry/value/professionHours/entry">
							<fo:table-cell border="1pt solid white">
								<fo:block>
									<xsl:value-of
										select="value/professionName" />
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

						<xsl:for-each
							select="presence[position() = 1]/remain/professionHours/entry">
							<fo:table-cell border="1pt solid white">
								<fo:block>
									<xsl:value-of
										select="value/professionName" />
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

					</fo:table-row>
				</fo:table-header>

				<fo:table-body>

					<xsl:for-each select="presence">

						<fo:table-row height="4mm">

							<fo:table-cell>
								<fo:block>
									<fo:block>
										<xsl:value-of
											select="workgroup/name" />
									</fo:block>
								</fo:block>
							</fo:table-cell>

							<xsl:for-each
								select="presenceHours/professionHours/entry/value">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="plannedHours" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="plannedHours * $workerHours" />
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>

							<xsl:for-each
								select="productWorkload/entry/value/professionHours/entry/value">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="plannedHours" />
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>

							<xsl:for-each
								select="remain/professionHours/entry/value">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="plannedHours" />
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>

						</fo:table-row>

					</xsl:for-each>
				</fo:table-body>

			</fo:table>

		</xsl:if>
	</xsl:template>


	<xsl:template match="plannedVarious">

		<xsl:if test="various">
			<xsl:variable
				name="workerHours"
				select="/operationControl/workerHours" />

			<fo:table
				width="55%"
				table-layout="fixed"
				space-after="0cm"
				space-before.conditionality="retain"
				keep-together="always"
				background-color="#E5E5E5"
				border="1pt solid grey"
				display-align="center"
				text-align="center"
				font-size="8">

				<fo:table-header>

					<fo:table-row
						color="white"
						background-color="orange"
						font-weight="bold"
						height="5mm">

						<fo:table-cell border="1pt solid white">
							<xsl:attribute
								name="number-columns-spanned">
								<xsl:value-of
									select="2 + (2 * count(various[position() = 1]/professionHour/entry))" />
							</xsl:attribute>
							<fo:block>Various</fo:block>
						</fo:table-cell>

					</fo:table-row>

					<fo:table-row
						color="white"
						background-color="darkblue"
						font-weight="bold"
						height="4mm">

						<fo:table-cell border="1pt solid white">
							<fo:block></fo:block>
						</fo:table-cell>

						<fo:table-cell border="1pt solid white">
							<fo:block></fo:block>
						</fo:table-cell>


						<xsl:for-each
							select="various[position() = 1]/professionHour/entry">
							<fo:table-cell
								border="1pt solid white"
								number-columns-spanned="2">
								<fo:block>
									<xsl:value-of
										select="key" />
								</fo:block>
							</fo:table-cell>
						</xsl:for-each>

					</fo:table-row>

				</fo:table-header>

				<fo:table-body>

					<xsl:for-each select="various">

						<fo:table-row height="4mm">

							<fo:table-cell>
								<fo:block>
									<fo:block>
										<xsl:value-of select="wg/name" />
									</fo:block>
								</fo:block>
							</fo:table-cell>

							<fo:table-cell>
								<fo:block>
									<fo:block>
										<xsl:value-of
											select="variousDefName" />
									</fo:block>
								</fo:block>
							</fo:table-cell>


							<xsl:for-each
								select="professionHour/entry">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="value/plannedHours" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="value/plannedHours * $workerHours" />
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>

						</fo:table-row>

					</xsl:for-each>
				</fo:table-body>

			</fo:table>
		</xsl:if>

	</xsl:template>


</xsl:stylesheet>
