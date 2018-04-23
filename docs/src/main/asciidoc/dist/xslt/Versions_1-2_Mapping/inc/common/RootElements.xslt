<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" 
	xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic" 
	xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:util="java:java.util.UUID"
	exclude-result-prefixes="cbc cac cbc-old util">
	
	<xsl:template name="RootElements" exclude-result-prefixes="#all">
		
		<cbc:UBLVersionID schemeAgencyID="OASIS-UBL-TC">2.2</cbc:UBLVersionID>
		<cbc:CustomizationID schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0">ESPD-2.0.2</cbc:CustomizationID>	
		<cbc:ProfileID schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0">urn:www.cenbii.eu:transaction:biitrns092:ver3.0</cbc:ProfileID>
		<cbc:ProfileExecutionID schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">ESPD-EDMv2.0.2-REGULATED</cbc:ProfileExecutionID>
		<xsl:element name="cbc:ID">
			
			<xsl:attribute name="schemeID"><xsl:value-of select="node()/cbc-old:ID/@schemeID"/></xsl:attribute>
			<xsl:attribute name="schemeAgencyName"><xsl:value-of select="node()//cbc-old:ID/@schemeAgencyName"/></xsl:attribute>
			<xsl:attribute name="schemeAgencyID"><xsl:value-of select="node()/cbc-old:ID/@schemeAgencyID"/></xsl:attribute>
			<xsl:attribute name="schemeVersionID"><xsl:value-of select="node()/cbc-old:ID/@schemeVersionID"/></xsl:attribute>
			<xsl:value-of select="node()/cbc-old:ID"/>
		</xsl:element>
		
		<cbc:CopyIndicator><xsl:value-of select="node()/cbc-old:CopyIndicator"/></cbc:CopyIndicator> 
		<cbc:UUID schemeID="ISO/IEC 9834-8:2008 - 4UUID" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:UUID>
		<xsl:element name="cbc:ContractFolderID">
			<xsl:attribute name="schemeAgencyID"><xsl:value-of select="node()/cbc-old:ContractFolderID/@schemeAgencyID"/></xsl:attribute>
			<xsl:value-of select="node()/cbc-old:ContractFolderID"/>
		</xsl:element>
		<cbc:IssueDate><xsl:value-of select="node()/cbc-old:IssueDate"/></cbc:IssueDate>
		<cbc:IssueTime><xsl:value-of select="node()/cbc-old:IssueTime"/></cbc:IssueTime>	
		<cbc:VersionID schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0">1.0</cbc:VersionID>
		<!-- ######################### VERY IMPORTANT ##################################################### -->
		<!-- BEWARE THAT IN VERSION 1.0.2 INDICATING THE TYPE OF PROCUREMENT PROCEDURE WAS NOT MANDATORY, WHILST IN THE ESPD-EDM V2.0.x THIS ELEMENT IS COMPULSORY. PLEASE CORRECT THE CODE AFTER TRANSFORMATION!!! -->
		<xsl:text disable-output-escaping="yes">&lt;!--	######################### VERY IMPORTANT ##################################################### --&gt;</xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;!--	BEWARE THAT IN VERSION 1.0.2 INDICATING THE TYPE OF PROCUREMENT PROCEDURE WAS NOT MANDATORY, WHILST IN THE ESPD-EDM V2.0.x THIS ELEMENT IS COMPULSORY. PLEASE CORRECT THE CODE AFTER TRANSFORMATION!!! --&gt;</xsl:text>
		<cbc:ProcedureCode listID="ProcedureType"  listAgencyName="EU-COM-GROW" listVersionID="2.0.1">OPEN</cbc:ProcedureCode>
		<xsl:text disable-output-escaping="yes">&lt;!--	############################################################################################## --&gt;</xsl:text>
		<!-- ############################################################################################## -->
		
		<cbc:QualificationApplicationTypeCode listID="QualificationApplicationType"  listAgencyName="EU-COM-GROW" listVersionID="2.0.2">REGULATED</cbc:QualificationApplicationTypeCode>
		
	</xsl:template>
	
</xsl:stylesheet>
