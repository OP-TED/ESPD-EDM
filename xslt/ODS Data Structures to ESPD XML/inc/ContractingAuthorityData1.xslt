<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
	xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:espd="urn:com:grow:espd:3.0.0"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:util="java:java.util.UUID">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- TODO: Create a tab in the Spread-sheet to fill-in the Buyer data -->
	<xsl:template name="createContractingAuthority">
		<cac:ContractingParty>
			<cbc:BuyerProfileURI>DummyValue</cbc:BuyerProfileURI>
			<cac:Party>
				<cbc:WebsiteURI>DummyValue</cbc:WebsiteURI>
				<cbc:EndpointID schemeAgencyID="EU-COM-GROW">DummyValue</cbc:EndpointID>
				<cac:PartyIdentification>
					<cbc:ID schemeAgencyID="VIES">B82387770</cbc:ID>
				</cac:PartyIdentification>
				<cac:PartyName>
					<cbc:Name>
						<xsl:value-of select="//./*[./name() = 'cbc:Name' and position() = 1]"/>
					</cbc:Name>
				</cac:PartyName>
				<cac:PostalAddress>
					<cbc:StreetName>DummyValue</cbc:StreetName>
					<cbc:CityName>DummyValue</cbc:CityName>
					<cbc:PostalZone>DummyValue</cbc:PostalZone>
					<cac:Country>
						<cbc:IdentificationCode listID="Country"
							listAgencyID="EU-COM-OP" listVersionID="20201216-0"
							>asdasdas</cbc:IdentificationCode>
					</cac:Country>
				</cac:PostalAddress>
				<cac:Contact>
					<cbc:Name>DummyValue</cbc:Name>
					<cbc:Telephone>DummyValue</cbc:Telephone>
					<cbc:ElectronicMail>DummyValue</cbc:ElectronicMail>
				</cac:Contact>
			</cac:Party>
		</cac:ContractingParty>
	</xsl:template>
</xsl:stylesheet>
