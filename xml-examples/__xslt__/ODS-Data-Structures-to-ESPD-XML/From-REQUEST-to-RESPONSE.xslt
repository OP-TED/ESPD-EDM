<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
	xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" 
	xmlns:espd="urn:com:grow:espd:4.0.0" 
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
	xmlns:util="java:java.util.UUID">
	
	<xsl:include href="./inc/RootElements-Annotated.xslt"/>
	<xsl:include href="./inc/ContractingAuthorityData-RequestResponse.xslt"/> 
	
	<xsl:include href="./inc/EconomicOperatorData.xslt"/> 
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
		
	<xsl:template name="generateID">
		<cbc:ID schemeID="Criterion" schemeAgencyID="XXXESPD-SERVICEXXX" schemeVersionID="4.0.0">
			<xsl:value-of select="util:toString(util:randomUUID())"/>
		</cbc:ID>
	</xsl:template> 

	<xsl:template name="createProcurementProject">
		<cac:ProcurementProject>
			<!-- <xsl:call-template name="generateID"/> -->
			<cbc:Description>Description of Project.</cbc:Description>
		</cac:ProcurementProject>
	</xsl:template> 
	
	<xsl:template name="createProcurementProjectLot">
		<cac:ProcurementProjectLot>
			<cbc:ID schemeID="Criterion" schemeAgencyID="OP" schemeVersionID="4.0.0">LOT-0000</cbc:ID>
		</cac:ProcurementProjectLot>
	</xsl:template> 
		
	<xsl:template match="/">
		<QualificationApplicationResponse
			xmlns="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
			xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
			xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2 ../xsdrt/maindoc/UBL-QualificationApplicationResponse-2.3.xsd">
			<xsl:call-template name="createRootElements"/>
			<xsl:call-template name="createContractingAuthority"/>
			<xsl:call-template name="createEconomicOperator"/>
			<xsl:call-template name="createProcurementProject"/>		
			<xsl:call-template name="createProcurementProjectLot"/>	
			<xsl:apply-templates/>
			<xsl:call-template name="createEvidence"/>
		</QualificationApplicationResponse>
	</xsl:template> 
	
	<xsl:template match="*">
	
		<!-- only for development do not use in Production --> 		
		<!--  --><xsl:copy-of select="descendant::cac:TenderingCriterion"/> 
		
		<xsl:for-each select="descendant::cac:TenderingCriterion">
			<xsl:variable name="criterionName" select="cbc:Name"/>
			<xsl:variable name="propertyGroupType" select="cbc:PropertyGroupTypeCode"/>
				<xsl:for-each select="descendant::cac:TenderingCriterionProperty">
					<xsl:call-template name="createAnswer">
						<xsl:with-param name="criterion" select="$criterionName"/>
					</xsl:call-template>
				</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="createAnswer">
		<xsl:param name="criterion"/>
		<xsl:variable name="propertyName" select="./cbc:Description"/>
		<xsl:variable name="propertyID" select="./cbc:ID"/>		
		<xsl:variable name="propertyType" select="cbc:TypeCode"/>
		
		<xsl:if test="$propertyType = 'QUESTION'"> 
			<xsl:variable name="indicator" select="./cbc:ValueDataTypeCode"/>		
			<xsl:variable name="pgtc" select="../cbc:PropertyGroupTypeCode"/>
			<xsl:variable name="onfalse" select="./ancestor::cac:SubsidiaryTenderingCriterionPropertyGroup/cbc:PropertyGroupTypeCode[.='ONFALSE']"/>
				
			<xsl:text disable-output-escaping="yes">&lt;!-- Answer to Criterion:</xsl:text>
			<xsl:value-of select="$criterion"/>
			<xsl:text disable-output-escaping="yes"> --&gt;</xsl:text>
			
			<xsl:text disable-output-escaping="yes">&lt;!-- Property:</xsl:text>
			<xsl:value-of select="$propertyName"/> (PropertyID:<xsl:value-of select="$propertyID"/>) 
			<xsl:text disable-output-escaping="yes"> --&gt;</xsl:text>
			
			<!--
			<xsl:comment>  Answer to Criterion: <xsl:value-of select="$criterion"/> </xsl:comment>
			<xsl:comment>  Property: <xsl:value-of select="$propertyName"/> (PropertyID:<xsl:value-of select="$propertyID"/>) </xsl:comment>
			-->
			
			<xsl:choose> 				
				<!-- It is a switch question that does contain ONTRUE and/or ON* --> <!-- and not($pgtc = 'ONFALSE') -->
				<xsl:when test="$indicator = 'INDICATOR' and not($onfalse = 'ONFALSE')">
					<cac:TenderingCriterionResponse>
							<xsl:call-template name="generateID"/>
							<cbc:ValidatedCriterionPropertyID schemeID="Criterion" schemeAgencyID="XXXESPD-SERVICEXXX" schemeVersionID="4.0.0"> 
								<xsl:value-of select="cbc:ID"/> 
							</cbc:ValidatedCriterionPropertyID>
							<xsl:call-template name="createPeriod"/>
							<xsl:call-template name="createEvidenceSupplied"/>		
							<xsl:call-template name="createResponseValue">
								<xsl:with-param name="booleanVal">true</xsl:with-param>
							</xsl:call-template>
					</cac:TenderingCriterionResponse>
				</xsl:when>
				
				<!-- It is a non switch question/normal simple question --> <!-- and not($pgtc = 'ONFALSE') --> 
				<xsl:when test="not($indicator = 'INDICATOR') and not($onfalse = 'ONFALSE')">
					<cac:TenderingCriterionResponse>
							<xsl:call-template name="generateID"/>
							<cbc:ValidatedCriterionPropertyID schemeID="Criterion" schemeAgencyID="XXXESPD-SERVICEXXX" schemeVersionID="4.0.0"> 
								<xsl:value-of select="cbc:ID"/> 
							</cbc:ValidatedCriterionPropertyID>
							<xsl:call-template name="createPeriod"/>
							<xsl:call-template name="createEvidenceSupplied"/>		
							<xsl:call-template name="createResponseValue">
								<xsl:with-param name="booleanVal">true</xsl:with-param>
							</xsl:call-template>
					</cac:TenderingCriterionResponse>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		
	</xsl:template>
	
	<xsl:template name="createPeriod">
		<xsl:variable name="propertyDataType" select="cbc:ValueDataTypeCode"/>
		<xsl:if test="$propertyDataType = 'PERIOD'">
			<cac:ApplicablePeriod>
				<cbc:StartDate>2017-01-01</cbc:StartDate>
				<cbc:EndDate>2017-12-12</cbc:EndDate>
			</cac:ApplicablePeriod>	
		</xsl:if>
	</xsl:template>	
	
	<xsl:template name="createEvidenceSupplied">
		<xsl:variable name="propertyDataType" select="cbc:ValueDataTypeCode"/>		
		<xsl:if test="$propertyDataType = 'EVIDENCE_IDENTIFIER'">
			<cac:EvidenceSupplied>
				<cbc:ID schemeAgencyID="OP">EVIDENCE-0001</cbc:ID>
			</cac:EvidenceSupplied>	
		</xsl:if>
	</xsl:template>

	<xsl:template name="createEvidence">
		<cac:Evidence>
			<cbc:ID schemeAgencyID="XXXAGENCYXXX">EVIDENCE-0001</cbc:ID>
			<cbc:ConfidentialityLevelCode listID="http://publications.europa.eu/resource/authority/access-right" listAgencyID="OP" listVersionID="20220316-0">CONFIDENTIAL</cbc:ConfidentialityLevelCode>
			<cac:DocumentReference>
				<cbc:ID schemeAgencyID="XXXAGENCYXXX">SAT-11121233</cbc:ID>
				<cac:Attachment>
					<cac:ExternalReference>
						<cbc:URI>http:dod.gov.usa/sat/it/soft/prk?id=11121233</cbc:URI>
					</cac:ExternalReference>
				</cac:Attachment>
				<cac:IssuerParty>
					<cac:PartyIdentification>
						<cbc:ID schemeAgencyID="XXXAGENCYXXX">XXXXXXXX</cbc:ID>
					</cac:PartyIdentification>
					<cac:PartyName>
						<cbc:Name>USA DoD</cbc:Name>
					</cac:PartyName>
				</cac:IssuerParty>
			</cac:DocumentReference>
		</cac:Evidence>
	</xsl:template>
		
	<xsl:template name="createResponseValue">
		<xsl:param name="booleanVal" />
		<xsl:variable name="propertyDataType" select="cbc:ValueDataTypeCode"/>
		<xsl:variable name="codelistNameListID" select="cbc:ExpectedCode/@listID"/>
		<xsl:if test="$propertyDataType != 'PERIOD' and $propertyDataType != 'EVIDENCE_IDENTIFIER'">
			<cac:ResponseValue>
				<xsl:call-template name="generateID"/>
				<xsl:choose>
					<xsl:when test="$propertyDataType = 'DESCRIPTION'">
						<cbc:Description>DUMMY_DESCRIPTION</cbc:Description>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'INDICATOR'">
						<cbc:ResponseIndicator><xsl:value-of select="$booleanVal"/></cbc:ResponseIndicator>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'IDENTIFIER'">
							<cbc:ResponseID schemeAgencyID="OP">DUMMY_ID</cbc:ResponseID>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'ECONOMIC_OPERATOR_IDENTIFIER'">
						<cbc:ResponseID schemeAgencyID="XXXEOIDXXX">DUMMY_EO_ID</cbc:ResponseID>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'QUAL_IDENTIFIER'">
						<cbc:ResponseID schemeAgencyID="XXXQUALIDXXX">DUMMY_QUAL_ID</cbc:ResponseID>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'URL'">
						<cbc:ResponseURI>www.dummyURL.com</cbc:ResponseURI>
					</xsl:when>
					
					<xsl:when test="$propertyDataType = 'CODE'">
						<!-- <cbc:ResponseCode listAgencyID="OP" listVersionID="yyyymmdd-0" listID="PleaseSpecifyTheCorrectOne">DUMMY_CODE</cbc:ResponseCode> -->
						<xsl:choose>
							<xsl:when test="$codelistNameListID = 'http://publications.europa.eu/resource/authority/occupation'">
								<cbc:ResponseCode listAgencyID="EMPL" listVersionID="20221214-0" listID="http://publications.europa.eu/resource/authority/occupation">DUMMY_CODE</cbc:ResponseCode>
							</xsl:when>
							<xsl:when test="$codelistNameListID = 'financial-ratio-type'">
								<cbc:ResponseCode listAgencyID="OP" listVersionID="4.0.0" listID="financial-ratio-type">DUMMY_CODE</cbc:ResponseCode>
							</xsl:when>
							<xsl:when test="$codelistNameListID = 'http://publications.europa.eu/resource/authority/eo-role-type'">
								<cbc:ResponseCode listAgencyID="OP" listVersionID="20211208-0" listID="http://publications.europa.eu/resource/authority/eo-role-type">DUMMY_CODE</cbc:ResponseCode>
							</xsl:when>
							<xsl:otherwise>
								<cbc:ResponseCode listAgencyID="OP" listVersionID="20211208-0" listID="http://publications.europa.eu/resource/authority/eo-role-type">DUMMY_CODE</cbc:ResponseCode> 
							</xsl:otherwise>
						</xsl:choose> 
					</xsl:when>
					
					<xsl:when test="$propertyDataType = 'CODE_COUNTRY'">
						<cbc:ResponseCode listID="http://publications.europa.eu/resource/authority/country" listName="country" listAgencyID="ISO" listVersionID="20220928-0">BEL</cbc:ResponseCode>
					</xsl:when>
					
					<xsl:when test="$propertyDataType = 'AMOUNT'">
						<cbc:ResponseAmount currencyID="EUR">10000000</cbc:ResponseAmount>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'PERCENTAGE'">
						<cbc:ResponseNumeric format="PERCENTAGE">0.7</cbc:ResponseNumeric>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'QUANTITY_INTEGER'">
						<!-- <cbc:ResponseMeasure unitCode="INTEGER">1</cbc:ResponseMeasure> -->
						<cbc:ResponseQuantity unitCode="INTEGER">1</cbc:ResponseQuantity>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'QUANTITY_YEAR'">
						<cbc:ResponseQuantity unitCode="YEAR">2017</cbc:ResponseQuantity>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'QUANTITY'">
							<cbc:ResponseQuantity>10</cbc:ResponseQuantity>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'DATE'">
						<cbc:ResponseDate>2014-01-01</cbc:ResponseDate>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'TIME'">
							<cbc:ResponseTime>09:00:00</cbc:ResponseTime>
					</xsl:when>
				</xsl:choose>
			</cac:ResponseValue>
		</xsl:if>
	</xsl:template> 
	
</xsl:stylesheet>
