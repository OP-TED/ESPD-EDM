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
    
<xsl:template name="EO_DATA.SUBCONTRACTS">

        <cac:TenderingCriterion>
		<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">72c0c4b1-ca50-4667-9487-461f3eed4ed7</cbc:ID>
		<cbc:CriterionTypeCode listID="CriteriaTypeCode" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">CRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIES</cbc:CriterionTypeCode>
		<cbc:Name>Not relied on entities</cbc:Name>
		<cbc:Description>Does the economic operator intend to subcontract any share of the contract to third parties?</cbc:Description>
		<cac:TenderingCriterionPropertyGroup>
			<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">289f39b3-2a15-421a-8050-a29858031f35</cbc:ID>
			<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
			<cac:TenderingCriterionProperty>
				<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
				<cbc:Description>Your answer?</cbc:Description>
				<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
				<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">INDICATOR</cbc:ValueDataTypeCode>
			</cac:TenderingCriterionProperty>
			<cac:SubsidiaryTenderingCriterionPropertyGroup>
				<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">979fc579-d3d7-444b-861f-f7ac31c4f666</cbc:ID>
				<cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
				<cac:TenderingCriterionProperty>
					<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
					<cbc:Description>Name of the entity</cbc:Description>
					<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
					<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">DESCRIPTION</cbc:ValueDataTypeCode>
				</cac:TenderingCriterionProperty>
				<cac:TenderingCriterionProperty>
					<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
					<cbc:Description>ID of the entity</cbc:Description>
					<cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
					<cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">IDENTIFIER</cbc:ValueDataTypeCode>
				</cac:TenderingCriterionProperty>
				<cac:TenderingCriterionProperty>
					<cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="util:toString(util:randomUUID())"/></cbc:ID>
					<cbc:Description>Activity of the entity (for this specific procedure)</cbc:Description>
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