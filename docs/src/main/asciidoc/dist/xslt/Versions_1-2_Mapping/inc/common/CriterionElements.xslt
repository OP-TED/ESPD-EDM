<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:espd="urn:com:grow:espd:2.0.2" 
    xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" 
    xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic" 
    xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
    xmlns:util="java:java.util.UUID"
    xmlns:espd-cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    exclude-result-prefixes="xsl xs espd cac cbc cbc-old util espd-cac ccv ">
    
    <xsl:template name="CriterionID" exclude-result-prefixes="#all">
        <cbc:ID schemeID="CriteriaTaxonomy" schemeAgencyID="EU-COM-GROW" schemeVersionID="2.0.2">
            <xsl:value-of select="."/>
        </cbc:ID>
    </xsl:template>
    
    <xsl:template name="CriterionTypeCode" exclude-result-prefixes="#all">
        <cbc:CriterionTypeCode listID="CriteriaTypeCode" listAgencyID="EU-COM-GROW" listVersionID="2.0.2">
            <xsl:value-of select="."/>
        </cbc:CriterionTypeCode>
    </xsl:template>
    
    <xsl:template name="CriterionName" exclude-result-prefixes="#all">
        <cbc:Name>
            <xsl:value-of select="."/>
        </cbc:Name>
    </xsl:template>
    
    <xsl:template name="CriterionDescription" exclude-result-prefixes="#all">
        <cbc:Description>
            <xsl:value-of select="."/>
        </cbc:Description>
    </xsl:template>
    
</xsl:stylesheet>
