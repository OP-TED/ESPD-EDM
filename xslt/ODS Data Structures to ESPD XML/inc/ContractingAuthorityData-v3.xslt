<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
	xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:espd="urn:com:grow:espd:3.0.0"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2.3"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2.3" xmlns:util="java:java.util.UUID">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- TODO: Create a tab in the Spread-sheet to fill-in the Buyer data -->
	<xsl:template name="createContractingAuthority">
		<cac:ContractingParty>
			<cbc:BuyerProfileURI>DummyValue</cbc:BuyerProfileURI>
			<cac:Party>
				<cbc:WebsiteURI>www.Procurer.com</cbc:WebsiteURI>
				<cbc:EndpointID schemeAgencyID="EU-COM-GROW">DummyValue</cbc:EndpointID>
				<cac:PartyIdentification>
					<cbc:ID schemeAgencyID="EU-COM-GROW">AD123456789</cbc:ID>
				</cac:PartyIdentification>
				<cac:PartyName>
					<cbc:Name>__ProcurerName</cbc:Name>
				</cac:PartyName>
				<cac:PostalAddress>
					<cbc:StreetName>__ProcurerStreet</cbc:StreetName>
					<cbc:CityName>__ProcurerCity</cbc:CityName>
					<cbc:PostalZone>12345</cbc:PostalZone>
					<cac:Country>
						<cbc:IdentificationCode listID="Country" listAgencyID="EU-COM-OP" listVersionID="20201216-0">BEL</cbc:IdentificationCode>
					</cac:Country>
				</cac:PostalAddress>
				<cac:Contact>
					<cbc:Name>__ProcurerContactName</cbc:Name>
					<cbc:Telephone>654321</cbc:Telephone>
					<cbc:ElectronicMail>__ProcurerContact@pr.com</cbc:ElectronicMail>
				</cac:Contact>
			</cac:Party>
		</cac:ContractingParty>
	</xsl:template>
</xsl:stylesheet>
