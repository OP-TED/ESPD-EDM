<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 3 (x64) (http://www.altova.com) by everis Spain, S.L. (everis Spain, S.L.) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:espd="urn:com:grow:espd:02.00.00" xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
xmlns:util="java:java.util.UUID">	
	<xsl:include href="./RootElements-Annotated.xslt"/>
	<xsl:include href="./ContractingAuthorityData.xslt"/>	
	<xsl:include href="./EconomicOperatorData.xslt"/>		
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/">
		<QualificationApplicationResponse xmlns="urn:X-test:UBL:Pre-award:QualificationApplicationResponse" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic" xsi:schemaLocation="urn:X-test:UBL:Pre-award:QualificationApplicationResponse ../xsdrt/maindoc/UBL-QualificationApplicationResponse-2.2-Pre-award.xsd">
		<xsl:call-template name="createRootElements"/>
		<xsl:call-template name="createContractingAuthority"/>
		<xsl:call-template name="createEconomicOperator"/>	
		<xsl:apply-templates/>
		<xsl:call-template name="createEvidence"/>
	</QualificationApplicationResponse>
	</xsl:template>
	<xsl:template match="*">
		<xsl:for-each select="descendant::cac:TenderingCriterionProperty">
		<xsl:call-template name="createAnswer"/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="createAnswer">
		<xsl:variable name="propertyType" select="cbc:TypeCode"/>
		<xsl:if test="$propertyType = 'QUESTION'">
				
		<cac:TenderingCriterionResponse>
				<xsl:call-template name="getPropertyID"/>
				<cbc:ConfidentialityLevelCode listID="ConfidentialityLevel" listAgencyID="EU-COM-GROW" listVersionID="02.00.00"/>
				<xsl:call-template name="createPeriod"/>
				<xsl:call-template name="createEvidenceSupplied"/>		
				<xsl:call-template name="createResponseValue"/>
			</cac:TenderingCriterionResponse>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="getPropertyID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="02.00.00"><xsl:value-of select="cbc:ID"/></cbc:ID></xsl:template>

	<xsl:template name="createEvidenceSupplied">
		<xsl:variable name="propertyDataType" select="cbc:ValueDataTypeCode"/>		
		<xsl:if test="$propertyDataType = 'EVIDENCE_URL'">
			<cac:EvidenceSupplied><cbc:ID>EVIDENCE-00001</cbc:ID></cac:EvidenceSupplied>	
		</xsl:if>
	</xsl:template>

	<xsl:template name="createEvidence">
		<cac:Evidence>
			<cbc:ID schemeAgencyID="EU-COM-GROW">EVIDENCE-00001</cbc:ID>
			<cbc:ConfidentialityLevelCode listID="ConfidentialityLevel" listAgencyID="EU-COM-GROW" listVersionID="02.00.00">CONFIDENTIAL</cbc:ConfidentialityLevelCode>
			<cac:DocumentReference>
				<cbc:ID schemeAgencyID="EU-COM-GROW">SAT-11121233</cbc:ID>
				<cac:Attachment>
					<cac:ExternalReference>
						<cbc:URI>http:dod.gov.usa/sat/it/soft/prk?id=11121233</cbc:URI>
					</cac:ExternalReference>
				</cac:Attachment>
				<cac:IssuerParty>
					<cac:PartyName>
						<cbc:Name>USA DoD</cbc:Name>
					</cac:PartyName>
				</cac:IssuerParty>
			</cac:DocumentReference>
		</cac:Evidence>
	</xsl:template>
		
	<xsl:template name="createPeriod">
		<xsl:variable name="propertyDataType" select="cbc:ValueDataTypeCode"/>
			<xsl:if test="$propertyDataType = 'PERIOD'">
					<cac:ApplicablePeriod>
						<cbc:StartDate>2017-01-01</cbc:StartDate><cbc:EndDate>2017-01-01</cbc:EndDate>
					</cac:ApplicablePeriod>	
			</xsl:if>
		</xsl:template>	

	<xsl:template name="createResponseValue">
	<xsl:variable name="propertyDataType" select="cbc:ValueDataTypeCode"/>
		<xsl:choose>
			<xsl:when test="$propertyDataType = 'INDICATOR'">
				<cac:ResponseValue>
					<cbc:ResponseIndicator>true</cbc:ResponseIndicator>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'AMOUNT'">
				<cac:ResponseValue>
					<cbc:ResponseAmount currencyID="EUR">10000000</cbc:ResponseAmount>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'IDENTIFIER'">
				<cac:ResponseValue>
					<cbc:ResponseID>DUMMY_ID</cbc:ResponseID>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'CODE'">
				<cac:ResponseValue>
					<cbc:ResponseCode schemeAgencyID="EU-COM-GROW" schemeVersionID="02.00.00">DUMMY_CODE</cbc:ResponseCode>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'CODE_COUNTRY'">
				<cac:ResponseValue>
					<cbc:ResponseCode listID="CountryCodeIdentifier" listName="ISO-1-ALPHA-2" listAgencyID="ISO" listVersionID="1.0">DUMMY_COUNTRY_CODE</cbc:ResponseCode>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'DATE'">
				<cac:ResponseValue>
					<cbc:ResponseDate>2014-01-01</cbc:ResponseDate>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'DESCRIPTION'">
				<cac:ResponseValue>
					<cbc:Description>DUMMY_DESCRIPTION</cbc:Description>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'PERCENTAGE'">
				<cac:ResponseValue>
					<cbc:ResponseMeasure unitCode="PERCENTAGE">0.7</cbc:ResponseMeasure>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'QUANTITY_INTEGER'">
				<cac:ResponseValue>
					<cbc:ResponseMeasure unitCode="INTEGER">1</cbc:ResponseMeasure>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'QUANTITY_YEAR'">
				<cac:ResponseValue>
					<cbc:ResponseMeasure unitcode="YEAR">2017</cbc:ResponseMeasure>
				</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'QUANTITY'">
					<cac:ResponseValue>
					<cbc:ResponseQuantity>10</cbc:ResponseQuantity>
			</cac:ResponseValue>
			</xsl:when>
			<xsl:when test="$propertyDataType = 'TIME'">
				<cac:ResponseValue>
					<cbc:ResponseTime>09:00:00</cbc:ResponseTime>
				</cac:ResponseValue>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
