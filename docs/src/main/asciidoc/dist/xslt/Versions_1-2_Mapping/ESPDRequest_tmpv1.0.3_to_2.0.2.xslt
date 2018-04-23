<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:X-test:UBL:Pre-award:QualificationApplicationRequest" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1" xmlns:espd-cac="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1" xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:espd="urn:com:grow:espd:2.0.2" xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1" xmlns:cac-old="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1" xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1" xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1" xmlns:util="java:java.util.UUID" xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="cev-cbc ccv-cbc cbc-old cev ccv cac-old ext espd-req espd-cac" xsi:schemaLocation="urn:X-test:UBL:Pre-award:QualificationApplicationRequest ../../../xsdrt/maindoc/UBL-QualificationApplicationRequest-2.2-Pre-award.xsd">
	<xsl:import href="./inc/common/RootElements.xslt"/>
	<xsl:import href="./inc/common/ContractingAuthorityData.xslt"/>
	<xsl:import href="./inc/common/ProcurementProjectLot.xslt"/>
	<xsl:import href="./inc/common/AdditionalDocumentReference.xslt"/>
	<xsl:import href="./inc/common/AvailableOnline.xslt"/>
	<xsl:import href="./inc/criteria/EO_DATA.SHELTERED_WORKSHOP.xslt"/>
	<xsl:import href="./inc/criteria/EO_DATA.SUBCONTRACTS.xslt"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Include the core elements of the each file (RootElements etc) -->
	<!--Template for non-existing TenderingCriterionProperty to ensure Semantics Interoperability-->
	<xsl:template name="TenderingCriterionPropertyEmptyCaption">
		<cac:TenderingCriterionProperty>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
				<xsl:value-of select="util:toString(util:randomUUID())"/>
			</cbc:ID>
			<cbc:Description>[Additional information; e.g. no evidences online]</cbc:Description>
			<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">CAPTION</cbc:TypeCode>
			<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">NONE</cbc:ValueDataTypeCode>
		</cac:TenderingCriterionProperty>
	</xsl:template>
	<xsl:template match="/">
		<!-- Transform the root node to 2.0.0 Mapping structure  -->
		<QualificationApplicationRequest xmlns="urn:X-test:UBL:Pre-award:QualificationApplicationRequest" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic" xmlns:espd="urn:com:grow:espd:2.0.2" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:util="java:java.util.UUID" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<!-- Since we add the root elements externally, start to apply templates from ccv:Criterion -->
			<xsl:call-template name="RootElements"/>
			<xsl:call-template name="ContractingAuthorityData"/>
			<xsl:call-template name="ProcurementProjectLot"/>
			<xsl:apply-templates select="//ccv:Criterion"/>
			<xsl:call-template name="AdditionalDocumentReference"/>
			<!-- AdditionalDocumentReference implementation-->
		</QualificationApplicationRequest>
	</xsl:template>
	<!-- Match with each elements to apply the mapping changes and create a structure to copy or recreate the values-->
	<xsl:template match="ccv:Criterion/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
	</xsl:template>
	<xsl:template match="ccv:Criterion/cbc-old:TypeCode">
		<cbc:CriterionTypeCode listID="CriteriaTypeCode" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">
			<xsl:apply-templates select="node()"/>
		</cbc:CriterionTypeCode>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:Criterion/cbc-old:Name">
		<cbc:Name>
			<xsl:apply-templates select="node()"/>
		</cbc:Name>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:Criterion/cbc-old:Description">
		<cbc:Description>
			<xsl:apply-templates select="node()"/>
		</cbc:Description>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<!--Legislation Implementation-->
	<xsl:template match="ccv:LegislationReference">
		<cac:Legislation>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
				<xsl:value-of select="util:toString(util:randomUUID())"/>
			</cbc:ID>
			<xsl:apply-templates/>
		</cac:Legislation>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/ccv-cbc:Title">
		<cbc:Title>
			<xsl:apply-templates select="node()"/>
		</cbc:Title>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/cbc-old:Description">
		<cbc:Description>
			<xsl:apply-templates select="node()"/>
		</cbc:Description>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/ccv-cbc:JurisdictionLevelCode">
		<cbc:JurisdictionLevel>
			<xsl:apply-templates select="node()"/>
		</cbc:JurisdictionLevel>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/ccv-cbc:Article">
		<cbc:Article>
			<xsl:apply-templates select="node()"/>
		</cbc:Article>
	</xsl:template>
	<xsl:template match="ccv:LegislationReference/cbc-old:URI">
		<cbc:URI>
			<xsl:apply-templates select="node()"/>
		</cbc:URI>
		<cac:Language>
			<cbc:LocaleCode listID="LanguageCodeEU" listAgencyName="EU-COM-GROW" listVersionID="2.0.2">EN</cbc:LocaleCode>
		</cac:Language>
	</xsl:template>
	<!--All the Criterion implementations start here ! -->
	<xsl:template match="ccv:Criterion">
		<xsl:choose>
			<xsl:when test="cbc-old:ID = '9c70375e-1264-407e-8b50-b9736bc08901'"> </xsl:when>
			<xsl:when test="cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.SHELTERED_WORKSHOP'">
				<xsl:call-template name="EO_DATA.SHELTERED"/>
			</xsl:when>
			<xsl:when test="cbc-old:TypeCode = 'CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES'">
				<xsl:call-template name="EO_DATA.SUBCONTRACTS"/>
			</xsl:when>
			<xsl:otherwise>
				<cac:TenderingCriterion>
					<xsl:apply-templates/>
				</cac:TenderingCriterion>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- In the RequirementGroup, due to some updates about TenderingCriterionPropertyGroup, these changes are implemented into structure-->
	<xsl:template match="ccv:RequirementGroup">
		<cac:TenderingCriterionPropertyGroup>
			<xsl:apply-templates select="node()"/>
			<xsl:choose>
				<xsl:when test="node()[cbc-old:ID = '9026e403-3eb6-4705-a9e9-e21a1efc867d']">
					<xsl:call-template name="availableOnline"/>
				</xsl:when>
				<xsl:when test="node()[cbc-old:ID = '7458d42a-e581-4640-9283-34ceb3ad4345']">
					<xsl:call-template name="availableOnlineUUIDChange"/>
				</xsl:when>
			</xsl:choose>
		</cac:TenderingCriterionPropertyGroup>
		<xsl:choose>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.MISCONDUCT.MC_PROFESSIONAL']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.MISCONDUCT.MARKET_DISTORTION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.CONFLICT_OF_INTEREST.MISINTERPRETATION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.SUBCONTRACTING_PROPORTION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.SOCIAL.ENVIRONMENTAL_LAW']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.SOCIAL.SOCIAL_LAW']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.SOCIAL.LABOUR_LAW']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
			<xsl:when test="parent::ccv:Criterion[cbc-old:TypeCode = 'CRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PARTICIPATION']">
				<xsl:call-template name="availableOnlineNotExist"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- SubsidiaryTenderingCriterionGroup implementation -->
	<xsl:template match="ccv:RequirementGroup[@pi]/ccv:RequirementGroup">
		<cac:SubsidiaryTenderingCriterionPropertyGroup>
			<xsl:apply-templates select="node()"/>
		</cac:SubsidiaryTenderingCriterionPropertyGroup>
	</xsl:template>
	<xsl:template match="ccv:RequirementGroup[@pi]/ccv:RequirementGroup/cbc-old:ID">
		<cbc:ID>
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
	</xsl:template>
	<xsl:template match="ccv:RequirementGroup/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
		<!-- Answers are implemented in the way of 2.0.2 structure -->
		<xsl:choose>
			<xsl:when test="parent::node()/ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_TRUE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:when test="parent::node()/ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_FALSE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONFALSE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:otherwise>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="not(following-sibling::ccv:Requirement)">
			<xsl:call-template name="TenderingCriterionPropertyEmptyCaption"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="ccv:Requirement">
		<cac:TenderingCriterionProperty>
			<xsl:apply-templates select="node()"/>
			<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
			<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">
				<!-- EVIDENCE_URL is no longer in use in 2.0.2-->
				<xsl:choose>
					<xsl:when test="@responseDataType = 'EVIDENCE_URL'">
						<xsl:value-of select="'EVIDENCE_IDENTIFIER'"/>
					</xsl:when>
					<xsl:when test="@responseDataType = 'PERIOD'">
						<xsl:value-of select="'DESCRIPTION'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@responseDataType"/>
					</xsl:otherwise>
				</xsl:choose>
			</cbc:ValueDataTypeCode>
		</cac:TenderingCriterionProperty>
	</xsl:template>
	<xsl:template match="ccv:Requirement/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<!-- We are not producing UUID automatically in 2.0.2 since it is already changed in 1.0.2 as a unique identifier in the new version of 1.0.3 -->
			<xsl:value-of select="node()"/>
		</cbc:ID>
	</xsl:template>
	<xsl:template match="ccv:Requirement/cbc-old:Description">
		<cbc:Description>
			<xsl:choose>
				<xsl:when test="node() = 'URL'">
					<xsl:value-of select="'Evidence supplied'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</cbc:Description>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:RequirementGroup[@pi]">
		<cac:SubsidiaryTenderingCriterionPropertyGroup>
			<xsl:apply-templates select="node() except (ccv:Requirement[cbc-old:Description = 'Code'] | ccv:Requirement[cbc-old:Description = 'Issuer'])"/>
		</cac:SubsidiaryTenderingCriterionPropertyGroup>
	</xsl:template>
	<!-- Select the values from v1.0.2 and apply them into 2.0.0 -->
	<xsl:template match="ccv:RequirementGroup[@pi]/cbc-old:ID">
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
			<xsl:apply-templates select="node()"/>
		</cbc:ID>
		<xsl:choose>
			<xsl:when test="parent::node()/ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_TRUE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
			</xsl:when>
			<xsl:when test="parent::node()/ccv:RequirementGroup[@pi = 'GROUP_FULFILLED.ON_FALSE']">
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONFALSE</cbc:PropertyGroupTypeCode>
			</xsl:when>
		<xsl:otherwise>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
