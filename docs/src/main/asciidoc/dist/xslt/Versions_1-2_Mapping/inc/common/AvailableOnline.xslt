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
    
    
    
    <xsl:template name="availableOnline" exclude-result-prefixes="#all">
        
        <xsl:variable name="node" select=".//ccv:RequirementGroup[cbc-old:ID = '9026e403-3eb6-4705-a9e9-e21a1efc867d']"/>
     
        
        <xsl:for-each select=".//ccv:RequirementGroup[cbc-old:ID = '9026e403-3eb6-4705-a9e9-e21a1efc867d']">   
        
        <xsl:variable name="node" select="."/>
            
        <cac:SubsidiaryTenderingCriterionPropertyGroup>
            <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
                <xsl:value-of select="$node/cbc-old:ID"/>
            </cbc:ID>
            <cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
            
            <cac:TenderingCriterionProperty>
                <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
                    <xsl:value-of select="$node/ccv:Requirement/cbc-old:ID"/>
                </cbc:ID>
                <cbc:Description>
                    <xsl:value-of select="$node/ccv:Requirement/cbc-old:Description"/>
                </cbc:Description>
                <cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
                <cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">INDICATOR</cbc:ValueDataTypeCode>
            </cac:TenderingCriterionProperty>
            <xsl:variable name="node" select="$node/ccv:RequirementGroup"/>
            <cac:SubsidiaryTenderingCriterionPropertyGroup>
                <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="$node/cbc-old:ID"/></cbc:ID>
                <cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
                <cac:TenderingCriterionProperty>
                    <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
                        <!-- First field must always be the URL. If empty each evidence will be a separate document. -->
                        <xsl:variable name="node" select="$node/ccv:Requirement[1]/cbc-old:ID"/>
                        <xsl:if test="$node"><xsl:value-of select="$node"/></xsl:if>
                        <xsl:if test="not($node)"><xsl:value-of select="util:toString(util:randomUUID())"/></xsl:if>
                    </cbc:ID>
                    <cbc:Description>Evidence supplied</cbc:Description>
                    <cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
                    <cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">EVIDENCE_IDENTIFIER</cbc:ValueDataTypeCode>
                </cac:TenderingCriterionProperty>
            </cac:SubsidiaryTenderingCriterionPropertyGroup>
        </cac:SubsidiaryTenderingCriterionPropertyGroup>
        </xsl:for-each>
    </xsl:template>
 <xsl:template name="availableOnlineUUIDChange" exclude-result-prefixes="#all">
        
        <xsl:variable name="node" select=".//ccv:RequirementGroup[cbc-old:ID = '7458d42a-e581-4640-9283-34ceb3ad4345']"/>
     
        
        <xsl:for-each select=".//ccv:RequirementGroup[cbc-old:ID = '7458d42a-e581-4640-9283-34ceb3ad4345']">   
        
        <xsl:variable name="node" select="."/>
            
        <cac:SubsidiaryTenderingCriterionPropertyGroup>
            <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
                <xsl:value-of select="$node/cbc-old:ID"/>
            </cbc:ID>
            <cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ON*</cbc:PropertyGroupTypeCode>
            
            <cac:TenderingCriterionProperty>
                <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
                    <xsl:value-of select="$node/ccv:Requirement/cbc-old:ID"/>
                </cbc:ID>
                <cbc:Description>
                    <xsl:value-of select="$node/ccv:Requirement/cbc-old:Description"/>
                </cbc:Description>
                <cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
                <cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">INDICATOR</cbc:ValueDataTypeCode>
            </cac:TenderingCriterionProperty>
            <xsl:variable name="node" select="$node/ccv:RequirementGroup"/>
            <cac:SubsidiaryTenderingCriterionPropertyGroup>
                <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2"><xsl:value-of select="$node/cbc-old:ID"/></cbc:ID>
                <cbc:PropertyGroupTypeCode listID="PropertyGroupType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">ONTRUE</cbc:PropertyGroupTypeCode>
                <cac:TenderingCriterionProperty>
                    <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
                        <!-- First field must always be the URL. If empty each evidence will be a separate document. -->
                        <xsl:variable name="node" select="$node/ccv:Requirement[1]/cbc-old:ID"/>
                        <xsl:if test="$node"><xsl:value-of select="$node"/></xsl:if>
                        <xsl:if test="not($node)"><xsl:value-of select="util:toString(util:randomUUID())"/></xsl:if>
                    </cbc:ID>
                    <cbc:Description>Evidence supplied</cbc:Description>
                    <cbc:TypeCode listID="CriterionElementType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">QUESTION</cbc:TypeCode>
                    <cbc:ValueDataTypeCode listID="ResponseDataType" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">EVIDENCE_IDENTIFIER</cbc:ValueDataTypeCode>
                </cac:TenderingCriterionProperty>
            </cac:SubsidiaryTenderingCriterionPropertyGroup>
        </cac:SubsidiaryTenderingCriterionPropertyGroup>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="availableOnlineNotExist" exclude-result-prefixes="#all">

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
    </xsl:template>
    
</xsl:stylesheet>