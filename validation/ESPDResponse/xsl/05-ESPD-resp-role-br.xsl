<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:espd="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
                xmlns:espd-req="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"
                xmlns:espd-resp="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationResponse-2"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
   <xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>
   <!--XSD TYPES FOR XSLT2-->
   <!--KEYS AND FUNCTIONS-->
   <xsl:key name="EOroleTest" match="cbc:RoleCode" use="."/>
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
            <xsl:variable name="p_1"
                          select="1+    count(preceding-sibling::*[name()=name(current())])"/>
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
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>
   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="ESPD Response Role Business Rules"
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
            <xsl:attribute name="id">BR-RESP-LEAD</xsl:attribute>
            <xsl:attribute name="name">BR-RESP-LEAD</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">ESPD Response Role Business Rules</svrl:text>
   <!--PATTERN BR-RESP-LEAD-->
   <!--RULE -->
   <xsl:template match="espd:QualificationApplicationResponse"
                 priority="1003"
                 mode="M6">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(key('EOroleTest', 'group-lead'))=1 and (exists(cbc:EconomicOperatorGroupName))) or not(count(key('EOroleTest', 'group-lead'))=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(key('EOroleTest', 'group-lead'))=1 and (exists(cbc:EconomicOperatorGroupName))) or not(count(key('EOroleTest', 'group-lead'))=1)">
               <xsl:attribute name="id">BR-LEAD-10-S10</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The current EO role is 'group-lead', the information about the group ('/cbc:EconomicOperatorGroupName') must be provided.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="selectionList"
                    select="translate('&#x7f;prof-regist&#x7f;&#x7f;trade-regist&#x7f;&#x7f;autorisation&#x7f;&#x7f;membership&#x7f;&#x7f;gen-year-to&#x7f;&#x7f;aver-year-to&#x7f;&#x7f;spec-aver-to&#x7f;&#x7f;spec-year-to&#x7f;&#x7f;finan-rat&#x7f;&#x7f;indem-insu&#x7f;&#x7f;finan-requ&#x7f;&#x7f;work-perform&#x7f;&#x7f;supply-perform&#x7f;&#x7f;service-perform&#x7f;&#x7f;qual-cont-tech&#x7f;&#x7f;work-tech&#x7f;&#x7f;qual-facil&#x7f;&#x7f;research-fac&#x7f;&#x7f;chain-manage&#x7f;&#x7f;qualification&#x7f;&#x7f;envir-measure&#x7f;&#x7f;tech-equip&#x7f;&#x7f;spec-req-check&#x7f;&#x7f;manage-staff&#x7f;&#x7f;year-manpower&#x7f;&#x7f;suncont-port&#x7f;&#x7f;wo-autent&#x7f;&#x7f;w-autent&#x7f;&#x7f;qa-certif-inst&#x7f;&#x7f;qu-certif-indep&#x7f;&#x7f;envir-certif-indep&#x7f;','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:variable name="currentSelection"
                    select="cac:TenderingCriterion[contains($selectionList,concat('&#x7f;',translate(cbc:CriterionTypeCode,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'&#x7f;'))]"/>
      <xsl:variable name="selectionResponse"
                    select="cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $currentSelection]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(count(key('EOroleTest', 'subcont'))=1 and (count($selectionResponse) = 0 )) or not(count(key('EOroleTest', 'subcont'))=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(key('EOroleTest', 'subcont'))=1 and (count($selectionResponse) = 0 )) or not(count(key('EOroleTest', 'subcont'))=1)">
               <xsl:attribute name="id">BR-SUBCONT-01</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If EO role is 'subcont - Subcontractor', the entity does not have to provide information about the selection criteria.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'eo-group') ]"
                 priority="1002"
                 mode="M6">
      <xsl:variable name="togetherCriterion"
                    select="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
      <xsl:variable name="togetherCriterionResponse"
                    select="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $togetherCriterion ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="( count(key('EOroleTest', 'group-lead'))=1 and (count($togetherCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( count(key('EOroleTest', 'group-lead'))=1 and (count($togetherCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)">
               <xsl:attribute name="id">BR-LAED-10</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about the other participants MUST be provided (criteria 'eo-group').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'relied') ]"
                 priority="1001"
                 mode="M6">
      <xsl:variable name="relyCriterion"
                    select="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
      <xsl:variable name="relyCriterionResponse"
                    select="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $relyCriterion ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="( count(key('EOroleTest', 'group-lead'))=1 and (count($relyCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( count(key('EOroleTest', 'group-lead'))=1 and (count($relyCriterionResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)">
               <xsl:attribute name="id">BR-LEAD-10-S20</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about all the entities the EO relies on MUST be provided (criteria 'relied').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="cac:TenderingCriterion[ starts-with(cbc:CriterionTypeCode, 'subco-ent') ]"
                 priority="1000"
                 mode="M6">
      <xsl:variable name="subcontractorCriterion"
                    select="cac:TenderingCriterionPropertyGroup/cac:TenderingCriterionProperty/cbc:ID"/>
      <xsl:variable name="subcontractorResponse"
                    select="/*[1]/cac:TenderingCriterionResponse[ cbc:ValidatedCriterionPropertyID = $subcontractorCriterion ]"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="( count(key('EOroleTest', 'group-lead'))=1 and (count($subcontractorResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( count(key('EOroleTest', 'group-lead'))=1 and (count($subcontractorResponse) &gt; 0) ) or not(count(key('EOroleTest', 'group-lead'))=1)">
               <xsl:attribute name="id">BR-LEAD-10-S30</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Information about all the entities the EO relies on MUST be provided (criteria 'subco-ent').</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*" mode="M6"/>
   </xsl:template>
</xsl:stylesheet>
