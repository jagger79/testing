<?xml version="1.0" encoding="UTF-8"?>
<!--
	/**
	* For special delegation and record page.
	*
	* @author Roman Krejci
	* @version 1.0
	* 
	* date: Jul 09, 2007
	*/
-->

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0"
	fo:schemaLocation="/xsd/fop.xsd">

	<xsl:include href="xsl-fo/common_fo.xsl" />

	<!--  ================== rendering of all jobs ===================-->

	<xsl:template match="/specialjobs">
		<fo:block space-after="0.0mm" margin-left="0.0mm">

			<xsl:apply-templates select="jobs" />

		</fo:block>

	</xsl:template>

	<!--  ================== rendering of LETTERCHECKS jobs ===================-->
	<xsl:template match="jobs">

		<fo:block margin-left=".5mm" margin-right=".5mm"
			font-size="8px">

			<fo:table table-layout="fixed" width="100%">

				<fo:table-column column-width="120mm" />
				<fo:table-column column-width="30mm" />
				<fo:table-column column-width="30mm" />
				<fo:table-column column-width="30mm" />
				<fo:table-column column-width="30mm" />
				<fo:table-column column-width="30mm" />

				<fo:table-body>

					<fo:table-row color="white"
						background-color="darkblue" font-weight="bold" height="4mm">

						<fo:table-cell text-align="left"
							display-align="left">
							<fo:block>
								History (
								<xsl:value-of select="../from" />
								-
								<xsl:value-of select="../to" />
								)
							</fo:block>
						</fo:table-cell>

						<fo:table-cell text-align="right"
							display-align="right">
							<fo:block />
						</fo:table-cell>

					</fo:table-row>


					<fo:table-row color="white"
						background-color="darkblue" font-weight="bold" height="4mm">
						<fo:table-cell display-align="left"
							text-align="left">
							<fo:block>Text</fo:block>
						</fo:table-cell>
						<fo:table-cell display-align="center"
							text-align="center">
							<fo:block>Workgroup</fo:block>
						</fo:table-cell>
						<fo:table-cell display-align="center"
							text-align="center">
							<fo:block>Date</fo:block>
						</fo:table-cell>
						<fo:table-cell display-align="center"
							text-align="center">
							<fo:block>CS AUN</fo:block>
						</fo:table-cell>
						<fo:table-cell display-align="center"
							text-align="center">
							<fo:block>Pk Number</fo:block>
						</fo:table-cell>
						<fo:table-cell display-align="center"
							text-align="center">
							<fo:block>Mh</fo:block>
						</fo:table-cell>
					</fo:table-row>

					<xsl:for-each select="job">
						<fo:table-row>
							<xsl:call-template name="job" />
						</fo:table-row>
					</xsl:for-each>

				</fo:table-body>
			</fo:table>

		</fo:block>
	</xsl:template>

	<!--  ================== rendering of one job item ===================-->
	<xsl:template name="job">

		<fo:table-cell display-align="left" text-align="left">
			<fo:block>
				<xsl:value-of select="text" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell display-align="center" text-align="center">
			<fo:block>
				<xsl:value-of select="workgroup/name" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell display-align="center" text-align="center">
			<fo:block>
				<xsl:value-of select="date" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell display-align="center" text-align="center">
			<fo:block>
				<xsl:value-of select="aun" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell display-align="center" text-align="center">
			<fo:block>
				<xsl:value-of select="pkNumber" />
			</fo:block>
		</fo:table-cell>

		<fo:table-cell display-align="center" text-align="center">
			<fo:block>
				<xsl:value-of select="prof" />
				&nbsp;
				<xsl:value-of select="mh" />
			</fo:block>
		</fo:table-cell>

	</xsl:template>

	<!-- ============================================================= -->

</xsl:stylesheet>
