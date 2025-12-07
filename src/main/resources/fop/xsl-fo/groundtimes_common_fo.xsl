<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:java="http://xml.apache.org/xslt/java"
	version="1.0">

	<xsl:template
		name="groundtime-core"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">PROV</fo:block>
			<fo:block>
				<xsl:value-of select="provisonTime" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">FN/ARR</fo:block>
			<fo:block>
				<xsl:value-of select="flightNumberArrivalDate" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">P-ACT</fo:block>
			<fo:block>
				<xsl:value-of select="actualParkPosition" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">STA/ETA</fo:block>
			<fo:block>
				<xsl:value-of select="scheduledTimeArrival" />
				/
				<xsl:value-of select="estimatedTimeArrival" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">FN/DEP</fo:block>
			<fo:block>
				<xsl:value-of select="flightNumberDepartureDate" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">STD/ETD</fo:block>
			<fo:block>
				<xsl:value-of select="scheduledTimeDeparture" />
				/
				<xsl:value-of select="estimatedTimeDeparture" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">Work done</fo:block>
			<fo:block>
				<xsl:value-of select="format-number(workDone, '0.0')" />
				%
			</fo:block>
		</fo:table-cell>

	</xsl:template>

	<xsl:template name="summary">
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">P</fo:block>
			<fo:block>
				<xsl:value-of select="format-number(planned,'0.0')" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">A</fo:block>
			<fo:block>
				<xsl:value-of select="format-number(actual,'0.0')" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">R</fo:block>
			<fo:block>
				<xsl:value-of select="format-number(remain,'0.0')" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">TS</fo:block>
			<fo:block>
				<xsl:value-of select="total" />
			</fo:block>
		</fo:table-cell>
		<fo:table-cell border="1pt solid white">
			<fo:block font-weight="bold">TR</fo:block>
			<fo:block>
				<xsl:value-of select="totalRemain" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template
		name="tooltip"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">

		<fo:table
			space-after="0.5cm"
			space-before="0cm"
			width="95%"
			font-size="8"
			background-color="#E5E5E5"
			table-layout="fixed"
			border="1pt solid grey"
			space-before.conditionality="retain"
			display-align="center"
			keep-together="always">

			<!--	
				<fo:table-column column-width="1.5cm" />
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="2cm" />
				
				<fo:table-header>
				<fo:table-row>
				<fo:table-cell>
				<fo:block>MSN</fo:block>
				</fo:table-cell>
				<fo:table-cell>
				<fo:block>effectivity</fo:block>
				</fo:table-cell>
				<fo:table-cell>
				<fo:block>FC</fo:block>
				</fo:table-cell>
				<fo:table-cell>
				<fo:block>FH</fo:block>
				</fo:table-cell>
				<fo:table-cell>
				<fo:block>daily FC</fo:block>
				</fo:table-cell>
				<fo:table-cell>
				<fo:block>daily FH</fo:block>
				</fo:table-cell>
				</fo:table-row>
				</fo:table-header>
			-->
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-body>

				<fo:table-row>

					<fo:table-cell>
						<fo:block>
							MSN
							<xsl:value-of select="msn" />
						</fo:block>
					</fo:table-cell>

					<fo:table-cell>
						<fo:block>
							Effectivity
							<xsl:value-of select="efectivity" />
						</fo:block>
					</fo:table-cell>

					<fo:table-cell>
						<fo:block>
							FH
							<xsl:value-of select="flightHours" />
						</fo:block>
					</fo:table-cell>

					<fo:table-cell>
						<fo:block>
							FC
							<xsl:value-of select="flightCycles" />
						</fo:block>
					</fo:table-cell>

					<fo:table-cell>
						<fo:block>
							daily FH
							<xsl:value-of select="dailyFlightHours" />
						</fo:block>
					</fo:table-cell>

					<fo:table-cell>
						<fo:block>
							daily FC
							<xsl:value-of select="dailyFlightCycles" />
						</fo:block>
					</fo:table-cell>

				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>


	<xsl:template
		name="groundtime-simple"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">

		<fo:table
			space-after="0.5cm"
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
			<fo:table-column
				column-width="proportional-column-width(1)" />
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
						<fo:block>

						</fo:block>
					</fo:table-cell>

					<fo:table-cell
						border="1pt solid white"
						number-columns-spanned="5"
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
						
					<xsl:call-template name="summary"/>

				</fo:table-row>

			</fo:table-body>
		</fo:table>
	</xsl:template>

</xsl:stylesheet>