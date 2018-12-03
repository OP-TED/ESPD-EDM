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
                xmlns:udt="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
                xmlns:espd="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"
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
                              title="Common Criterion Business Rules"
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
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
                                             prefix="udt"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"
                                             prefix="espd"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">BR-COM-CR</xsl:attribute>
            <xsl:attribute name="name">BR-COM-CR</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Common Criterion Business Rules</svrl:text>

   <!--PATTERN BR-COM-CR-->


	<!--RULE -->
<xsl:template match="cac:TenderingCriterion" priority="1003" mode="M6">
      <xsl:variable name="currentID" select="cbc:ID"/>
      <xsl:variable name="currentIDExist" select="(cbc:ID) and not(normalize-space(cbc:ID) = '')"/>
      <xsl:variable name="applicationType" select="/*[1]/cbc:QualificationApplicationTypeCode"/>
      <xsl:variable name="ElementUUID"
                    select="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.1.0.xml')//cac:TenderingCriterion[cbc:ID = $currentID]      else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.1.0.xml')//cac:TenderingCriterion[cbc:ID = $currentID]"/>
      <xsl:variable name="ElementUUIDExists" select="(count($ElementUUID/cbc:ID) = 1)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="$currentIDExist"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="$currentIDExist">
               <xsl:attribute name="id">BR-TC-02-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The identifier of the criterion ('/cac:TenderingCriterion/cbc:ID') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:CriterionTypeCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:CriterionTypeCode)">
               <xsl:attribute name="id">BR-TC-03</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Classification code ('/cac:TenderingCriterion/cbc:CriterionTypeCode') to represent the criterion in the ESPD taxonomy of criteria is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:Name)">
               <xsl:attribute name="id">BR-TC-05</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The name of the criterion ('/cac:TenderingCriterion/cbc:Name') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Description)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:Description)">
               <xsl:attribute name="id">BR-TC-06</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>An extended description of the criterion ('/cac:TenderingCriterion/cbc:Description') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($ElementUUIDExists) or ((count($ElementUUID/cac:TenderingCriterionPropertyGroup) &lt;= count(cac:TenderingCriterionPropertyGroup)) and ($ElementUUIDExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($ElementUUIDExists) or ((count($ElementUUID/cac:TenderingCriterionPropertyGroup) &lt;= count(cac:TenderingCriterionPropertyGroup)) and ($ElementUUIDExists))">
               <xsl:attribute name="id">BR-TC-07</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The Tendering Criterion, which 'cac:TenderingCriterion/cbc:ID = <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>', has '<xsl:text/>
                  <xsl:value-of select="count($ElementUUID/cac:TenderingCriterionPropertyGroup) - count(cac:TenderingCriterionPropertyGroup)"/>
                  <xsl:text/>' missing 'cac:TenderingCriterionPropertyGroup' element(s).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="currentCode" select="cbc:CriterionTypeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or ($ElementUUIDExists and ($currentIDExist))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or ($ElementUUIDExists and ($currentIDExist))">
               <xsl:attribute name="id">BR-TC-02-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Each criterion must use the UUID supplied by e-Certis. The '/cac:TenderingCriterion/cbc:ID = <xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>' is not defined in e-Certis.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($ElementUUIDExists) or ($ElementUUID/cbc:CriterionTypeCode = $currentCode and ($ElementUUIDExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($ElementUUIDExists) or ($ElementUUID/cbc:CriterionTypeCode = $currentCode and ($ElementUUIDExists))">
               <xsl:attribute name="id">BR-TC-04</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The criterion type code should match the one from e-Certis. The code '/cac:TenderingCriterion/cbc:CriterionTypeCode = <xsl:text/>
                  <xsl:value-of select="$currentCode"/>
                  <xsl:text/>' is not defined in e-Certis.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:Legislation" priority="1002" mode="M6">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Title)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:Title)">
               <xsl:attribute name="id">BR-TC-09</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The complete title of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Title') provided is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Description)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:Description)">
               <xsl:attribute name="id">BR-TC-10</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The description of the legislation (/cac:TenderingCriterion/cac:Legislation/cbc:Description') provided in the original legal text SHOULD be provided.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Article)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:Article)">
               <xsl:attribute name="id">BR-TC-11</xsl:attribute>
               <xsl:attribute name="flag">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Other articles where the Criterion is referred to (/cac:TenderingCriterion/cac:Legislation/cbc:Article') SHOULD also be provided.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionPropertyGroup | cac:SubsidiaryTenderingCriterionPropertyGroup"
                 priority="1001"
                 mode="M6">
      <xsl:variable name="currentID" select="cbc:ID"/>
      <xsl:variable name="currentCode" select="cbc:PropertyGroupTypeCode"/>
      <xsl:variable name="parentID" select="ancestor::*[1]/cbc:ID"/>
      <xsl:variable name="applicationType" select="/*[1]/cbc:QualificationApplicationTypeCode"/>
      <xsl:variable name="ElementUUID_SUB"
                    select="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.1.0.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $currentID]      else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.1.0.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $currentID]"/>
      <xsl:variable name="ParentUUID_SUB"
                    select="$ElementUUID_SUB[parent::*[cbc:ID = $parentID]][1]"/>
      <xsl:variable name="ElementUUID_T"
                    select="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.1.0.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $currentID]      else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.1.0.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $currentID]"/>
      <xsl:variable name="ParentUUID_T" select="$ElementUUID_T[parent::*[cbc:ID = $parentID]][1]"/>
      <xsl:variable name="ElementUUID_TExists" select="(count($ParentUUID_T/cbc:ID) &gt; 0)"/>
      <xsl:variable name="ElementUUID_SUBExists" select="(count($ParentUUID_SUB/cbc:ID) &gt; 0)"/>
      <xsl:variable name="ElementUUIDExists"
                    select="$ElementUUID_SUBExists or $ElementUUID_TExists"/>
      <xsl:variable name="currentIDExist"
                    select="(cbc:ID) and not(normalize-space(cbc:ID) = '') and ($ElementUUIDExists)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:ID)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:ID)">
               <xsl:attribute name="id">BR-TC-12</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The identifier of a group of requirements ('<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>/cbc:ID') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:PropertyGroupTypeCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:PropertyGroupTypeCode)">
               <xsl:attribute name="id">BR-TC-14</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Code addressed to control the behavior of the group of criteria ('<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>/cbc:PropertyGroupTypeCode') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or (count($ParentUUID_T/cac:TenderingCriterionProperty) &lt;= count(cac:TenderingCriterionProperty) and ($currentIDExist) and ($ElementUUID_TExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or (count($ParentUUID_T/cac:TenderingCriterionProperty) &lt;= count(cac:TenderingCriterionProperty) and ($currentIDExist) and ($ElementUUID_TExists))">
               <xsl:attribute name="id">BR-TC-16-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The tendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>']') has '<xsl:text/>
                  <xsl:value-of select="count($ParentUUID_T/cac:TenderingCriterionProperty) - count(cac:TenderingCriterionProperty)"/>
                  <xsl:text/>' missing 'cac:TenderingCriterionProperty' element(s).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or (count($ParentUUID_SUB/cac:TenderingCriterionProperty) &lt;= count(cac:TenderingCriterionProperty) and ($currentIDExist) and ($ElementUUID_SUBExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or (count($ParentUUID_SUB/cac:TenderingCriterionProperty) &lt;= count(cac:TenderingCriterionProperty) and ($currentIDExist) and ($ElementUUID_SUBExists))">
               <xsl:attribute name="id">BR-TC-16-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The subtendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>']') has '<xsl:text/>
                  <xsl:value-of select="count($ParentUUID_SUB/cac:TenderingCriterionProperty) - count(cac:TenderingCriterionProperty)"/>
                  <xsl:text/>' missing 'cac:TenderingCriterionProperty' element(s).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or (count($ParentUUID_T/cac:SubsidiaryTenderingCriterionPropertyGroup) &lt;= count(cac:SubsidiaryTenderingCriterionPropertyGroup) and ($currentIDExist) and ($ElementUUID_TExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or (count($ParentUUID_T/cac:SubsidiaryTenderingCriterionPropertyGroup) &lt;= count(cac:SubsidiaryTenderingCriterionPropertyGroup) and ($currentIDExist) and ($ElementUUID_TExists))">
               <xsl:attribute name="id">BR-TC-17-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The tendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>']') has '<xsl:text/>
                  <xsl:value-of select="count($ParentUUID_T/cac:SubsidiaryTenderingCriterionPropertyGroup) - count(cac:SubsidiaryTenderingCriterionPropertyGroup)"/>
                  <xsl:text/>' missing 'cac:SubsidiaryTenderingCriterionPropertyGroup' element(s).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or (count($ParentUUID_SUB/cac:SubsidiaryTenderingCriterionPropertyGroup) &lt;= count(cac:SubsidiaryTenderingCriterionPropertyGroup) and ($currentIDExist) and ($ElementUUID_SUBExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or (count($ParentUUID_SUB/cac:SubsidiaryTenderingCriterionPropertyGroup) &lt;= count(cac:SubsidiaryTenderingCriterionPropertyGroup) and ($currentIDExist) and ($ElementUUID_SUBExists))">
               <xsl:attribute name="id">BR-TC-17-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The subtendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>']') has '<xsl:text/>
                  <xsl:value-of select="count($ParentUUID_SUB/cac:SubsidiaryTenderingCriterionPropertyGroup) - count(cac:SubsidiaryTenderingCriterionPropertyGroup)"/>
                  <xsl:text/>' missing 'cac:SubsidiaryTenderingCriterionPropertyGroup' element(s).</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(($ElementUUIDExists) and ((cbc:ID) and not(normalize-space(cbc:ID) = ''))) or not((cbc:ID) and not(normalize-space(cbc:ID) = ''))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(($ElementUUIDExists) and ((cbc:ID) and not(normalize-space(cbc:ID) = ''))) or not((cbc:ID) and not(normalize-space(cbc:ID) = ''))">
               <xsl:attribute name="id">BR-TC-13</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Compulsory use of the UUIDs supplied by e-Certis. The <xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/> ('<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>']') does not exist in e-Certis.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or ($ParentUUID_T/cbc:PropertyGroupTypeCode = $currentCode and ($currentIDExist) and ($ElementUUID_TExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_TExists)) or ($ParentUUID_T/cbc:PropertyGroupTypeCode = $currentCode and ($currentIDExist) and ($ElementUUID_TExists))">
               <xsl:attribute name="id">BR-TC-15-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The property group type code should match the one from e-Certis. The tendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="$currentCode"/>
                  <xsl:text/>') does not exisit in the e-Certis for the following element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>'].</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or ($ParentUUID_SUB/cbc:PropertyGroupTypeCode = $currentCode and ($currentIDExist) and ($ElementUUID_SUBExists))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentIDExist) or (($currentIDExist) and not($ElementUUID_SUBExists)) or ($ParentUUID_SUB/cbc:PropertyGroupTypeCode = $currentCode and ($currentIDExist) and ($ElementUUID_SUBExists))">
               <xsl:attribute name="id">BR-TC-15-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The property group type code should match the one from e-Certis. The subtendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="$currentCode"/>
                  <xsl:text/>') does not exisit in the e-Certis for the following element '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$parentID"/>
                  <xsl:text/>']/<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>[cbc:ID = '<xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>'].</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="cac:TenderingCriterionProperty" priority="1000" mode="M6">
      <xsl:variable name="currentID" select="cbc:ID"/>
      <xsl:variable name="currentDescr" select="cbc:Description"/>
      <xsl:variable name="currentType" select="cbc:TypeCode"/>
      <xsl:variable name="currentValueData" select="cbc:ValueDataTypeCode"/>
      <xsl:variable name="TCPropertyGroupID" select="ancestor::*[1]/cbc:ID"/>
      <xsl:variable name="applicationType" select="/*[1]/cbc:QualificationApplicationTypeCode"/>
      <xsl:variable name="ElementUUIDSTC"
                    select="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.1.0.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty      else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.1.0.xml')//cac:SubsidiaryTenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty"/>
      <xsl:variable name="ElementUUID_STCExists" select="(count($ElementUUIDSTC) &gt; 0)"/>
      <xsl:variable name="ElementUUIDTC"
                    select="if ($applicationType!='SELFCONTAINED') then document('ESPD-CriteriaTaxonomy-REGULATED.V2.1.0.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty      else document('ESPD-CriteriaTaxonomy-SELFCONTAINED.V2.1.0.xml')//cac:TenderingCriterionPropertyGroup[cbc:ID = $TCPropertyGroupID][1]/cac:TenderingCriterionProperty"/>
      <xsl:variable name="ElementUUID_TCExists" select="(count($ElementUUIDTC) &gt; 0)"/>
      <xsl:variable name="ElementUUIDExists"
                    select="$ElementUUID_TCExists or $ElementUUID_STCExists"/>
      <xsl:variable name="currentTypeExist"
                    select="(cbc:TypeCode) and not(normalize-space(cbc:TypeCode) = '') and ($ElementUUIDExists)"/>
      <xsl:variable name="currentValueTypeExist"
                    select="(cbc:ValueDataTypeCode) and not(normalize-space(cbc:ValueDataTypeCode) = '') and ($ElementUUIDExists)"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:ID)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:ID)">
               <xsl:attribute name="id">BR-TC-18</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The identifier of a specific property ('<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>/cbc:ID') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Description)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:Description)">
               <xsl:attribute name="id">BR-TC-19</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The text of the caption, requirement or question ('<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>/cbc:Description') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:TypeCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:TypeCode)">
               <xsl:attribute name="id">BR-TC-20</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of property ('<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>/cbc:TypeCode') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:ValueDataTypeCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(cbc:ValueDataTypeCode)">
               <xsl:attribute name="id">BR-TC-21-01</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer expected by the contracting authority ('<xsl:text/>
                  <xsl:value-of select="name()"/>
                  <xsl:text/>/cbc:ValueDataTypeCode') is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentTypeExist) or ((count($ElementUUIDTC[cbc:TypeCode = $currentType])&gt;=1 or count($ElementUUIDSTC[cbc:TypeCode = $currentType])&gt;=1) and ($currentTypeExist))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentTypeExist) or ((count($ElementUUIDTC[cbc:TypeCode = $currentType])&gt;=1 or count($ElementUUIDSTC[cbc:TypeCode = $currentType])&gt;=1) and ($currentTypeExist))">
               <xsl:attribute name="id">BR-TC-20-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The tendering criterion property group ('<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>The tendering criterion property type code should match the one from e-Certis. The <xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>, which 'cbc:ID = <xsl:text/>
                  <xsl:value-of select="$TCPropertyGroupID"/>
                  <xsl:text/>', does not have a '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/cac:TenderingCriterionProperty[cbc:ID = <xsl:text/>
                  <xsl:value-of select="$currentID"/>
                  <xsl:text/>]/cbc:TypeCode = <xsl:text/>
                  <xsl:value-of select="$currentType"/>
                  <xsl:text/>' defined in e-Certis.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentValueTypeExist) or ((count($ElementUUIDTC[cbc:ValueDataTypeCode = $currentValueData])&gt;=1 or count($ElementUUIDSTC[cbc:ValueDataTypeCode = $currentValueData])&gt;=1) and ($currentValueTypeExist))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentValueTypeExist) or ((count($ElementUUIDTC[cbc:ValueDataTypeCode = $currentValueData])&gt;=1 or count($ElementUUIDSTC[cbc:ValueDataTypeCode = $currentValueData])&gt;=1) and ($currentValueTypeExist))">
               <xsl:attribute name="id">BR-TC-21-03</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The tendering criterion property value data type should match the one from e-Certis. The <xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>, which 'cbc:ID = <xsl:text/>
                  <xsl:value-of select="$TCPropertyGroupID"/>
                  <xsl:text/>', does not have a '<xsl:text/>
                  <xsl:value-of select="name(ancestor::*[1])"/>
                  <xsl:text/>/cac:TenderingCriterionProperty[cbc:ID = <xsl:text/>
                  <xsl:value-of select="cbc:ID"/>
                  <xsl:text/>]/cbc:ValueDataTypeCode = <xsl:text/>
                  <xsl:value-of select="cbc:ValueDataTypeCode"/>
                  <xsl:text/>' defined in e-Certis.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not($currentTypeExist and $currentValueTypeExist) or ( (cbc:TypeCode='CAPTION' and cbc:ValueDataTypeCode='NONE') or ((cbc:TypeCode='QUESTION' or cbc:TypeCode='REQUIREMENT') and not(cbc:ValueDataTypeCode='NONE')) and ($currentTypeExist and $currentValueTypeExist))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="not($currentTypeExist and $currentValueTypeExist) or ( (cbc:TypeCode='CAPTION' and cbc:ValueDataTypeCode='NONE') or ((cbc:TypeCode='QUESTION' or cbc:TypeCode='REQUIREMENT') and not(cbc:ValueDataTypeCode='NONE')) and ($currentTypeExist and $currentValueTypeExist))">
               <xsl:attribute name="id">BR-TC-21-02</xsl:attribute>
               <xsl:attribute name="flag">fatal</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The type of answer ('cbc:ValueDataTypeCode') must be different to NONE for properties ('cbc:TypeCode') of type QUESTION; or equal to NONE for properties of type CAPTION and REQUIREMENT. The current value is 'cbc:ValueDataTypeCode'='<xsl:text/>
                  <xsl:value-of select="cbc:ValueDataTypeCode"/>
                  <xsl:text/>' and 'cbc:TypeCode'='<xsl:text/>
                  <xsl:value-of select="cbc:TypeCode"/>
                  <xsl:text/>'</svrl:text>
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