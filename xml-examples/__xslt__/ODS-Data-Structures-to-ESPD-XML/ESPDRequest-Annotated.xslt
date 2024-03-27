<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 3 (x64) (http://www.altova.com) by everis Spain, S.L. (everis Spain, S.L.) -->
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
	
	<xsl:template name="createLegislation">
		<cac:Legislation>
			<xsl:call-template name="generateID"/>
			<cbc:Title>[Legislation title]</cbc:Title>
			<cbc:Description>[Legislation description]</cbc:Description>
			<cbc:JurisdictionLevel>EU</cbc:JurisdictionLevel>
			<cbc:Article>[Article, e.g. Article 2.I.a]</cbc:Article>
			<cbc:URI>http://eur-lex.europa.eu/</cbc:URI>
			<cac:Language>
				<cbc:LocaleCode listID="http://publications.europa.eu/resource/authority/language" listAgencyID="ISO"
					listVersionID="20220928-0">ENG</cbc:LocaleCode>
			</cac:Language>
		</cac:Legislation>
	</xsl:template> 
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="office:body">
		<QualificationApplicationRequest
			xmlns="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
			xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
			xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2 ../xsdrt/maindoc/UBL-QualificationApplicationRequest-2.3.xsd">
			<xsl:call-template name="createRootElements"/>
			<xsl:call-template name="createContractingAuthority"/>
			<xsl:call-template name="createProcurementProject"/>
			<xsl:apply-templates select="office:spreadsheet/table:table"/>
		</QualificationApplicationRequest>
	</xsl:template>

	<xsl:template match="office:spreadsheet/table:table">
		<!--xsl:if test="@table:name='SC-Quality_assurance'"-->
		<xsl:apply-templates select="table:table-row/table:table-cell"/>
		<!--/xsl:if-->
	</xsl:template>

	<xsl:function name="espd:getCellContent">
		<xsl:param name="node"/>
		<xsl:param name="colpos"/>
		<xsl:value-of
			select="$node/ancestor::table:table-row/table:table-cell[sum(preceding-sibling::*/@table:number-columns-repeated) + position() - count(preceding-sibling::*/@table:number-columns-repeated) &lt;= $colpos][last()]/text:p/text()"
		/>
	</xsl:function>
	
	<xsl:variable name="criterionNumberCol" select="1"/>
	<xsl:variable name="nameCol" select="18"/>
	<xsl:variable name="descriptionCol" select="19"/>
	<xsl:variable name="valueExampleCol" select="20"/>
	<xsl:variable name="propertyDataTypeCol" select="22"/>
	<xsl:variable name="uuidCol" select="23"/>
	<xsl:variable name="elementCodeCol" select="24"/>
	<xsl:variable name="codelistCol" select="25"/>
	
	<xsl:variable name="numberEG" select="24"/>
	<xsl:variable name="numberSC" select="32"/>
	<xsl:variable name="indexStartSC" select="$numberEG + 1"/> <!-- 25 --> 
	<xsl:variable name="indexStartOT" select="$indexStartSC + $numberSC"/>
	
	<xsl:template match="table:table-row/table:table-cell">
		<xsl:variable name="p" select="./text:p"/>
		<xsl:choose>
			<xsl:when test="$p = '{CRITERION'"> 
				<!-- get and test criterion number --> 
				<xsl:variable name="cnumber" select="espd:getCellContent(., $criterionNumberCol)"/> 
				<xsl:if test="$cnumber &lt; $indexStartSC">
					<xsl:call-template name="createCriterionEG"/>
				</xsl:if> 
				<xsl:if test="$cnumber &gt; $numberEG">
					<xsl:call-template name="createCriterionSC"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$p = 'CRITERION}'">				
				<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>cac:TenderingCriterion<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			</xsl:when>
			<xsl:when test="$p = '{SUBCRITERION'">
				<xsl:call-template name="createSubCriterion"/>
			</xsl:when>
			<xsl:when test="$p = 'SUBCRITERION}'">
				<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>cac:SubTenderingCriterion<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			</xsl:when>
			<xsl:when test="$p = '{LEGISLATION}'">
				<xsl:call-template name="createLegislation"/>
			</xsl:when>
			<xsl:when test="$p = '{REQUIREMENT_GROUP' or $p = '{QUESTION_GROUP'">
				<xsl:call-template name="createGroup"/>
			</xsl:when>
			<xsl:when test="$p = 'REQUIREMENT_GROUP}' or $p = 'QUESTION_GROUP}'">				
				<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>cac:TenderingCriterionPropertyGroup<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			</xsl:when>
			<xsl:when test="$p = '{REQUIREMENT_SUBGROUP' or $p = '{QUESTION_SUBGROUP'">
				<xsl:call-template name="createSubGroup"/>
			</xsl:when>
			<xsl:when test="$p = 'REQUIREMENT_SUBGROUP}' or $p = 'QUESTION_SUBGROUP}'">				
				<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>cac:SubsidiaryTenderingCriterionPropertyGroup<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			</xsl:when>
			<xsl:when test="$p = '{REQUIREMENT}' or $p = '{QUESTION}' or $p = '{CAPTION}'">
				<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:TenderingCriterionProperty<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				<xsl:call-template name="createProperty"/>
				<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>cac:TenderingCriterionProperty<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="createID">
		<cbc:ID schemeID="Criterion" schemeAgencyID="OP" schemeVersionID="4.0.0">
			<xsl:value-of select="espd:getCellContent(., $uuidCol)"/>
		</cbc:ID>
	</xsl:template> 
	
	<xsl:template name="createTypeCode">
		<xsl:variable name="code" select="espd:getCellContent(., $elementCodeCol)"/>
		<xsl:for-each select="ancestor-or-self::table:table-row/table:table-cell">
			<xsl:choose>
				<xsl:when test="text:p = '{CRITERION'">
					<cbc:CriterionTypeCode listID="http://publications.europa.eu/resource/authority/criterion" listAgencyID="OP"
						listVersionID="20230315-0">
						<xsl:value-of select="$code"/>
					</cbc:CriterionTypeCode>
				</xsl:when>
				<xsl:when
					test="text:p = '{REQUIREMENT_GROUP' or text:p = '{QUESTION_GROUP' or text:p = '{REQUIREMENT_SUBGROUP' or text:p = '{QUESTION_SUBGROUP'">
					<cbc:PropertyGroupTypeCode listID="property-group-type" listAgencyID="OP"
						listVersionID="4.0.0">
						<xsl:value-of select="$code"/>
					</cbc:PropertyGroupTypeCode>
				</xsl:when>
				<xsl:when test="text:p = '{CAPTION}'">
					<cbc:TypeCode listID="criterion-element-type" listAgencyID="OP"
						listVersionID="4.0.0">CAPTION</cbc:TypeCode>
				</xsl:when>
				<xsl:when test="text:p = '{REQUIREMENT}'">
					<cbc:TypeCode listID="criterion-element-type" listAgencyID="OP"
						listVersionID="4.0.0">REQUIREMENT</cbc:TypeCode>
				</xsl:when>
				<xsl:when test="text:p = '{QUESTION}'">
					<cbc:TypeCode listID="criterion-element-type" listAgencyID="OP"
						listVersionID="4.0.0">QUESTION</cbc:TypeCode>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template> 
	
	<xsl:template name="createDescription">
		<cbc:Description>
			<xsl:value-of select="espd:getCellContent(., $descriptionCol)"/>
		</cbc:Description>
	</xsl:template> 
	
	<xsl:template name="createName">
		<xsl:variable name="name" select="espd:getCellContent(., $nameCol)"/>
	    <xsl:if test="string-length(fn:normalize-space($name)) &gt; 0">
	        <!-- <xsl:if test="string-length($name) &gt; 1"> -->
			<cbc:Name>
				<xsl:value-of select="$name"/>
			</cbc:Name>
		</xsl:if>
	</xsl:template> 
	
	<xsl:template name="createProcurementProjectLotReference">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:ProcurementProjectLotReference<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<cbc:ID schemeID="Criterion" schemeAgencyID="OP" schemeVersionID="4.0.0">LOT-0000</cbc:ID>
		<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>cac:ProcurementProjectLotReference<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template name="createCriterionEG">
		<xsl:text disable-output-escaping="yes">&lt;!-- Criterion:</xsl:text>
		<xsl:value-of select="espd:getCellContent(., $nameCol)"/>
		<xsl:text disable-output-escaping="yes"> --&gt;</xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:TenderingCriterion<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:call-template name="createID"/>
		<xsl:call-template name="createTypeCode"/>
		<xsl:call-template name="createName"/>
		<xsl:call-template name="createDescription"/> 
	</xsl:template> 
	
	<xsl:template name="createCriterionSC">
		<xsl:text disable-output-escaping="yes">&lt;!-- Criterion:</xsl:text>
		<xsl:value-of select="espd:getCellContent(., $nameCol)"/>
		<xsl:text disable-output-escaping="yes"> --&gt;</xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:TenderingCriterion<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:call-template name="createID"/>
		<xsl:call-template name="createTypeCode"/>
		<xsl:call-template name="createName"/>
		<xsl:call-template name="createDescription"/>	
		<xsl:call-template name="createProcurementProjectLotReference"/>
	</xsl:template> 
	
	<xsl:template name="createSubCriterion">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:SubTenderingCriterion<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:call-template name="createID"/>
		<xsl:call-template name="createTypeCode"/>
		<xsl:call-template name="createName"/>
		<xsl:call-template name="createDescription"/>
	</xsl:template> 
	
	<xsl:template name="createGroup">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:TenderingCriterionPropertyGroup<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:call-template name="createID"/>
		<xsl:call-template name="createTypeCode"/>
	</xsl:template> 
	
	<xsl:template name="createSubGroup">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>cac:SubsidiaryTenderingCriterionPropertyGroup<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:call-template name="createID"/>
		<xsl:call-template name="createTypeCode"/>
	</xsl:template>
	
	<xsl:template name="createDataTypeValue">
		<xsl:variable name="dataTypeValue" select="espd:getCellContent(., $propertyDataTypeCol)"/>
		<xsl:choose>
			<xsl:when test="$dataTypeValue = ''">
				<cbc:ValueDataTypeCode listID="response-data-type" listAgencyID="OP"
					listVersionID="4.0.0">NONE</cbc:ValueDataTypeCode>
			</xsl:when>
			<xsl:when test="$dataTypeValue != ''">
				<cbc:ValueDataTypeCode listID="response-data-type" listAgencyID="OP"
					listVersionID="4.0.0">
					<xsl:value-of select="$dataTypeValue"/> 
				</cbc:ValueDataTypeCode>
			</xsl:when>
		</xsl:choose>
	</xsl:template> 
	
	<xsl:template name="createExpectedRequirementValue">
		<xsl:for-each select="ancestor-or-self::table:table-row/table:table-cell">
			<xsl:if test="text:p = '{REQUIREMENT}'">
				<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!-- No answer is expected
				here from the economic operator, as this is a REQUIREMENT issued by the contracting
				authority. Hence the element 'cbc:ValueDataTypeCode' contains the type of value of
				the requirement issued by the contracting authority --<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				<xsl:variable name="propertyDataType" select="espd:getCellContent(., $propertyDataTypeCol)"/>
				<xsl:variable name="value" select="espd:getCellContent(., $valueExampleCol)"/>
				<xsl:variable name="codelistName" select="espd:getCellContent(., $codelistCol)"/>
				
				<xsl:choose> 
					
					<xsl:when test="$propertyDataType = 'AMOUNT'">
						<cbc:ExpectedAmount currencyID="EUR">
							<xsl:value-of select="$value"/>
						</cbc:ExpectedAmount>
					</xsl:when> 
					
					<xsl:when
						test="
							$propertyDataType = 'IDENTIFIER' or $propertyDataType = 'EVIDENCE_IDENTIFIER' or $propertyDataType = 'ECONOMIC_OPERATOR_IDENTIFIER'
							or $propertyDataType = 'LOT_IDENTIFIER'">
						<cbc:ExpectedID schemeAgencyID="OP">
							<xsl:value-of select="$value"/>
						</cbc:ExpectedID>
					</xsl:when>
					
					<xsl:when test="$propertyDataType = 'CODE'">
						<xsl:if test="$codelistName = 'Occupation'">
							<cbc:ExpectedCode listID="http://publications.europa.eu/resource/authority/occupation" listAgencyID="EMPL" listVersionID="20221214-0">
								<xsl:value-of select="$value"/>
							</cbc:ExpectedCode>
						</xsl:if>
						<xsl:if test="$codelistName = 'FinancialRatioType'">
							<cbc:ExpectedCode listID="financial-ratio-type" listAgencyID="OP" listVersionID="4.0.0">
								<xsl:value-of select="$value"/>
							</cbc:ExpectedCode>
						</xsl:if>
						<xsl:if test="$codelistName = 'EORoleType'">
							<cbc:ExpectedCode listID="http://publications.europa.eu/resource/authority/eo-role-type" listAgencyID="OP" listVersionID="20211208-0"> 
								<xsl:value-of select="$value"/>
							</cbc:ExpectedCode>
						</xsl:if>
					</xsl:when>
					
					<xsl:when test="$propertyDataType = 'CODE_BOOLEAN'">
						<cbc:ExpectedCode listID="boolean-gui-control-type" listAgencyID="OP"
							listVersionID="4.0.0">
							<xsl:value-of select="$value"/>
						</cbc:ExpectedCode>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'CODE_COUNTRY'">
						<cbc:ExpectedCode listID="http://publications.europa.eu/resource/authority/country" listName="country"
							listAgencyID="ISO" listVersionID="20220928-0">
							<xsl:value-of select="$value"/>
						</cbc:ExpectedCode>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'ECONOMIC_OPERATOR_ROLE_CODE'">
						<cbc:ExpectedCode listID="http://publications.europa.eu/resource/authority/eo-role-type" listAgencyID="OP"
							listVersionID="20211208-0">
							<xsl:value-of select="$value"/>
						</cbc:ExpectedCode>
					</xsl:when> 
					
					<xsl:when test="$propertyDataType = 'DESCRIPTION'">
						<cbc:ExpectedDescription>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedDescription>
					</xsl:when> 
					
					<xsl:when test="$propertyDataType = 'PERCENTAGE'">
						<cbc:ValueUnitCode>PERCENTAGE</cbc:ValueUnitCode>
						<cbc:ExpectedValueNumeric>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedValueNumeric>
					</xsl:when> 
					
					<xsl:when test="$propertyDataType = 'DATE'">
						<cac:ApplicablePeriod>
							<cbc:StartDate>
								<xsl:value-of select="$value"/>
							</cbc:StartDate>
							<cbc:EndDate>
								<xsl:value-of select="$value"/>
							</cbc:EndDate>
						</cac:ApplicablePeriod>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'PERIOD'">
						<cac:ApplicablePeriod>
							<cbc:StartDate>
								<xsl:value-of select="$value"/>
							</cbc:StartDate>
							<cbc:EndDate>
								<xsl:value-of select="$value"/>
							</cbc:EndDate>
						</cac:ApplicablePeriod>
					</xsl:when> 
					
					<xsl:when test="$propertyDataType = 'QUANTITY_INTEGER'">
						<cbc:ExpectedValueNumeric>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedValueNumeric>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'QUANTITY_YEAR'">
						<cbc:ExpectedValueNumeric>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedValueNumeric>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'QUANTITY'">
						<cbc:ExpectedValueNumeric>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedValueNumeric>
					</xsl:when> 
					
					<xsl:when test="$propertyDataType = 'MAXIMUM_AMOUNT'">
						<cbc:ExpectedMaximumAmount>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedMaximumAmount>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'MINIMUM_AMOUNT'">
						<cbc:ExpectedMinimumAmount>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedMinimumAmount>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'MAXIMUM_VALUE_NUMERIC'">
						<cbc:ExpectedMaximumValueNumeric>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedMaximumValueNumeric>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'MINIMUM_VALUE_NUMERIC'">
						<cbc:ExpectedMinimumValueNumeric>
							<xsl:value-of select="$value"/>
						</cbc:ExpectedMinimumValueNumeric>
					</xsl:when> 
					
					<xsl:when test="$propertyDataType = 'TRANSLATION_TYPE_CODE'">
						<cbc:TranslationTypeCode>
							<xsl:value-of select="$value"/>
						</cbc:TranslationTypeCode>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'COPY_QUALITY_TYPE_CODE'">
						<cbc:CopyQualityTypeCode>
							<xsl:value-of select="$value"/>
						</cbc:CopyQualityTypeCode>
					</xsl:when>
					<xsl:when test="$propertyDataType = 'CERTIFICATION_LEVEL_DESCRIPTION'">
						<cbc:CertificationLevelDescription>
							<xsl:value-of select="$value"/>
						</cbc:CertificationLevelDescription>
					</xsl:when>
					
				</xsl:choose>
				
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="createProperty">
		<xsl:call-template name="generateID"/>
		<xsl:call-template name="createName"/>
		<xsl:call-template name="createDescription"/>
		<xsl:call-template name="createTypeCode"/>
		<xsl:call-template name="createDataTypeValue"/>
		<xsl:call-template name="createExpectedRequirementValue"/>
	</xsl:template>
	
</xsl:stylesheet>
