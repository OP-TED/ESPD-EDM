<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:util="java:java.util.UUID"
  xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
  xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
  exclude-result-prefixes="xs" version="2.0">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>

  </xsl:template>
  <xsl:template match="ccv:Requirement/cbc:ID" exclude-result-prefixes="#all">
    <cbc:ID schemeID="CriterionRelatedIDs" schemeAgencyID="EU-COM-GROW" schemeVersionID="1.0">
      <xsl:value-of select="util:toString(util:randomUUID())"/>
    </cbc:ID>
  </xsl:template>
</xsl:stylesheet>
