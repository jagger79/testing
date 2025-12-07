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
	
	<xsl:template match="/zeusseventDetail">

		<xsl:call-template name="header">
			<xsl:with-param
				name="userInfo"
				select="userInfo" />
			<xsl:with-param
				name="caption"
				select="'Zeuss Event Detail'" />
		</xsl:call-template>

		<xsl:apply-templates select="groundtime" />
		
		<xsl:apply-templates select="letterchecks" />
						
		<xsl:apply-templates select="additionals" />
	
	</xsl:template>

	<xsl:template match="groundtime">

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

			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="3cm" />

			<fo:table-body
				text-align="center"
				display-align="center">

				<fo:table-row  height="8mm">
					<fo:table-cell>
						<fo:block font-weight="bold">PROV</fo:block>

					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-weight="bold">FN/ARR</fo:block>

					</fo:table-cell>
					<fo:table-cell >
						<fo:block font-weight="bold">P-ACT</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-weight="bold">STA/ETA</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-weight="bold">FN/DEP</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-weight="bold">STD/ETD</fo:block>
					</fo:table-cell>

				</fo:table-row>
				<fo:table-row   height="8mm">
					<fo:table-cell>
						<fo:block>
							<xsl:value-of select="provisonTime" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:value-of
								select="flightNumberArrivalDate" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:value-of select="actualParkPosition" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:value-of select="scheduledTimeArrival" />
							/
							<xsl:value-of select="estimatedTimeArrival" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:value-of
								select="flightNumberDepartureDate" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:value-of
								select="scheduledTimeDeparture" />
							/
							<xsl:value-of
								select="estimatedTimeDeparture" />
						</fo:block>
					</fo:table-cell>

				</fo:table-row>

			</fo:table-body>
		</fo:table>

	</xsl:template>
	
	<!--  ================== rendering of letterchecks jobs ===================-->
	<xsl:template match="letterchecks">
	
		<xsl:variable name="summaryLetterchecks">
					P: <xsl:value-of select="../summaryLetterchecks/planHours" />
		</xsl:variable>
		

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="../name" />
			<xsl:with-param
				name="right"
				select="$summaryLetterchecks" />
		</xsl:call-template>

		<fo:block
			margin-left=".5mm"
			margin-right=".5mm"
			font-size="8px">

			<fo:table
				table-layout="fixed"
				width="100%">

				<fo:table-column column-width="7mm" />
				<fo:table-column column-width="60mm" />
				<fo:table-column column-width="60mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="4mm" />
				<xsl:for-each
					select="jobitem[position() = 1]/professions/profession">
					<fo:table-column
						column-width="proportional-column-width(14)" />
				</xsl:for-each>

				<fo:table-body>

					<fo:table-row height=".8mm">
						<fo:table-cell>
							<fo:block />
						</fo:table-cell>
					</fo:table-row>

					<xsl:call-template name="header_blue_jobs" />

					<xsl:for-each select="jobitem">
						<fo:table-row>
							<xsl:call-template
								name="jobitem_lettercheck" />
						</fo:table-row>

						<xsl:if test="isTask = 'false'">
							<xsl:call-template
								name="tasks_letterchecks" />
						</xsl:if>

					</xsl:for-each>

				</fo:table-body>
			</fo:table>

		</fo:block>
	</xsl:template>
	
	
	<!--  ================== rendering of additional jobs ===================-->
	<xsl:template match="additionals">

		<xsl:variable name="summaryAdditionals">
					P: <xsl:value-of select="../summaryAdditionals/planHours" />
		</xsl:variable>
		
		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Additional'" />
			<xsl:with-param
				name="right"
				select="$summaryAdditionals" />
		</xsl:call-template>

		<fo:block
			margin-left=".5mm"
			margin-right=".5mm"
			font-size="8px">

			<fo:table
				table-layout="fixed"
				width="100%">

				<fo:table-column column-width="7mm" />
				<fo:table-column column-width="60mm" />
				<fo:table-column column-width="60mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="4mm" />
				<xsl:for-each
					select="jobitem[position() = 1]/professions/profession">
					<fo:table-column
						column-width="proportional-column-width(14)" />
				</xsl:for-each>

				<fo:table-body>

					<fo:table-row height=".5mm">
						<fo:table-cell>
							<fo:block />
						</fo:table-cell>
					</fo:table-row>

					<xsl:call-template name="header_blue_jobs" />

					<xsl:for-each select="jobitem">
						<fo:table-row>
							<xsl:call-template
								name="jobitem_lettercheck" />
						</fo:table-row>
					</xsl:for-each>

				</fo:table-body>
			</fo:table>

		</fo:block>
	</xsl:template>
	
	<!--  ================== rendering of one job item ===================-->
	<xsl:template name="jobitem_lettercheck">

		<fo:table-cell text-align="center">
			<fo:block>
				<xsl:value-of select="position" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell>
			<fo:block font-weight="bold">
				<xsl:value-of select="workNumber" />
				<fo:inline color="red">
					&nbsp;
					<xsl:value-of select="remain" />
					&nbsp;
					<xsl:value-of select="mkcp" />
				</fo:inline>
			</fo:block>
			<fo:block>
				<xsl:value-of select="text" />
			</fo:block>
			<fo:block>
				<xsl:value-of select="remarks" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell
			display-align="center"
			text-align="center">
			<fo:block>
				<xsl:value-of select="materialStatus" />
			</fo:block>
			<fo:block>
				<xsl:value-of select="materialRemarks" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell
			display-align="center"
			text-align="center">
			<fo:block>
				<xsl:value-of select="status" />
			</fo:block>
			<fo:block>
				<xsl:value-of select="duration" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell
			display-align="center"
			text-align="center">
			<fo:block>P</fo:block>
		</fo:table-cell>

		<xsl:call-template name="professions" />

	</xsl:template>
	
	
	<!--  ================== rendering of one profession ===================-->
	<xsl:template name="professions">

		<xsl:for-each select="professions/profession">
			<fo:table-cell
				background-color="lightgray"
				display-align="center"
				border-right-color="white"
				border-right-width=".5mm"
				border-right-style="solid"
				border-bottom-width=".5mm"
				border-bottom-color="white"
				border-bottom-style="solid">

				<fo:table
					table-layout="fixed"
					width="100%">

					<fo:table-column column-width="100%" />

					<fo:table-body>

						<fo:table-row>
							<fo:table-cell
								text-align="center"
								display-align="center">
								<fo:block>
									<xsl:value-of select="planHours" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>						

					</fo:table-body>
				</fo:table>

			</fo:table-cell>
		</xsl:for-each>

	</xsl:template>
	
	
	<!--  ================== rendering of tasks ===================-->
	<xsl:template name="tasks_letterchecks">

		<fo:table-row
			height="2mm"
			background-color="gray">
			<fo:table-cell number-columns-spanned="8">
				<fo:block
					color="white"
					font-weight="bold"
					margin-left="2mm"
					font-size="6px">
					Single Jobs for Work No
					<xsl:value-of select="workNumber" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>

		<xsl:for-each select="tasks/taskitem">
			<fo:table-row>
			
				<fo:table-cell text-align="center">
					<fo:block>
						<xsl:value-of select="position" />
					</fo:block>
				</fo:table-cell>

				<fo:table-cell>
					<fo:block>
						<xsl:value-of select="text" />
					</fo:block>
					<fo:block>
						<xsl:value-of select="remarks" />
					</fo:block>
				</fo:table-cell>

				<fo:table-cell
					display-align="center"
					text-align="center">
					<fo:block>
						<xsl:value-of select="materialStatus" />
					</fo:block>
					<fo:block>
						<xsl:value-of select="materialRemarks" />
					</fo:block>
				</fo:table-cell>

				<fo:table-cell
					display-align="center"
					text-align="center">
					<fo:block>
						<xsl:value-of select="status" />
					</fo:block>
					<fo:block>
						<xsl:value-of select="duration" />
					</fo:block>
				</fo:table-cell>

				<fo:table-cell
					display-align="center"
					text-align="center">
					<fo:block>P</fo:block>				
				</fo:table-cell>

				<xsl:call-template name="professions" />

			</fo:table-row>
		</xsl:for-each>

		<fo:table-row
			height="2mm"
			background-color="gray">
			<fo:table-cell>
				<fo:block />
			</fo:table-cell>
		</fo:table-row>

	</xsl:template>
	
	

</xsl:stylesheet>
