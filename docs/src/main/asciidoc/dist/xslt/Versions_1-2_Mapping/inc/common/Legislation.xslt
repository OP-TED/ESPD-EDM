<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:espd="urn:com:grow:espd:2.0.1" 
	xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" 
	xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
	xmlns:util="java:java.util.UUID"
	xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"
	xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:espd-cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2">
	
	<xsl:template name="Legislation" exclude-result-prefixes="#all">
		<cac:Legislation>
			<cbc:Title><xsl:value-of select="ccv-cbc:Title"/></cbc:Title>
			<cbc:Description><xsl:value-of select="cbc-old:Description"/></cbc:Description>
			<cbc:JurisdictionLevel><xsl:value-of select="ccv-cbc:JurisdictionLevelCode"/></cbc:JurisdictionLevel>
			<cbc:Article><xsl:value-of select="ccv-cbc:Article"/></cbc:Article>
			<cbc:URI><xsl:value-of select="cbc-old:URI"/></cbc:URI>
		</cac:Legislation>
	</xsl:template>	
</xsl:stylesheet>
