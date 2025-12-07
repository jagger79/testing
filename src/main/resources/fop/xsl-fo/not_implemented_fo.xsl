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
	
	<xsl:template match="/*[position() = 1]">	
		<fo:block>
		Sorry, but page is not impemented yet.
		</fo:block>
	</xsl:template>
		
</xsl:stylesheet>
