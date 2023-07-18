<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
	xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/> 
	
	<xsl:template name="createEconomicOperator">
		
		<!--  
		<cac:EconomicOperatorParty>
			<cac:Party/>
		</cac:EconomicOperatorParty>
		--> 
		<cac:EconomicOperatorParty>
			<cac:EconomicOperatorRole>
				<cbc:RoleCode listID="http://publications.europa.eu/resource/authority/eo-role-type" listAgencyID="OP" listVersionID="20211208-0">group-mem</cbc:RoleCode>
			</cac:EconomicOperatorRole>
			<cac:Party>
				<cbc:WebsiteURI>www.Procurer.com</cbc:WebsiteURI>
				<cbc:IndustryClassificationCode listID="http://publications.europa.eu/resource/authority/economic-operator-size" listAgencyID="OP" listVersionID="20220316-0">sme</cbc:IndustryClassificationCode>
				<cac:PartyIdentification>
					<cbc:ID schemeAgencyID="OP">AD123456789</cbc:ID>
				</cac:PartyIdentification>
				<cac:PartyName>
					<cbc:Name>__ProcurerName</cbc:Name>
				</cac:PartyName>
				<cac:PostalAddress>
					<cbc:StreetName>__ProcurerStreet</cbc:StreetName>
					<cbc:CityName>__ProcurerCity</cbc:CityName>
					<cbc:PostalZone>12345</cbc:PostalZone>
					<cac:Country>
						<cbc:IdentificationCode listID="http://publications.europa.eu/resource/authority/country" listAgencyID="ISO" listName="country" listVersionID="20220928-0">BEL</cbc:IdentificationCode>
					</cac:Country>
				</cac:PostalAddress>
				<cac:Contact>
					<cbc:Name>__ProcurerContactName</cbc:Name>
					<cbc:Telephone>654321</cbc:Telephone>
					<cbc:Telefax>098765</cbc:Telefax>
					<cbc:ElectronicMail>__ProcurerContact@pr.com</cbc:ElectronicMail>
				</cac:Contact></cac:Party>
		</cac:EconomicOperatorParty>
		
	</xsl:template> 
	
</xsl:stylesheet>
