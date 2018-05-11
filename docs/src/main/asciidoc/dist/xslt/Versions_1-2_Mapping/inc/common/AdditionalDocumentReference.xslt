<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cac-old="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate"
    xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
    xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2">

    
    <xsl:template name="AdditionalDocumentReference" exclude-result-prefixes="#all">
        <xsl:apply-templates mode="copy" select="node()/cac-old:AdditionalDocumentReference"/>
    </xsl:template>
    
    
</xsl:stylesheet>