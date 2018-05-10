<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:cac-old="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc-old="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"
	xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"
	xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"
	xmlns:espd="urn:grow:names:specification:ubl:schema:xsd:ESPDResponse-1"
	xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
	xmlns:espd-cac="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonAggregateComponents-1"
	xmlns:espd-cbc="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"
	xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate"
	xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic"
	exclude-result-prefixes="#all" version="2.0">
	<xsl:import href="ServiceProvider.xslt"/>
	<xsl:template name="EconomicOperatorParty" match="node()/espd-cac:EconomicOperatorParty"
		exclude-result-prefixes="#all">

		<xsl:for-each select="//espd-cac:EconomicOperatorParty" exclude-result-prefixes="#all">
			<cac:EconomicOperatorParty>
				<cac:QualifyingParty>
					<cac:Party>
						<cbc:IndustryClassificationCode listID="EOIndustryClassificationCode"
							listAgencyID="EU-COM-GROW" listVersionID="2.0.2">
							<xsl:value-of select="espd-cbc:SMEIndicator"/>
						</cbc:IndustryClassificationCode>
					</cac:Party>
				</cac:QualifyingParty>
				<cac:EconomicOperatorRole>
					<xsl:if test="espd-cbc:EconomicOperatorRoleCode">
						<cbc:RoleCode listID="EORoleType"
							listAgencyName="DG GROW (European Commission)"
							listAgencyID="EU-COM-GROW" listVersionID="2.0.2">
							<xsl:value-of select="espd-cbc:EconomicOperatorRoleCode"/>
						</cbc:RoleCode>

					</xsl:if>
					<xsl:if test="not(espd-cbc:EconomicOperatorRoleCode)">
					<cbc:RoleCode listID="EORoleType" listAgencyName="DG GROW (European Commission)"
						listAgencyID="EU-COM-GROW" listVersionID="2.0.2">DUMMY</cbc:RoleCode>
					</xsl:if>
					<xsl:if test="espd-cbc:EconomicOperatorRoleDescription">
						<cbc:RoleDescription>
							<xsl:value-of select="espd-cbc:EconomicOperatorRoleDescription"/>
						</cbc:RoleDescription>
					</xsl:if>
					<xsl:if test="not(espd-cbc:EconomicOperatorRoleDescription)">
					<cbc:RoleDescription>DUMMY</cbc:RoleDescription>
					</xsl:if>
				</cac:EconomicOperatorRole>
				<cac:Party>
				<xsl:apply-templates mode="copy" select="cac-old:Party/*" exclude-result-prefixes="#all"/>
				<xsl:choose>
				
					<xsl:when test="cac-old:Party/last()">
					<xsl:if test="not(cac-old:Party/cac-old:ServiceProviderParty)">
						<xsl:if test="parent::node()/name()='espd:ESPDResponse'">
							<xsl:call-template name="ServiceProvider"/>
					</xsl:if>
						</xsl:if>
				<xsl:if test="not(cac-old:Party/cac-old:PowerOfAttorney)">
						<xsl:apply-templates mode="copy" select="//cac-old:PowerOfAttorney"/>	
				</xsl:if>
					</xsl:when>
				</xsl:choose>
				</cac:Party>
			</cac:EconomicOperatorParty>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
