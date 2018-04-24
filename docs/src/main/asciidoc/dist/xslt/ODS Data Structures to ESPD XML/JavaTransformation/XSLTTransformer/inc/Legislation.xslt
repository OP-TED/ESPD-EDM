<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:espd="urn:com:grow:espd:02.00.00" xmlns:cac="urn:X-test:UBL:Pre-award:CommonAggregate" xmlns:cbc="urn:X-test:UBL:Pre-award:CommonBasic">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Legislation component -->
	<xsl:template name="createLegislation">
		<cac:Legislation>
		<xsl:call-template name="generateID"/>
			<cbc:Title>[Legislation title]</cbc:Title>
			<cbc:Description>[Legislation description]</cbc:Description>
			<cbc:JurisdictionLevel>EU</cbc:JurisdictionLevel>
			<cbc:Article>[Article, e.g. Article 2.I.a]</cbc:Article>
			<cbc:URI>http://eur-lex.europa.eu/</cbc:URI>
			<cac:Language><cbc:LocaleCode listID="LanguageCodeEU" listAgencyName="EU-COM-GROW" listVersionID="02.00.00">EN</cbc:LocaleCode></cac:Language>
		</cac:Legislation>
	</xsl:template>	
</xsl:stylesheet>
