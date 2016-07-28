<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccv-cbc="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonBasicComponents-1" xmlns:cev-cbc="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonBasicComponents-1" xmlns:cev="urn:isa:names:specification:ubl:schema:xsd:CEV-CommonAggregateComponents-1" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1" xmlns:espd-req="urn:grow:names:specification:ubl:schema:xsd:ESPDRequest-1" xmlns:espd-cbc="urn:grow:names:specification:ubl:schema:xsd:ESPD-CommonBasicComponents-1" version="2.0"><!--Importing stylesheet additions-->
   <axsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"/><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->

   <axsl:param name="archiveDirParameter"/>
   <axsl:param name="archiveNameParameter"/>
   <axsl:param name="fileNameParameter"/>
   <axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->


<!--KEYS-->


<!--VARIABLES-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->

   <axsl:template match="*" mode="schematron-get-full-path">
      <axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">
            <axsl:value-of select="name()"/>
            <axsl:variable name="p" select="1+    count(preceding-sibling::*[name()=name(current())])"/>
            <axsl:if test="$p&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p"/>]</axsl:if>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
            <axsl:variable name="p" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/>
            <axsl:if test="$p&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p"/>]</axsl:if>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>
   <axsl:template match="@*" mode="schematron-get-full-path">
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>@*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->

   <axsl:template match="/" mode="generate-id-from-path"/>
   <axsl:template match="text()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </axsl:template>
   <axsl:template match="comment()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </axsl:template>
   <axsl:template match="processing-instruction()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.@', name())"/>
   </axsl:template>
   <axsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:text>.</axsl:text>
      <axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="parent::*">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

<!--MODE: GENERATE-ID-2 -->

   <axsl:template match="/" mode="generate-id-2">U</axsl:template>
   <axsl:template match="*" mode="generate-id-2" priority="2">
      <axsl:text>U</axsl:text>
      <axsl:number level="multiple" count="*"/>
   </axsl:template>
   <axsl:template match="node()" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>n</axsl:text>
      <axsl:number count="node()"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="string-length(local-name(.))"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="translate(name(),':','.')"/>
   </axsl:template><!--Strip characters-->
   <axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->

   <axsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion="">
         <axsl:comment>
            <axsl:value-of select="$archiveDirParameter"/>   
		 <axsl:value-of select="$archiveNameParameter"/>  
		 <axsl:value-of select="$fileNameParameter"/>  
		 <axsl:value-of select="$fileDirParameter"/>
         </axsl:comment>
         <axsl:apply-templates select="/" mode="M0"/>
      </svrl:schematron-output>
   </axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN code-list-values-->


	<!--RULE -->

   <axsl:template match="cbc:TypeCode" priority="1011" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='CriteriaTypeCode') ) and ( not(@listID!='CriteriaTypeCode') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='DG GROW (European Commission)') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('CRITERION.EXCLUSION.CONVICTIONS.PARTICIPATION_IN_CRIMINAL_ORGANISATIONCRITERION.EXCLUSION.CONVICTIONS.CORRUPTIONCRITERION.EXCLUSION.CONVICTIONS.FRAUDCRITERION.EXCLUSION.CONVICTIONS.TERRORIST_OFFENCESCRITERION.EXCLUSION.CONVICTIONS.MONEY_LAUNDERINGCRITERION.EXCLUSION.CONVICTIONS.CHILD_LABOUR-HUMAN_TRAFFICKINGCRITERION.EXCLUSION.CONTRIBUTIONS.PAYMENT_OF_TAXESCRITERION.EXCLUSION.CONTRIBUTIONS.PAYMENT_OF_SOCIAL_SECURITYCRITERION.EXCLUSION.SOCIAL.ENVIRONMENTAL_LAWCRITERION.EXCLUSION.SOCIAL.SOCIAL_LAWCRITERION.EXCLUSION.SOCIAL.LABOUR_LAWCRITERION.EXCLUSION.BUSINESS.BANKRUPTCYCRITERION.EXCLUSION.BUSINESS.INSOLVENCYCRITERION.EXCLUSION.BUSINESS.CREDITORS_ARRANGEMENTCRITERION.EXCLUSION.BUSINESS.BANKRUPTCY_ANALOGOUSCRITERION.EXCLUSION.BUSINESS.LIQUIDATOR_ADMINISTEREDCRITERION.EXCLUSION.BUSINESS.ACTIVITIES_SUSPENDEDCRITERION.EXCLUSION.MISCONDUCT.MC_PROFESSIONALCRITERION.EXCLUSION.MISCONDUCT.MARKET_DISTORTIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PARTICIPATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PREPARATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.EARLY_TERMINATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.MISINTERPRETATIONCRITERION.EXCLUSION.NATIONAL.OTHERCRITERION.SELECTION.ALL_SATISFIEDCRITERION.SELECTION.SUITABILITY.PROFESSIONAL_REGISTER_ENROLMENTCRITERION.SELECTION.SUITABILITY.TRADE_REGISTER_ENROLMENTCRITERION.SELECTION.SUITABILITY.AUTHORISATIONCRITERION.SELECTION.SUITABILITY.MEMBERSHIPCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.GENERAL_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.AVERAGE_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SPECIFIC_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SPECIFIC_AVERAGECRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SET_UPCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.FINANCIAL_RATIOCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.RISK_INDEMNITY_INSURANCECRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.OTHER_REQUIREMENTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.WORKS_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.SUPPLIES_DELIVERY_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.SERVICES_DELIVERY_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.TECHNICIANS_FOR_QUALITY_CONTROLCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.TECHNICIANS_FOR_CARRYING_WORKSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.FACILITIES_FOR_QUALITY_ENSURINGCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.FACILITIES_FOR_STUDY_RESEARCHCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.SUPPLY_CHAIN_MANAGEMENTCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.CHECKS.ALLOWANCE_OF_CHECKSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.PROFESSIONAL_QUALIFICATIONSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.ENVIRONMENTAL_MANAGEMENT_MEASURESCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.MANAGERIAL_STAFFCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.AVERAGE_ANNUAL_MANPOWERCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.EQUIPMENTCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.SUBCONTRACTING_PROPORTIONCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.ARTEFACTS.NO_AUTHENTICATED_ARTEFACTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.ARTEFACTS.AUTHENTICATED_ARTEFACTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INSTITUTES_CERTIFICATECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INDEPENDENT_CERTIFICATECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.ENVIRONMENTAL_MANAGEMENT.ENV_INDEPENDENT_CERTIFICATECRITERION.OTHER.EO_DATA.SHELTERED_WORKSHOPCRITERION.OTHER.EO_DATA.REGISTERED_IN_OFFICIAL_LISTCRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERSCRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIESCRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIESCRITERION.OTHER.EO_DATA.MEETS_THE_OBJECTIVE','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='CriteriaTypeCode') ) and ( not(@listID!='CriteriaTypeCode') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='DG GROW (European Commission)') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('CRITERION.EXCLUSION.CONVICTIONS.PARTICIPATION_IN_CRIMINAL_ORGANISATIONCRITERION.EXCLUSION.CONVICTIONS.CORRUPTIONCRITERION.EXCLUSION.CONVICTIONS.FRAUDCRITERION.EXCLUSION.CONVICTIONS.TERRORIST_OFFENCESCRITERION.EXCLUSION.CONVICTIONS.MONEY_LAUNDERINGCRITERION.EXCLUSION.CONVICTIONS.CHILD_LABOUR-HUMAN_TRAFFICKINGCRITERION.EXCLUSION.CONTRIBUTIONS.PAYMENT_OF_TAXESCRITERION.EXCLUSION.CONTRIBUTIONS.PAYMENT_OF_SOCIAL_SECURITYCRITERION.EXCLUSION.SOCIAL.ENVIRONMENTAL_LAWCRITERION.EXCLUSION.SOCIAL.SOCIAL_LAWCRITERION.EXCLUSION.SOCIAL.LABOUR_LAWCRITERION.EXCLUSION.BUSINESS.BANKRUPTCYCRITERION.EXCLUSION.BUSINESS.INSOLVENCYCRITERION.EXCLUSION.BUSINESS.CREDITORS_ARRANGEMENTCRITERION.EXCLUSION.BUSINESS.BANKRUPTCY_ANALOGOUSCRITERION.EXCLUSION.BUSINESS.LIQUIDATOR_ADMINISTEREDCRITERION.EXCLUSION.BUSINESS.ACTIVITIES_SUSPENDEDCRITERION.EXCLUSION.MISCONDUCT.MC_PROFESSIONALCRITERION.EXCLUSION.MISCONDUCT.MARKET_DISTORTIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PARTICIPATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.PROCEDURE_PREPARATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.EARLY_TERMINATIONCRITERION.EXCLUSION.CONFLICT_OF_INTEREST.MISINTERPRETATIONCRITERION.EXCLUSION.NATIONAL.OTHERCRITERION.SELECTION.ALL_SATISFIEDCRITERION.SELECTION.SUITABILITY.PROFESSIONAL_REGISTER_ENROLMENTCRITERION.SELECTION.SUITABILITY.TRADE_REGISTER_ENROLMENTCRITERION.SELECTION.SUITABILITY.AUTHORISATIONCRITERION.SELECTION.SUITABILITY.MEMBERSHIPCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.GENERAL_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.AVERAGE_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SPECIFIC_YEARLYCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SPECIFIC_AVERAGECRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.TURNOVER.SET_UPCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.FINANCIAL_RATIOCRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.RISK_INDEMNITY_INSURANCECRITERION.SELECTION.ECONOMIC_FINANCIAL_STANDING.OTHER_REQUIREMENTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.WORKS_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.SUPPLIES_DELIVERY_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.REFERENCES.SERVICES_DELIVERY_PERFORMANCECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.TECHNICIANS_FOR_QUALITY_CONTROLCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.TECHNICIANS_FOR_CARRYING_WORKSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.FACILITIES_FOR_QUALITY_ENSURINGCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.FACILITIES_FOR_STUDY_RESEARCHCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.SUPPLY_CHAIN_MANAGEMENTCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.CHECKS.ALLOWANCE_OF_CHECKSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.PROFESSIONAL_QUALIFICATIONSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.ENVIRONMENTAL_MANAGEMENT_MEASURESCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.MANAGERIAL_STAFFCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.AVERAGE_ANNUAL_MANPOWERCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.TECHNICAL.EQUIPMENTCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.SUBCONTRACTING_PROPORTIONCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.ARTEFACTS.NO_AUTHENTICATED_ARTEFACTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.MANAGEMENT.ARTEFACTS.AUTHENTICATED_ARTEFACTSCRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INSTITUTES_CERTIFICATECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.QUALITY_ASSURANCE.QA_INDEPENDENT_CERTIFICATECRITERION.SELECTION.TECHNICAL_PROFESSIONAL_ABILITY.CERTIFICATES.ENVIRONMENTAL_MANAGEMENT.ENV_INDEPENDENT_CERTIFICATECRITERION.OTHER.EO_DATA.SHELTERED_WORKSHOPCRITERION.OTHER.EO_DATA.REGISTERED_IN_OFFICIAL_LISTCRITERION.OTHER.EO_DATA.TOGETHER_WITH_OTHERSCRITERION.OTHER.EO_DATA.RELIES_ON_OTHER_CAPACITIESCRITERION.OTHER.EO_DATA.SUBCONTRACTS_WITH_THIRD_PARTIESCRITERION.OTHER.EO_DATA.MEETS_THE_OBJECTIVE','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="@responseDataType" priority="1010" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( (contains(translate('AMOUNTCODECODE_COUNTRYDATEDESCRIPTIONEVIDENCE_URLINDICATORPERCENTAGEPERIODQUANTITY_INTEGERQUANTITY_YEARQUANTITY','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( (contains(translate('AMOUNTCODECODE_COUNTRYDATEDESCRIPTIONEVIDENCE_URLINDICATORPERCENTAGEPERIODQUANTITY_INTEGERQUANTITY_YEARQUANTITY','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="@langID" priority="1009" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( (contains(translate('PLPTELENESETFIROGAFRSKSLSVHUITLTLVMTBGNLDACSDEHR','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( (contains(translate('PLPTELENESETFIROGAFRSKSLSVHUITLTLVMTBGNLDACSDEHR','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="@currencyID" priority="1008" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( (contains(translate('AEDAFNALLAMDANGAOAARSAUDAWGAZNBAMBBDBDTBGNBHDBIFBMDBNDBOBBOVBRLBSDBTNBWPBYRBZDCADCDFCHECHFCHWCLFCLPCNYCOPCOUCRCCUPCVECYPCZKDJFDKKDOPDZDEEKEGPERNETBEURFJDFKPGBPGELGHSGIPGMDGNFGTQGYDHKDHNLHRKHTGHUFIDRILSINRIQDIRRISKJMDJODJPYKESKGSKHRKMFKPWKRWKWDKYDKZTLAKLBPLKRLRDLSLLTLLVLLYDMADMDLMGAMKDMMKMNTMOPMROMTLMURMVRMWKMXNMXVMYRMZNNADNGNNIONOKNPRNZDOMRPABPENPGKPHPPKRPLNPYGQARRONRSDRUBRWFSARSBDSCRSDGSSPSEKSGDSHPSKKSLLSOSSRDSTDSYPSZLTHBTJSTMMTNDTOPTRYTTDTWDTZSUAHUGXUSDUSNUSSUYUUZSVEBVNDVUVWSTXAFXAGXAUXBAXBBXBCXBDXCDXDRXFOXFUXOFXPDXPFXPTXTSXXXYERZARZMKZWD','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( (contains(translate('AEDAFNALLAMDANGAOAARSAUDAWGAZNBAMBBDBDTBGNBHDBIFBMDBNDBOBBOVBRLBSDBTNBWPBYRBZDCADCDFCHECHFCHWCLFCLPCNYCOPCOUCRCCUPCVECYPCZKDJFDKKDOPDZDEEKEGPERNETBEURFJDFKPGBPGELGHSGIPGMDGNFGTQGYDHKDHNLHRKHTGHUFIDRILSINRIQDIRRISKJMDJODJPYKESKGSKHRKMFKPWKRWKWDKYDKZTLAKLBPLKRLRDLSLLTLLVLLYDMADMDLMGAMKDMMKMNTMOPMROMTLMURMVRMWKMXNMXVMYRMZNNADNGNNIONOKNPRNZDOMRPABPENPGKPHPPKRPLNPYGQARRONRSDRUBRWFSARSBDSCRSDGSSPSEKSGDSHPSKKSLLSOSSRDSTDSYPSZLTHBTJSTMMTNDTOPTRYTTDTWDTZSUAHUGXUSDUSNUSSUYUUZSVEBVNDVUVWSTXAFXAGXAUXBAXBBXBCXBDXCDXDRXFOXFUXOFXPDXPFXPTXTSXXXYERZARZMKZWD','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="ccv-cbc:JurisdictionLevelCode" priority="1007" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='CriterionJurisdictionLevel') ) and ( not(@listID!='CriterionJurisdictionLevel') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='DG GROW (European Commission)') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('EU_REGULATIONEU_DIRECTIVEEU_DECISIONNATIONAL_LEGISLATIONSUBNATIONAL_LEGISLATION','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='CriterionJurisdictionLevel') ) and ( not(@listID!='CriterionJurisdictionLevel') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='DG GROW (European Commission)') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('EU_REGULATIONEU_DIRECTIVEEU_DECISIONNATIONAL_LEGISLATIONSUBNATIONAL_LEGISLATION','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:ActivityTypeCode" priority="1006" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='ActivityTypeCode') ) and ( not(@listID!='ActivityTypeCode') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='OJEU') ) and ( not(@listAgencyID!='') ) and (contains(translate('ABCDEFGHIJKLMNPRSTUW89Z','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='ActivityTypeCode') ) and ( not(@listID!='ActivityTypeCode') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='OJEU') ) and ( not(@listAgencyID!='') ) and (contains(translate('ABCDEFGHIJKLMNPRSTUW89Z','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:LocaleCode" priority="1005" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='LanguageCodeEU') ) and ( not(@listID!='LanguageCodeEU') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='EuropeanComission') ) and ( not(@listAgencyID!='') ) and (contains(translate('PLPTELENESETFIROGAFRSKSLSVHUITLTLVMTBGNLDACSDEHR','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='LanguageCodeEU') ) and ( not(@listID!='LanguageCodeEU') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='EuropeanComission') ) and ( not(@listAgencyID!='') ) and (contains(translate('PLPTELENESETFIROGAFRSKSLSVHUITLTLVMTBGNLDACSDEHR','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:ContractTypeCode" priority="1004" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='ContractType') ) and ( not(@listID!='ContractType') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='BII') ) and ( not(@listAgencyID!='') ) and (contains(translate('12345678','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='ContractType') ) and ( not(@listID!='ContractType') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='BII') ) and ( not(@listAgencyID!='') ) and (contains(translate('12345678','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:CountrySubentityCode" priority="1003" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='CountryCodeIdentifier') ) and ( not(@listID!='CountryCodeIdentifier') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='EU-COM-GROW') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('ADAEAFAGAIALAMAOAQARASATAUAWAXAZBABBBDBEBFBGBHBIBJBLBMBNBOBQBRBSBTBVBWBYBZCACCCDCFCGCHCICKCLCMCNCOCRCUCVCWCXCYCZDEDJDKDMDODZECEEEGEHERESETFIFJFKFMFOFRGAGBGDGEGFGGGHGIGLGMGNGPGQGRGSGTGUGWGYHKHMHNHRHTHUIDIEILIMINIOIQIRISITJEJMJOJPKEKGKHKIKMKNKPKRKWKYKZLALBLCLILKLRLSLTLULVLYMAMCMDMEMFMGMHMKMLMMMNMOMPMQMRMSMTMUMVMWMXMYMZNANCNENFNGNINLNONPNRNUNZOMPAPEPFPGPHPKPLPMPNPRPSPTPWPYQARERORSRURWSASBSCSDSESGSHSISJSKSLSMSNSOSRSSSTSVSXSYSZTCTDTFTGTHTJTKTLTMTNTOTRTTTVTWTZUAUGUMUSUYUZVAVCVEVGVIVNVUWFWSXKYEYTZAZMZW','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='CountryCodeIdentifier') ) and ( not(@listID!='CountryCodeIdentifier') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='EU-COM-GROW') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('ADAEAFAGAIALAMAOAQARASATAUAWAXAZBABBBDBEBFBGBHBIBJBLBMBNBOBQBRBSBTBVBWBYBZCACCCDCFCGCHCICKCLCMCNCOCRCUCVCWCXCYCZDEDJDKDMDODZECEEEGEHERESETFIFJFKFMFOFRGAGBGDGEGFGGGHGIGLGMGNGPGQGRGSGTGUGWGYHKHMHNHRHTHUIDIEILIMINIOIQIRISITJEJMJOJPKEKGKHKIKMKNKPKRKWKYKZLALBLCLILKLRLSLTLULVLYMAMCMDMEMFMGMHMKMLMMMNMOMPMQMRMSMTMUMVMWMXMYMZNANCNENFNGNINLNONPNRNUNZOMPAPEPFPGPHPKPLPMPNPRPSPTPWPYQARERORSRURWSASBSCSDSESGSHSISJSKSLSMSNSOSRSSSTSVSXSYSZTCTDTFTGTHTJTKTLTMTNTOTRTTTVTWTZUAUGUMUSUYUZVAVCVEVGVIVNVUWFWSXKYEYTZAZMZW','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cac:Country/cbc:IdentificationCode" priority="1002" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='CountryCodeIdentifier') ) and ( not(@listID!='CountryCodeIdentifier') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='EU-COM-GROW') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('ADAEAFAGAIALAMAOAQARASATAUAWAXAZBABBBDBEBFBGBHBIBJBLBMBNBOBQBRBSBTBVBWBYBZCACCCDCFCGCHCICKCLCMCNCOCRCUCVCWCXCYCZDEDJDKDMDODZECEEEGEHERESETFIFJFKFMFOFRGAGBGDGEGFGGGHGIGLGMGNGPGQGRGSGTGUGWGYHKHMHNHRHTHUIDIEILIMINIOIQIRISITJEJMJOJPKEKGKHKIKMKNKPKRKWKYKZLALBLCLILKLRLSLTLULVLYMAMCMDMEMFMGMHMKMLMMMNMOMPMQMRMSMTMUMVMWMXMYMZNANCNENFNGNINLNONPNRNUNZOMPAPEPFPGPHPKPLPMPNPRPSPTPWPYQARERORSRURWSASBSCSDSESGSHSISJSKSLSMSNSOSRSSSTSVSXSYSZTCTDTFTGTHTJTKTLTMTNTOTRTTTVTWTZUAUGUMUSUYUZVAVCVEVGVIVNVUWFWSXKYEYTZAZMZW','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='CountryCodeIdentifier') ) and ( not(@listID!='CountryCodeIdentifier') ) and ( not(@listVersionID!='1.0.2') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='EU-COM-GROW') ) and ( not(@listAgencyID!='EU-COM-GROW') ) and (contains(translate('ADAEAFAGAIALAMAOAQARASATAUAWAXAZBABBBDBEBFBGBHBIBJBLBMBNBOBQBRBSBTBVBWBYBZCACCCDCFCGCHCICKCLCMCNCOCRCUCVCWCXCYCZDEDJDKDMDODZECEEEGEHERESETFIFJFKFMFOFRGAGBGDGEGFGGGHGIGLGMGNGPGQGRGSGTGUGWGYHKHMHNHRHTHUIDIEILIMINIOIQIRISITJEJMJOJPKEKGKHKIKMKNKPKRKWKYKZLALBLCLILKLRLSLTLULVLYMAMCMDMEMFMGMHMKMLMMMNMOMPMQMRMSMTMUMVMWMXMYMZNANCNENFNGNINLNONPNRNUNZOMPAPEPFPGPHPKPLPMPNPRPSPTPWPYQARERORSRURWSASBSCSDSESGSHSISJSKSLSMSNSOSRSSSTSVSXSYSZTCTDTFTGTHTJTKTLTMTNTOTRTTTVTWTZUAUGUMUSUYUZVAVCVEVGVIVNVUWFWSXKYEYTZAZMZW','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:ProcurementTypeCode" priority="1001" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='ProcedureType') ) and ( not(@listID!='ProcedureType') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='OJEU') ) and ( not(@listAgencyID!='') ) and (contains(translate('123C46TVAAMIVDLLOV9','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='ProcedureType') ) and ( not(@listID!='ProcedureType') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='OJEU') ) and ( not(@listAgencyID!='') ) and (contains(translate('123C46TVAAMIVDLLOV9','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="espd-cbc:EconomicOperatorRoleCode" priority="1000" mode="M0">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='TendererRole') ) and ( not(@listID!='TendererRole') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='BII') ) and ( not(@listAgencyID!='BII') ) and (contains(translate('MTSCCLCMJVSMEOTH','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) ) "/>
         <axsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="( false() or ( ( not(@listName!='TendererRole') ) and ( not(@listID!='TendererRole') ) and ( not(@listVersionID!='1.0') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='Placeholder') ) and ( not(@listAgencyName!='BII') ) and ( not(@listAgencyID!='BII') ) and (contains(translate('MTSCCLCMJVSMEOTH','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),concat('',translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'')) ) ) )">
               <axsl:attribute name="location">
                  <axsl:apply-templates select="." mode="schematron-get-full-path"/>
               </axsl:attribute>
               <svrl:text>Invalid value: '<axsl:text/>
                  <axsl:value-of select="."/>
                  <axsl:text/>' for the element or invalid codelist used</svrl:text>
            </svrl:failed-assert>
         </axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M0"/>
   <axsl:template match="@*|node()" priority="-2" mode="M0">
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0"/>
   </axsl:template>
</axsl:stylesheet>