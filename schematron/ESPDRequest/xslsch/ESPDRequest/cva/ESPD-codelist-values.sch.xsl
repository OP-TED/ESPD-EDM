<?xml version="1.0" encoding="ISO-8859-1"?><xslo:stylesheet xmlns:xslo="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ccs="urn:x-Crane:ss:Crane-Constraints2Schematron" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1" xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1" xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:espd-cbc="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1" xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1" xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1" version="2.0" exclude-result-prefixes="ccs"><xslo:output indent="yes"/><xslo:template match="/"><xslo:for-each select="document('')"><schema xmlns="http://purl.oclc.org/dsdl/schematron"><pattern id="code-list-values">
<!--This CVA to Schematron implementation supports genericode code lists.-->
<!--
    Start of synthesis of a stylesheet creating rules from code list context
    associations.  This is an XSLT 1.0 stylesheet that can be executed without
    any input file (any supplied input file is ignored; most processors
    require the specification of an input file; when necessary, any XML
    document will do, such as providing the stylesheet itself as the input).

    The end result of running this synthesized stylesheet with no or any input 
    is a Schematron schema expressing the constraints found in the CVA file
    that was input to the creation this stylesheet.  Any changes to those
    inputs will require this stylesheet to be recreated.
  -->
<xslo:text/><xslo:comment>
		ESPD code list values constraints - ESPD-codelist-values.cva
	
$Id: ESPD-codelist-values.cva,v 1.0 $

    Required namespace declarations as indicated in this set of rules:

&lt;ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/&gt;
&lt;ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/&gt;
&lt;ns prefix="ccv-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1"/&gt;
&lt;ns prefix="cev-cbc" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1"/&gt;
&lt;ns prefix="cev" uri="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1"/&gt;
&lt;ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/&gt;
&lt;ns prefix="ccv" uri="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"/&gt;
&lt;ns prefix="espd-req" uri="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1"/&gt;
&lt;ns prefix="espd-cbc" uri="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1"/&gt;

</xslo:comment>

<rule context="cbc:TypeCode">
  <!--{}[cctsV2.01-code](CriteriaTypeCode)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](CriteriaTypeCode)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e30'"/></xslo:call-template>(contains(translate('CRITERION.EXCLUSION.CONVICTIONS.PARTICIPATION_IN_CRIMINAL_ORGANISATIONCRITERION.EXCLUSION.CONVICTIONS.CORRUPTIONCRITERION.EXCLUSION.CONVICTIONS.FRAUDCRITERION.EXCLUSION.CONVICTIONS.TERRORIST_OFFENCESCRITERION.EXCLUSION.CONVICTIONS.MONEY_LAUNDERINGCRITERION.EXCLUSION.CONVICTIONS.CHILD_LABOUR-HUMAN_TRAFFICKINGCRITERION.EXCLUSION.CONTRIBUTIONS.PAYMENT_OF_TAXESCRITERION.EXCLUSION.CONTRIBUTIONS.PAYMENT_OF_SOCIAL_SECURITYCRITERION.EXCLUSION.SOCIAL.ENVIRONMENTAL_LAWCRITERION.EXCLUSION.SOCIAL.SOCIAL_LAWCRITERION.EXCLUSION.SOCIAL.LABOUR_LAWCRITERION.EXCLUSION.BUSINESS.BANKRUPTCYCRITERION.EXCLUSION.BUSINESS.INSOLVENCYCRITERION.EXCLUSION.BUSINESS.CREDITORS_ARRANGEMENTCRITERION.EXCLUSION.BUSINESS.BANKRUPTCY_ANALOGOUSCRITERION.EXCLUSION.BUSINESS.LIQUIDATOR_ADMINISTEREDCRITERION.EXCLUSION.BUSINESS.ACTIVITIES_SUSPENDEDCRITERION.EXCLUSION.MISCONDUCT.MC_PROFESSIONALCRITERION.EXCLUSION.MISCONDUCT.MARKET_DISTORTIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PARTICIPATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PREPARATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.EARLY_TERMINATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.MISINTERPRETATIONCRITERION.EXCLUSION.NATIONAL.OTHERCRITERION.SELECTION.ALL_SATISFIEDCRITERION.SELECTION.SUITABILITY.PROFESSIONAL_REGISTER_ENROLMENTCRITERION.SELECTION.SUITABILITY.TRADE_REGISTER_ENROLMENTCRITERION.SELECTION.SUITABILITY.AUTHORISATIONCRITERION.SELECTION.SUITABILITY.MEMBERSHIPCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.GENERAL_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.AVERAGE_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SPECIFIC_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SPECIFIC_AVERAGECRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SET_UPCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.FINANCIAL_RATIOCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.RISK_INDEMNITY_INSURANCECRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.OTHER_REQUIREMENTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.WORKS_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.SUPPLIES_DELIVERY_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.SERVICES_DELIVERY_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.TECHNICIANS_FOR_QUALITY_CONTROLCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.TECHNICIANS_FOR_CARRYING_WORKSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.FACILITIES_FOR_QUALITY_ENSURINGCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.FACILITIES_FOR_STUDY_RESEARCHCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.SUPPLY_CHAIN_MANAGEMENTCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.CHECKS.ALLOWANCE_OF_CHECKSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.PROFESSIONAL_QUALIFICATIONSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.ENVIRONMENTAL_MANAGEMENT_MEASURESCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.MANAGERIAL_STAFFCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.AVERAGE_ANNUAL_MANPOWERCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.EQUIPMENTCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.SUBCONTRACTING_PROPORTIONCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.ARTEFACTS.NO_AUTHENTICATED_ARTEFACTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.ARTEFACTS.AUTHENTICATED_ARTEFACTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INSTITUTES_CERTIFICATECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INDEPENDENT_CERTIFICATECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.ENVIRONMENTAL_MANAGEMENT.ENV_INDEPENDENT_CERTIFICATECRITERION.OTHER.EO_DATA.SHELTERED_WORKSHOPCRITERION.OTHER.EO_DATA.REGISTERED_IN_OFFICIAL_LISTCRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERSCRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIESCRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIESCRITERION.OTHER.EO_DATA.MEETS_THE_OBJECTIVE','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="@responseDataType">
  <!--{}[](ResponseDataType)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[](ResponseDataType)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( (contains(translate('AMOUNTCODECODE_COUNTRYDATEDESCRIPTIONEVIDENCE_URLINDICATORPERCENTAGEPERIODQUANTITY_INTEGERQUANTITY_YEARQUANTITY','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element</assert>
</rule>

<rule context="@langID">
  <!--{}[](LanguageCodeEU)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[](LanguageCodeEU)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( (contains(translate('PLPTELENESETFIROGAFRSKSLSVHUITLTLVMTBGNLDACSDEHR','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element</assert>
</rule>

<rule context="@currencyID">
  <!--{}[](CurrencyCodeList)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[](CurrencyCodeList)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( (contains(translate('AEDAFNALLAMDANGAOAARSAUDAWGAZNBAMBBDBDTBGNBHDBIFBMDBNDBOBBOVBRLBSDBTNBWPBYRBZDCADCDFCHECHFCHWCLFCLPCNYCOPCOUCRCCUPCVECYPCZKDJFDKKDOPDZDEEKEGPERNETBEURFJDFKPGBPGELGHSGIPGMDGNFGTQGYDHKDHNLHRKHTGHUFIDRILSINRIQDIRRISKJMDJODJPYKESKGSKHRKMFKPWKRWKWDKYDKZTLAKLBPLKRLRDLSLLTLLVLLYDMADMDLMGAMKDMMKMNTMOPMROMTLMURMVRMWKMXNMXVMYRMZNNADNGNNIONOKNPRNZDOMRPABPENPGKPHPPKRPLNPYGQARRONRSDRUBRWFSARSBDSCRSDGSSPSEKSGDSHPSKKSLLSOSSRDSTDSYPSZLTHBTJSTMMTNDTOPTRYTTDTWDTZSUAHUGXUSDUSNUSSUYUUZSVEBVNDVUVWSTXAFXAGXAUXBAXBBXBCXBDXCDXDRXFOXFUXOFXPDXPFXPTXTSXXXYERZARZMKZWD','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element</assert>
</rule>

<rule context="ccv-cbc:JurisdictionLevelCode">
  <!--{}[cctsV2.01-code](CriterionJurisdictionLevel)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](CriterionJurisdictionLevel)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e34'"/></xslo:call-template>(contains(translate('EU_REGULATIONEU_DIRECTIVEEU_DECISIONNATIONAL_LEGISLATIONSUBNATIONAL_LEGISLATION','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="cbc:ActivityTypeCode">
  <!--{}[cctsV2.01-code](ActivityTypeCode)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](ActivityTypeCode)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e16'"/></xslo:call-template>(contains(translate('ABCDEFGHIJKLMNPRSTUW89Z','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="cbc:LocaleCode">
  <!--{}[cctsV2.01-code](LanguageCodeEU)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](LanguageCodeEU)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e46'"/></xslo:call-template>(contains(translate('PLPTELENESETFIROGAFRSKSLSVHUITLTLVMTBGNLDACSDEHR','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="cbc:ContractTypeCode">
  <!--{}[cctsV2.01-code](ContractType)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](ContractType)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e22'"/></xslo:call-template>(contains(translate('12345678','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="cbc:CountrySubentityCode">
  <!--{}[cctsV2.01-code](CountryCodeIDs)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](CountryCodeIDs)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e26'"/></xslo:call-template>(contains(translate('ADAEAFAGAIALAMAOAQARASATAUAWAXAZBABBBDBEBFBGBHBIBJBLBMBNBOBQBRBSBTBVBWBYBZCACCCDCFCGCHCICKCLCMCNCOCRCUCVCWCXCYCZDEDJDKDMDODZECEEEGEHERESETFIFJFKFMFOFRGAGBGDGEGFGGGHGIGLGMGNGPGQGRGSGTGUGWGYHKHMHNHRHTHUIDIEILIMINIOIQIRISITJEJMJOJPKEKGKHKIKMKNKPKRKWKYKZLALBLCLILKLRLSLTLULVLYMAMCMDMEMFMGMHMKMLMMMNMOMPMQMRMSMTMUMVMWMXMYMZNANCNENFNGNINLNONPNRNUNZOMPAPEPFPGPHPKPLPMPNPRPSPTPWPYQARERORSRURWSASBSCSDSESGSHSISJSKSLSMSNSOSRSSSTSVSXSYSZTCTDTFTGTHTJTKTLTMTNTOTRTTTVTWTZUAUGUMUSUYUZVAVCVEVGVIVNVUWFWSXKYEYTZAZMZW','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="cac:Country/cbc:IdentificationCode">
  <!--{}[cctsV2.01-code](CountryCodeIDs)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](CountryCodeIDs)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e26'"/></xslo:call-template>(contains(translate('ADAEAFAGAIALAMAOAQARASATAUAWAXAZBABBBDBEBFBGBHBIBJBLBMBNBOBQBRBSBTBVBWBYBZCACCCDCFCGCHCICKCLCMCNCOCRCUCVCWCXCYCZDEDJDKDMDODZECEEEGEHERESETFIFJFKFMFOFRGAGBGDGEGFGGGHGIGLGMGNGPGQGRGSGTGUGWGYHKHMHNHRHTHUIDIEILIMINIOIQIRISITJEJMJOJPKEKGKHKIKMKNKPKRKWKYKZLALBLCLILKLRLSLTLULVLYMAMCMDMEMFMGMHMKMLMMMNMOMPMQMRMSMTMUMVMWMXMYMZNANCNENFNGNINLNONPNRNUNZOMPAPEPFPGPHPKPLPMPNPRPSPTPWPYQARERORSRURWSASBSCSDSESGSHSISJSKSLSMSNSOSRSSSTSVSXSYSZTCTDTFTGTHTJTKTLTMTNTOTRTTTVTWTZUAUGUMUSUYUZVAVCVEVGVIVNVUWFWSXKYEYTZAZMZW','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="cbc:ProcurementTypeCode">
  <!--{}[cctsV2.01-code](ProcedureType)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](ProcedureType)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e54'"/></xslo:call-template>(contains(translate('123C46TVAAMIVDLLOV9','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>

<rule context="espd-cbc:EconomicOperatorRoleCode">
  <!--{}[cctsV2.01-code](TendererRoleCodeList)-->
  <xslo:text xml:space="preserve">
      </xslo:text><xslo:comment>{}[cctsV2.01-code](TendererRoleCodeList)</xslo:comment>
  <assert><xslo:attribute name="test">( false() or ( <xslo:call-template name="d2e81"><xslo:with-param name="values-id" select="'d2e70'"/></xslo:call-template>(contains(translate('MTSCCLCMJVSMEOTH','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) </xslo:attribute>Invalid value: '<value-of select="."/>' for the element or invalid codelist used</assert>
</rule>
<!--
    End of synthesis of rules from code list context associations.
-->
</pattern></schema></xslo:for-each></xslo:template>

<xslo:key name="identification" match="ccs:Identification" use="@xml:id"/>


<!--{}(ActivityTypeCode)-->
<ccs:Identification xml:id="d2e16">

<Identification>
      <ShortName>ActivityTypeCode</ShortName>
      <LongName xml:lang="en">MA_MAIN_ACTIVITIES_SECTION I.2_1.3</LongName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">OJEU</LongName>
         <Identifier/>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(AmountTypeCode)-->
<ccs:Identification xml:id="d2e20">

<Identification>
      <ShortName>AmountTypeCodes</ShortName>
      <LongName xml:lang="en">Amount Type Codes</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">EU-COM-GROW</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(ContractType)-->
<ccs:Identification xml:id="d2e22">

<Identification>
      <ShortName>ContractType</ShortName>
      <LongName xml:lang="en">CONTRACT TYPE</LongName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">BII</LongName>
         <Identifier/>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(CountryCodeIDs)-->
<ccs:Identification xml:id="d2e26">

<Identification>
      <ShortName>CountryCodeIdentifier</ShortName>
      <LongName xml:lang="en">Two Letter Country Code Identifier</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">EU-COM-GROW</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(CriteriaTypeCode)-->
<ccs:Identification xml:id="d2e30">

<Identification>
      <ShortName>CriteriaTypeCode</ShortName>
      <LongName xml:lang="en">CRITERIA TYPE CODE</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">DG GROW (European Commission)</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(CriterionJurisdictionLevel)-->
<ccs:Identification xml:id="d2e34">

<Identification>
      <ShortName>CriterionJurisdictionLevel</ShortName>
      <LongName xml:lang="en">CRITERION REGULATION JURISDICTION LEVEL</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">DG GROW (European Commission)</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(CurrencyCodeList)-->
<ccs:Identification xml:id="d2e38">

<Identification>
      <ShortName>CurrencyCode</ShortName>
      <LongName xml:lang="en">ISO 3 Alpha Currency Code</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">EU-COM-GROW</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(CustomizationID)-->
<ccs:Identification xml:id="d2e42">

<Identification>
      <ShortName>CustomizationID</ShortName>
      <LongName xml:lang="en">CUSTOMIZATION ID</LongName>
      <Version>3.0</Version>
      <Agency>
         <LongName xml:lang="en">CEN/BII</LongName>
         <Identifier>BII</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(DocRefContentType)-->
<ccs:Identification xml:id="d2e44">

<Identification>
      <ShortName>DocRefContentType</ShortName>
      <LongName xml:lang="en">ADDITIONAL DOCUMENT REFERENCE CONTENT TYPE CODE</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">DG GROW (European Commission)</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(LanguageCodeEU)-->
<ccs:Identification xml:id="d2e46">

<Identification>
      <ShortName>LanguageCodeEU</ShortName>
      <LongName xml:lang="en">LanguageCodeEU</LongName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="">EuropeanComission</LongName>
         <Identifier/>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(PeriodMeasureTypeCodes)-->
<ccs:Identification xml:id="d2e50">

<Identification>
      <ShortName>PeriodMeasureTypeCodes</ShortName>
      <LongName xml:lang="en">PERIOD TYPES</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">DG GROW (European Commission)</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(PeriodtypeCodes)-->
<ccs:Identification xml:id="d2e52">

<Identification>
      <ShortName>PeriodTypeCodes</ShortName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">EU-COM-GROW</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(ProcedureType)-->
<ccs:Identification xml:id="d2e54">

<Identification>
      <ShortName>ProcedureType</ShortName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">OJEU</LongName>
         <Identifier/>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(ProfileExecutionID)-->
<ccs:Identification xml:id="d2e58">

<Identification>
      <ShortName>ProfileExecutionID</ShortName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">European Commision</LongName>
         <Identifier>EuropeanCommision</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(ProjectType)-->
<ccs:Identification xml:id="d2e60">

<Identification>
      <ShortName>ProjectType</ShortName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">OJEU</LongName>
         <Identifier/>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(ResponseDataType)-->
<ccs:Identification xml:id="d2e62">

<Identification>
      <ShortName>ResponseDataType</ShortName>
      <LongName xml:lang="en">Type of data expected in the response for a criterion requirement</LongName>
      <Version>1.0.2</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">DG GROW (European Commission)</LongName>
         <Identifier>EU-COM-GROW</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(ServicesProjectSubType)-->
<ccs:Identification xml:id="d2e66">

<Identification>
      <ShortName>ServicesProjectSubType</ShortName>
      <LongName xml:lang="en">SERVICES SUBTYPE</LongName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">OJEU</LongName>
         <Identifier/>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(TechnicalCapabilityTypeCode)-->
<ccs:Identification xml:id="d2e68">

<Identification>
      <ShortName>TechnicalCapabilityTypeCode</ShortName>
      <LongName xml:lang="en">TECHNICAL CAPABILITY</LongName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">European Comission</LongName>
         <Identifier>EuropeanComission</Identifier>
      </Agency>
   </Identification></ccs:Identification>

<!--{}(TendererRoleCodeList)-->
<ccs:Identification xml:id="d2e70">

<Identification>
      <ShortName>TendererRole</ShortName>
      <LongName xml:lang="en">TENDERER ROLE</LongName>
      <Version>1.0</Version>
      <CanonicalUri>Placeholder</CanonicalUri>
      <CanonicalVersionUri>Placeholder</CanonicalVersionUri>
      <Agency>
         <LongName xml:lang="en">BII</LongName>
         <Identifier>BII</Identifier>
      </Agency>
   </Identification></ccs:Identification>


<!--{}[cctsV2.01-code]-->
<xslo:template name="d2e81">
  <xslo:param name="values-id"/>
  
  <xslo:variable name="metadata-1" select="key('identification',$values-id)/                          *[(ShortName)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-1">
      <xslo:for-each select="$metadata-1">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listName!='</xslo:text>
        <xslo:value-of select="(ShortName)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listName!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
  <xslo:variable name="metadata-2" select="key('identification',$values-id)/                          *[(ShortName)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-2">
      <xslo:for-each select="$metadata-2">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listID!='</xslo:text>
        <xslo:value-of select="(ShortName)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listID!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
  <xslo:variable name="metadata-3" select="key('identification',$values-id)/                          *[(Version)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-3">
      <xslo:for-each select="$metadata-3">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listVersionID!='</xslo:text>
        <xslo:value-of select="(Version)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listVersionID!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
  <xslo:variable name="metadata-4" select="key('identification',$values-id)/                          *[(LocationUri)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-4">
      <xslo:for-each select="$metadata-4">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listSchemeURI!='</xslo:text>
        <xslo:value-of select="(LocationUri)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listSchemeURI!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
  <xslo:variable name="metadata-5" select="key('identification',$values-id)/                          *[(CanonicalUri)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-5">
      <xslo:for-each select="$metadata-5">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listURI!='</xslo:text>
        <xslo:value-of select="(CanonicalUri)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listURI!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
  <xslo:variable name="metadata-6" select="key('identification',$values-id)/                          *[(Agency/LongName)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-6">
      <xslo:for-each select="$metadata-6">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listAgencyName!='</xslo:text>
        <xslo:value-of select="(Agency/LongName)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listAgencyName!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
  <xslo:variable name="metadata-7" select="key('identification',$values-id)/                          *[(Agency/Identifier)[normalize-space(.)]][1]"/>
  <xslo:text>( </xslo:text>
  <xslo:choose>
    <xslo:when test="$metadata-7">
      <xslo:for-each select="$metadata-7">
        <xslo:if test="position()&gt;1"> or </xslo:if>
        <xslo:text>not(@listAgencyID!='</xslo:text>
        <xslo:value-of select="(Agency/Identifier)[normalize-space(.)][1]"/>
        <xslo:text>')</xslo:text>
      </xslo:for-each>
    </xslo:when>
    <xslo:otherwise>
      <xslo:text>not(@listAgencyID!='')</xslo:text>
    </xslo:otherwise>
  </xslo:choose>
  <xslo:text> ) and </xslo:text>
  
</xslo:template><!--
    End of synthesis of tests from code list context associations.
-->
</xslo:stylesheet>