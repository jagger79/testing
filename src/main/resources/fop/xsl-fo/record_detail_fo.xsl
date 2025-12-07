<?xml version="1.0" encoding="UTF-8"?>
<!--
	/**
	* For record detail page.
	*
	* @author Roman Krejci
	* @version 1.0
	* 
	* date: Mar 18, 2007
	*/
-->

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0"
	fo:schemaLocation="/xsd/fop.xsd">

	<xsl:include href="xsl-fo/common_fo.xsl" />
	<xsl:include href="xsl-fo/groundtimes_common_fo.xsl" />

	<!--  ================== rendering of all jobs ===================-->

	<xsl:template match="/detailjobs">
		<fo:block
			space-after="0.0mm"
			margin-left="0.0mm">

			<xsl:apply-templates select="groundtime" />

			<fo:block padding-top="2mm" />

			<xsl:apply-templates select="letterchecks" />

			<fo:block padding-top="2mm" />

			<xsl:apply-templates select="additionals" />

			<fo:block padding-top="2mm" />

			<xsl:apply-templates select="nonroutines" />

			<fo:block padding-top="2mm" />

			<xsl:apply-templates select="supports" />

			<fo:block padding-top="2mm" />

			<xsl:if test="detailConditions">
												
				<fo:block>			
					<xsl:if	test="count(groundtime | letterchecks | additionals | nonroutines | supports) &gt; 1">					
						<xsl:attribute
								name="break-before">
								<xsl:value-of select="'page'" />
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="detailConditions/groundtime" />
					<xsl:apply-templates select="detailConditions/conditions" />
				</fo:block>
			</xsl:if>

		</fo:block>

	</xsl:template>

	<!--  ================== rendering of GROUNDTIME ===================-->
	<xsl:template match="groundtime">

		<xsl:call-template name="groundtime-simple" />

	</xsl:template>

	<!--  ================== rendering of LETTERCHECKS jobs ===================-->
	<xsl:template match="letterchecks">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="../name" />
			<xsl:with-param
				name="right"
				select="../summaryLetterchecks" />
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

	<!--  ================== rendering of ADDITIONAL jobs ===================-->
	<xsl:template match="additionals">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Additional'" />
			<xsl:with-param
				name="right"
				select="../summaryAdditionals" />
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

	<!--  ================== rendering of NONROUTINE jobs ===================-->
	<xsl:template match="nonroutines">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Nonroutine'" />
			<xsl:with-param
				name="right"
				select="../summaryNonroutines" />
		</xsl:call-template>

		<fo:block
			margin-left=".5mm"
			margin-right=".5mm"
			font-size="8px">

			<fo:table
				table-layout="fixed"
				width="100%">

				<fo:table-column column-width="10mm" />
				<fo:table-column column-width="57mm" />
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

					<xsl:call-template name="header_blue_jobs_nr" />

					<xsl:for-each select="jobitem">
						<xsl:if test="isTask = 'true'">
							<fo:table-row>
								<xsl:call-template name="jobitem_nr" />
							</fo:table-row>
						</xsl:if>
						<xsl:if test="isTask = 'false'">
							<xsl:call-template name="tasks_nonroutines" />
						</xsl:if>
					</xsl:for-each>

				</fo:table-body>
			</fo:table>

		</fo:block>
	</xsl:template>

	<!--  ================== rendering of SUPPORT jobs ===================-->
	<xsl:template match="supports">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Support'" />
			<xsl:with-param
				name="right"
				select="../summarySupports" />
		</xsl:call-template>

		<fo:block
			margin-left=".5mm"
			margin-right=".5mm"
			font-size="8px">

			<fo:table
				table-layout="fixed"
				width="100%">

				<fo:table-column column-width="33mm" />
				<fo:table-column column-width="113mm" />
				<fo:table-column column-width="33mm" />

				<fo:table-body>

					<fo:table-row height=".5mm">
						<fo:table-cell>
							<fo:block />
						</fo:table-cell>
					</fo:table-row>

					<xsl:call-template name="header_blue_jobs_support" />

					<xsl:for-each select="jobitem">
						<fo:table-row height=".5cm">
							<xsl:call-template name="jobitem_support" />
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
	<!--  			<fo:block>P</fo:block>
			<fo:block>S</fo:block>
			<fo:block font-weight="bold">R</fo:block>
			================== eicke tried to fix SPR 11382 ===================-->
					<fo:block keep-with-next.within-page="always">P</fo:block>
					<fo:block keep-with-previous.within-page="always" keep-with-next.within-page="always">S</fo:block>
					<fo:block keep-with-previous.within-page="always" font-weight="bold">R</fo:block>
		</fo:table-cell>

		<xsl:call-template name="professions" />

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
				<!-- 
					<fo:table-cell text-align="center">
					<fo:block />
					</fo:table-cell>
					<fo:table-cell text-align="center">
					<fo:block />
					</fo:table-cell>
					<fo:table-cell text-align="center">
					<fo:block />
					</fo:table-cell>
					<fo:table-cell text-align="center">
					<fo:block />
					</fo:table-cell>
				-->
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
	<!--  ================== eicke tried to fix SPR 11382 ===================-->
					<fo:block keep-with-next.within-page="always">P</fo:block>
					<fo:block keep-with-previous.within-page="always" keep-with-next.within-page="always">S</fo:block>
					<fo:block keep-with-previous.within-page="always" font-weight="bold">R</fo:block>
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
						<fo:table-row>
							<fo:table-cell
								text-align="center"
								display-align="center">
								<fo:block>
									<xsl:value-of
										select="currentHours" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell
								text-align="center"
								display-align="center">
								<fo:block>
									<xsl:value-of
										select="remainingHours" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

					</fo:table-body>
				</fo:table>

			</fo:table-cell>
		</xsl:for-each>

	</xsl:template>

	<!--  ================== rendering of one job item of NONROUTINE ===================-->
	<xsl:template name="jobitem_nr">

		<fo:table-cell text-align="center">
			<fo:block>
				<xsl:value-of select="section" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="workNumber" />
			</fo:block>
			<fo:block>
				<xsl:value-of select="text" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell text-align="center">
			<fo:block>
				<xsl:value-of select="materialStatus" />
			</fo:block>
			<fo:block>
				<xsl:value-of select="materialRemarks" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell text-align="center">
			<fo:block>
				<xsl:value-of select="status" />
			</fo:block>
			<fo:block>
				<xsl:value-of select="duration" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell text-align="center">
	<!--  			<fo:block>E</fo:block>
			<fo:block>S</fo:block>
			<fo:block font-weight="bold">R</fo:block>
		================== eicke tried to fix SPR 11382 ===================-->
					<fo:block keep-with-next.within-page="always">P</fo:block>
					<fo:block keep-with-previous.within-page="always" keep-with-next.within-page="always">S</fo:block>
					<fo:block keep-with-previous.within-page="always" font-weight="bold">R</fo:block>
		</fo:table-cell>

		<xsl:call-template name="professions" />

	</xsl:template>

	<!--  ================== rendering of GLB ===================-->
	<xsl:template name="tasks_nonroutines">

		<fo:table-row
			height="2mm"
			background-color="gray">
			<fo:table-cell number-columns-spanned="8">
				<fo:block
					color="white"
					font-weight="bold"
					margin-left="2mm"
					font-size="6px">
					GLB No.
					<xsl:value-of select="text" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>

		<xsl:for-each select="tasks/taskitem">
			<fo:table-row>
				<fo:table-cell text-align="center">
					<fo:block>
						<xsl:value-of select="section" />
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
	<!-- 			<fo:block>P</fo:block>
					<fo:block>S</fo:block>
					<fo:block font-weight="bold">R</fo:block>
				================== eicke tried to fix SPR 11382 ===================-->
					<fo:block keep-with-next.within-page="always">P</fo:block>
					<fo:block keep-with-previous.within-page="always" keep-with-next.within-page="always">S</fo:block>
					<fo:block keep-with-previous.within-page="always" font-weight="bold">R</fo:block>
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

	<!--  ================== rendering of one job item ===================-->
	<xsl:template name="jobitem_support">

		<fo:table-cell text-align="center">
			<fo:block>
				<xsl:value-of select="remarks" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell text-align="center">
			<fo:block>
				<xsl:value-of select="text" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell
			width="33mm"
			background-color="lightgray"
			display-align="center"
			text-align="center"
			border-bottom-width=".5mm"
			border-bottom-color="white"
			border-bottom-style="solid">
			<fo:block>
				<xsl:value-of
					select="professions/profession/professionName" />
				<xsl:text>
					&nbsp;
				</xsl:text>
				<xsl:value-of
					select="professions/profession/currentHours" />
				Mh
			</fo:block>
		</fo:table-cell>

	</xsl:template>

	<!-- ==========================================================-->

	<!--  ================== rendering of CONDITION ===================-->
	<!-- author Michal Holecka -->
	
	<xsl:template match="conditions">

		<xsl:call-template name="header_orange">
			<xsl:with-param
				name="left"
				select="'Conditions'" />
			<xsl:with-param
				name="right"
				select="''" />
		</xsl:call-template>

		<fo:block
			margin-left=".5mm"
			margin-right=".5mm"
			font-size="8px">

			<fo:table
				table-layout="fixed"
				width="100%" 
				text-align="center"
				display-align="center">

				<fo:table-column column-width="40mm" />
				<fo:table-column
					column-width="proportional-column-width(1)" />
				<fo:table-column column-width="60mm" />

				<fo:table-header>

					<fo:table-row
						background-color="darkblue"
						color="white"
						height="5mm">
						<fo:table-cell>
							<fo:block>Code</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>Text</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>WorkNo</fo:block>
						</fo:table-cell>
					</fo:table-row>

				</fo:table-header>

				<fo:table-body>
					<xsl:for-each select="condition">
						<fo:table-row height="4mm">
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="code" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="text" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="workNo" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>

				</fo:table-body>
			</fo:table>
		</fo:block>

	</xsl:template>

</xsl:stylesheet>
