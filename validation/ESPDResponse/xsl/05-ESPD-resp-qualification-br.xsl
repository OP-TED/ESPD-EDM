<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:espd-req="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"
                xmlns:espd-resp="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:espd="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

   <!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->
<xsl:key name="EOrole" match="cbc:RoleCode" use="."/>

   <!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
            <xsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/>
            <xsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<xsl:value-of select="$p_1"/>]</xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>']</xsl:text>
            <xsl:variable name="p_2"
                          select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/>
            <xsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<xsl:value-of select="$p_2"/>]</xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters--><xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
<xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="ESPD Response pre-qualification system Business Rules"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                                             prefix="ext"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
                                             prefix="espd"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">BR-RESP-QUAL</xsl:attribute>
            <xsl:attribute name="name">BR-RESP-QUAL</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ESPD Response pre-qualification system Business Rules</svrl:text>

   <!--PATTERN BR-RESP-QUAL-->


	<!--RULE -->
<xsl:template match="espd:QualificationApplicationResponse" priority="1000" mode="M6">
      <xsl:variable name="isPQS"
                    select="(cac:EconomicOperatorParty/cac:QualifyingParty/cac:Party/cac:PartyIdentification/cbc:ID)"/>
      <xsl:variable name="issubcont" select="count(key('EOrole', 'subcont'))=1"/>
      <xsl:variable name="allResponses"
                    select="cac:TenderingCriterionResponse/cbc:ValidatedCriterionPropertyID"/>
      <xsl:variable name="exclusionList"
                    select="translate('&#127;crime-org&#127;&#127;corruption&#127;&#127;fraud&#127;&#127;terr-offence&#127;&#127;finan-laund&#127;&#127;human-traffic&#127;&#127;tax-pay&#127;&#127;socsec-pay&#127;&#127;envir-law&#127;&#127;socsec-law&#127;&#127;labour-law&#127;&#127;bankruptcy&#127;&#127;insolvency&#127;&#127;cred-arran&#127;&#127;bankr-nat&#127;&#127;liq-admin&#127;&#127;susp-act&#127;&#127;prof-misconduct&#127;&#127;distorsion&#127;&#127;partic-confl&#127;&#127;prep-confl&#127;&#127;sanction&#127;&#127;misinterpr&#127;&#127;nati-ground&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:variable name="selectionList"
                    select="translate('&#127;prof-regist&#127;&#127;trade-regist&#127;&#127;autorisation&#127;&#127;membership&#127;&#127;gen-year-to&#127;&#127;aver-year-to&#127;&#127;spec-aver-to&#127;&#127;spec-year-to&#127;&#127;finan-rat&#127;&#127;indem-insu&#127;&#127;finan-requ&#127;&#127;work-perform&#127;&#127;supply-perform&#127;&#127;service-perform&#127;&#127;qual-cont-tech&#127;&#127;work-tech&#127;&#127;qual-facil&#127;&#127;research-fac&#127;&#127;chain-manage&#127;&#127;qualification&#127;&#127;envir-measure&#127;&#127;tech-equip&#127;&#127;spec-req-check&#127;&#127;manage-staff&#127;&#127;year-manpower&#127;&#127;suncont-port&#127;&#127;wo-autent&#127;&#127;w-autent&#127;&#127;qa-certif-inst&#127;&#127;qu-certif-indep&#127;&#127;envir-certif-indep&#127;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:variable name="currentExclusion"
                    select="cac:TenderingCriterion[contains($exclusionList,concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>
      <xsl:variable name="exclusionResponses"
                    select="$currentExclusion[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
      <xsl:variable name="exclusionReqResponses"
                    select="$currentExclusion[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT']      and cac:SubsidiaryTenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>
      <xsl:variable name="exclusionNotResponses"
                    select="$currentExclusion[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode/text()"/>
      <xsl:variable name="exclusionNotReqResponses"
                    select="$currentExclusion[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode='REQUIREMENT']      and cac:SubsidiaryTenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="($isPQS) or(not($isPQS) and (count($currentExclusion) = (count($exclusionResponses) + count($exclusionReqResponses))) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="($isPQS) or(not($isPQS) and (count($currentExclusion) = (count($exclusionResponses) + count($exclusionReqResponses))) )">
               <xsl:attribute name="id">BR-RESP-30</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about compliance of exclusion grounds MUST be provided. The following exclusion criterion are not provided: <xsl:text/>
                  <xsl:value-of select="$exclusionNotResponses"/>
                  <xsl:text/>, <xsl:text/>
                  <xsl:value-of select="$exclusionNotReqResponses"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="currentSelection"
                    select="cac:TenderingCriterion[contains($selectionList,concat('&#127;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#127;'))]"/>
      <xsl:variable name="selectionResponses"
                    select="$currentSelection[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
      <xsl:variable name="selectionReqResponses"
                    select="$currentSelection[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode!='QUESTION']      and cac:SubsidiaryTenderingCriterionPropertyGroup//cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'] ]]/cbc:CriterionTypeCode"/>
      <xsl:variable name="selectionNotResponses"
                    select="$currentSelection[cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty[not(cbc:ID = $allResponses) and cbc:TypeCode='QUESTION']]/cbc:CriterionTypeCode"/>
      <xsl:variable name="selectionNotReqResponses"
                    select="$currentSelection[cac:TenderingCriterionPropertyGroup[cac:TenderingCriterionProperty[cbc:TypeCode!='QUESTION']      and count(cac:SubsidiaryTenderingCriterionPropertyGroup//cac:TenderingCriterionProperty[cbc:ID = $allResponses and cbc:TypeCode='QUESTION'])=0 ]]/cbc:CriterionTypeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($isPQS) and not($issubcont)) or (not(($isPQS) and not($issubcont)) and (count($currentSelection) = (count($selectionResponses) + count($selectionReqResponses))) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(($isPQS) and not($issubcont)) or (not(($isPQS) and not($issubcont)) and (count($currentSelection) = (count($selectionResponses) + count($selectionReqResponses))) )">
               <xsl:attribute name="id">BR-RESP-40</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about compliance of selection criteria MUST be provided. The following selection criterion are not provided:<xsl:text/>
                  <xsl:value-of select="$selectionNotResponses"/>
                  <xsl:text/>, <xsl:text/>
                  <xsl:value-of select="$selectionNotReqResponses"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="hasServiceProvider"
                    select="(cac:ContractingParty/cac:Party/cac:ServiceProviderParty)"/>
      <xsl:variable name="testS10" select="$isPQS and not($issubcont) and $hasServiceProvider"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($testS10) or ($testS10 and (count($currentSelection) = (count($selectionResponses) + count($selectionReqResponses))) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($testS10) or ($testS10 and (count($currentSelection) = (count($selectionResponses) + count($selectionReqResponses))) )">
               <xsl:attribute name="id">BR-RESP-80-S10</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>When the pre-qualification system the EO is registered on does not cover all the selection criteria, information about compliance of selection criteria MUST be provided. The following selection criterion are not provided: <xsl:text/>
                  <xsl:value-of select="$selectionNotResponses"/>
                  <xsl:text/>, <xsl:text/>
                  <xsl:value-of select="$selectionNotReqResponses"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="testS20" select="$isPQS and not($issubcont) and not($hasServiceProvider)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($testS20) or ($testS20 and (count($selectionResponses) = 0) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($testS20) or ($testS20 and (count($selectionResponses) = 0) )">
               <xsl:attribute name="id">BR-RESP-80-S20</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>When the pre-qualification system the EO is registered on covers all the selection criteria, information about compliance of selection criteria IS NOT required.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
</xsl:stylesheet>