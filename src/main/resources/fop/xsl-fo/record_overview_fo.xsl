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

	<xsl:template name="timebarcolumn">

      <xsl:param name="count" select="1"/>

      <xsl:if test="$count &gt; 0">
      	<fo:table-column />
        <xsl:call-template name="timebarcolumn">
          <xsl:with-param name="count" select="$count - 1"/>
        </xsl:call-template>
      </xsl:if>
      
	</xsl:template>

	<xsl:template name="timebarcell">

      <xsl:param name="count" />
      <xsl:param name="max" />

      <xsl:param name="start" />
      <xsl:param name="duration" />

      <xsl:if test="$count &lt;= $max">
      	<xsl:choose>
	      	<xsl:when test="$count &gt; $start and $count &lt;= ($start + $duration )">
		      	<fo:table-cell background-color="orange" >		      		
		      		<fo:block>
			      		<xsl:choose>
			      			<xsl:when test="$count = 1">
			      				JSS:<xsl:value-of select="dbno"/>		      				
			      			</xsl:when>	
			      			<xsl:when test="$count = 2">
			      				/<xsl:value-of select="revision"/>/<xsl:value-of select="status"/>		      				
			      			</xsl:when>				      			
			      			<xsl:otherwise>
			      				&nbsp;
			      			</xsl:otherwise>
			      		</xsl:choose>			      					      		
		      		</fo:block>		
				</fo:table-cell>
			</xsl:when>	
			<xsl:otherwise>
		      	<fo:table-cell >
		      		<fo:block>		      	
			      		<xsl:choose>
			      			<xsl:when test="$count = 1">
			      				JSS:<xsl:value-of select="dbno"/>	      				
			      			</xsl:when>	
			      			<xsl:when test="$count = 2">
			      				/<xsl:value-of select="revision"/>/<xsl:value-of select="status"/>		      				
			      			</xsl:when>				      						      			
			      			<xsl:otherwise>
			      				&nbsp;
			      			</xsl:otherwise>
			      		</xsl:choose>
			      	</fo:block>
				</fo:table-cell>
			</xsl:otherwise>
		</xsl:choose>
        <xsl:call-template name="timebarcell">
          <xsl:with-param name="count" select="$count + 1"/>
          <xsl:with-param name="max" select="$max"/>
          <xsl:with-param name="start" select="$start"/>
          <xsl:with-param name="duration" select="$duration"/>
          
        </xsl:call-template>
      </xsl:if>
      
	</xsl:template>
	 

	<xsl:template match="//groundtimes/groundtimesOverview/groundtime"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
		
<!-- 			<fo:table space-after="0.5cm" width="95%" font-size="8" 
-->
			<fo:table space-after="0cm" width="95%" font-size="8" 
					background-color="#E5E5E5"
					table-layout="fixed"
					border="1pt solid grey"
					space-before.conditionality="retain"
					display-align="center"
 					keep-together="always" >			

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
	
				<fo:table-column  column-width="proportional-column-width(1)"/>
				<fo:table-column  column-width="proportional-column-width(1)"/>
				<fo:table-column  column-width="proportional-column-width(1)"/>
				
				<fo:table-body>
				
					<fo:table-row text-align="center">					
						<!-- picture of plane -->
						<fo:table-cell  background-color="white" >
							<fo:block>
							</fo:block>
						</fo:table-cell>
						
						<fo:table-cell border="1pt solid white"  number-columns-spanned="7" color="white" background-color="darkblue" padding="1mm">
							<fo:block>
									<fo:table>																
											
										<xsl:call-template name="timebarcolumn">
											<xsl:with-param name="count" select="../timebarInfo/timeframe"/>
											
										</xsl:call-template>		
											
										<fo:table-body>	
											
											<fo:table-row>											
												<xsl:call-template name="timebarcell">
													<xsl:with-param name="count" select="1"/>
													<xsl:with-param name="max" select="../timebarInfo/timeframe + 1" />															
													<xsl:with-param name="start" select="floor(../timebarInfo/startDiff)"/>
													<xsl:with-param name="duration" select="ceiling(../timebarInfo/duration) + 1"/>																												
												</xsl:call-template>
											</fo:table-row>																	
											
									</fo:table-body>
								</fo:table>
							</fo:block>	
						</fo:table-cell>
						
						<fo:table-cell border="1pt solid white" number-columns-spanned="5" color="white" background-color="darkblue" padding="1mm">
							<fo:block>
								Summary
							</fo:block>
						</fo:table-cell>					
						
						<fo:table-cell border="1pt solid white" number-columns-spanned="3" color="white" background-color="darkblue" padding="1mm">
							<fo:block>
								NonRoutines
							</fo:block>
						</fo:table-cell>										
					</fo:table-row>
					
					<fo:table-row text-align="center">
					
						<fo:table-cell  border="1pt solid white" background-color="white">
							<fo:block>
								<xsl:value-of select="acReg"/>
							</fo:block>
							<fo:block>
								<xsl:value-of select="checkName"/>
							</fo:block>														
						</fo:table-cell>		
						
						<xsl:call-template name="groundtime-core" />
						
						<xsl:call-template name="summary"/>
							
					  	<xsl:for-each select="nonroutines/nonroutine[position() &lt;= 3]">
						  	<fo:table-cell  border="1pt solid white">
							  	<fo:block font-weight="bold">
									<xsl:value-of select="professionName"/>
								</fo:block>
								<fo:block>
									<xsl:value-of select="currentHours"/>
								</fo:block>
							</fo:table-cell>	
					   	</xsl:for-each>
				      												
					</fo:table-row>
									
					<fo:table-row text-align="left">				
					
						<fo:table-cell background-color="white">
							<fo:block></fo:block>
						</fo:table-cell>		
						
						<fo:table-cell number-columns-spanned="15"  border="1pt solid white" padding="1mm">
							<fo:block>						
								<xsl:for-each select="professions/profession[position() &lt;= 3]">
									  		<fo:inline>
									  			&nbsp;						  		
											</fo:inline>								
									  		<fo:inline font-weight="bold">						  		
												<xsl:value-of select="professionName"/>
											</fo:inline>
									  		<fo:inline>						  											
											  | P <xsl:value-of select="format-number(planHours,'0.0')"/>
											</fo:inline>
											<fo:inline>						  											
											  |	A <xsl:value-of select="format-number(currentHours,'0.0')"/>
											</fo:inline>
											<fo:inline>						  											
											  |	R <xsl:value-of select="format-number(remainingHours,'0.0')"/>
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
	
	<xsl:template match="groundtimes/groundtimesOverview/timebarInfo">
		
	</xsl:template>

</xsl:stylesheet>
