<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate"
    xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
    xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
    xmlns:util="java:java.util.UUID"    
    exclude-result-prefixes="#all"
    version="2.0">
    

<xsl:template name="EO_DATA.SHELTERED">

<cac:TenderingCriterion>
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">2043338f-a38a-490b-b3ec-2607cb25a017</cbc:ID>
		<cbc:CriterionTypeCode listID="CriteriaTypeCode" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">CRITERION.OTHER.EO_DATA.SHELTERED_WORKSHOP</cbc:CriterionTypeCode>
		<cbc:Name>EO is a sheltered workshop</cbc:Name>
		<cbc:Description>Only in case the procurement is reserved: is the economic operator a sheltered workshop, a 'social business' or will it provide for the performance of the contract in the context of sheltered employment programmes?</cbc:Description>
		<cac:TenderingCriterionPropertyGroup>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">6febbe4a-e715-427c-a2b1-19cfabadaef0</cbc:ID>
			<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
			<cac:TenderingCriterionProperty>
				<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
				<cbc:Description>Your answer?</cbc:Description>
				<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
				<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">INDICATOR</cbc:ValueDataTypeCode>
			</cac:TenderingCriterionProperty>
			<cac:SubsidiaryTenderingCriterionPropertyGroup>
				<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">a5e33369-e2b5-45f7-9969-ddb1c3ae17c8</cbc:ID>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
				<cac:TenderingCriterionProperty>
					<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
					<cbc:Description>What is the corresponding percentage of disabled or disadvantaged workers?</cbc:Description>
					<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
					<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">PERCENTAGE</cbc:ValueDataTypeCode>
				</cac:TenderingCriterionProperty>
				<cac:TenderingCriterionProperty>
					<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
					<cbc:Description>If required, please provide details on whether the employees concerned belong to a specific category of disabled or disadvantaged workers?</cbc:Description>
					<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
					<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">DESCRIPTION</cbc:ValueDataTypeCode>
				</cac:TenderingCriterionProperty>
			</cac:SubsidiaryTenderingCriterionPropertyGroup>
		</cac:TenderingCriterionPropertyGroup>
		<cac:TenderingCriterionPropertyGroup>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">7458d42a-e581-4640-9283-34ceb3ad4345</cbc:ID>
			<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
			<cac:TenderingCriterionProperty>
				<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
				<cbc:Description>Is this information available electronically?</cbc:Description>
				<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
				<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">INDICATOR</cbc:ValueDataTypeCode>
			</cac:TenderingCriterionProperty>
			<cac:SubsidiaryTenderingCriterionPropertyGroup>
				<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">41dd2e9b-1bfd-44c7-93ee-56bd74a4334b</cbc:ID>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
				<cac:TenderingCriterionProperty>
					<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
					<cbc:Description>Evidence supplied</cbc:Description>
					<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
					<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">EVIDENCE_IDENTIFIER</cbc:ValueDataTypeCode>
				</cac:TenderingCriterionProperty>
			</cac:SubsidiaryTenderingCriterionPropertyGroup>
		</cac:TenderingCriterionPropertyGroup>
	</cac:TenderingCriterion>
</xsl:template>

</xsl:stylesheet>