<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:cac-old="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" 
	xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
	xmlns:util="java:java.util.UUID"
	xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2">
	<xsl:import href="ServiceProvider.xslt"/>
	<xsl:template name="ContractingAuthorityData" exclude-result-prefixes="#all">
	<cac:ContractingParty>
		<xsl:apply-templates mode="copy" select="node()/cac-old:ContractingParty/* except(node()/cac-old:ContractingParty/cac-old:Party)"/>
	
	<cac:Party>
	<xsl:apply-templates mode="copy" select="node()/cac-old:ContractingParty/cac-old:Party/*"/>
	<xsl:choose>
		<xsl:when test="node()/cac-old:ContractingParty/cac-old:Party/last()">
			<xsl:if test="not(node()/cac-old:ContractingParty/cac-old:Party/cac-old:ServiceProviderParty)">
		<xsl:if test="node()/name()='espd-req:ESPDRequest'">
			
			<xsl:call-template name="ServiceProvider"/>
		</xsl:if>
		</xsl:if>
		</xsl:when>
	</xsl:choose>
	</cac:Party>
	</cac:ContractingParty>
	
	</xsl:template>
	
	<xsl:template match="*" mode="copy">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*|node()" mode="copy" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="@*|text()|comment()" mode="copy">
		<xsl:copy/>
	</xsl:template>
	
</xsl:stylesheet>
