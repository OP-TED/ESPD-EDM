<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:ccv="urn:isa:names:specification:ubl:schema:xsd:CCV-CommonAggregateComponents-1"
                 version="2.0"><!--Importing stylesheet additions-->
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
                <axsl:if test="$p&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p"/>]
                </axsl:if>
            </axsl:when>
            <axsl:otherwise>
                <axsl:text>*[local-name()='</axsl:text>
                <axsl:value-of select="local-name()"/>
                <axsl:text>' and namespace-uri()='</axsl:text>
                <axsl:value-of select="namespace-uri()"/>
                <axsl:text>']</axsl:text>
                <axsl:variable name="p" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/>
                <axsl:if test="$p&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of
                        select="$p"/>]
                </axsl:if>
            </axsl:otherwise>
        </axsl:choose>
    </axsl:template>
    <axsl:template match="@*" mode="schematron-get-full-path">
        <axsl:text>/</axsl:text>
        <axsl:choose>
            <axsl:when test="namespace-uri()=''">@
                <axsl:value-of select="name()"/>
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
            <axsl:text/>/@
            <axsl:value-of select="name(.)"/>
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
        <axsl:value-of
                select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
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
            <axsl:text/>/@
            <axsl:value-of select="name(.)"/>
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
        <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="Common Business Rules assertions"
                                schemaVersion="">
            <axsl:comment>
                <axsl:value-of select="$archiveDirParameter"/>
                 
                <axsl:value-of select="$archiveNameParameter"/>
                 
                <axsl:value-of select="$fileNameParameter"/>
                 
                <axsl:value-of select="$fileDirParameter"/>
            </axsl:comment>
            <axsl:apply-templates select="/" mode="M12"/>
        </svrl:schematron-output>
    </axsl:template>

    <!--SCHEMATRON PATTERNS-->


    <!--PATTERN common-br-rules-->


    <!--RULE -->

    <axsl:template match="/espd:ESPDResponse/espd-cac:EconomicOperatorParty/cac:Party" priority="1002" mode="M12">

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="( not(string(cac:PartyIdentification/cbc:ID))=false() )"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="( not(string(cac:PartyIdentification/cbc:ID))=false() )">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element 'cac:Party / cac:PartyIdentification / cbc:ID' is mandatory</svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="( not(string(cac:PartyName/cbc:Name))=false() )"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="( not(string(cac:PartyName/cbc:Name))=false() )">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element 'cac:Party / cac:PartyName / cbc:Name' is mandatory</svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="( not(string(cac:PostalAddress/cac:Country/cbc:IdentificationCode))=false() )"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="( not(string(cac:PostalAddress/cac:Country/cbc:IdentificationCode))=false() )">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element 'cac:Country / cbc:IdentificationCode' is mandatory</svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
    </axsl:template>

    <!--RULE -->

    <axsl:template match="ccv:RequirementGroup/ccv:Requirement" priority="1001" mode="M12">

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(count( ccv:Response ) &gt; 1)"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(count( ccv:Response ) &gt; 1)">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>Only one element MUST be provided to respond to a Requirement.</svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='AMOUNT' and (string(ccv:Response/cbc:Amount))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='AMOUNT' and (string(ccv:Response/cbc:Amount))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='CODE' and (string(ccv:Response/ccv-cbc:Code))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='CODE' and (string(ccv:Response/ccv-cbc:Code))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='CODE_COUNTRY' and (string(ccv:Response/cbc:Description))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='CODE_COUNTRY' and (string(ccv:Response/cbc:Description))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='DATE' and (string(ccv:Response/cbc:Date))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='DATE' and (string(ccv:Response/cbc:Date))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='DESCRIPTION' and (string(ccv:Response/cbc:Description))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='DESCRIPTION' and (string(ccv:Response/cbc:Description))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='EVIDENCE_URL' and (string(ccv:Response/cbc:Description))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='EVIDENCE_URL' and (string(ccv:Response/cbc:Description))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='INDICATOR' and (string(ccv:Response/ccv-cbc:Indicator))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='INDICATOR' and (string(ccv:Response/ccv-cbc:Indicator))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='PERCENTAGE' and (string(ccv:Response/cbc:Percent))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='PERCENTAGE' and (string(ccv:Response/cbc:Percent))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='PERIOD' and (string(ccv:Response/cbc:Description))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='PERIOD' and (string(ccv:Response/cbc:Description))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when
                    test="not(@responseDataType='QUANTITY_INTEGER' and (string(ccv:Response/cbc:Quantity))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='QUANTITY_INTEGER' and (string(ccv:Response/cbc:Quantity))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='QUANTITY_YEAR' and (string(ccv:Response/cbc:Quantity))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='QUANTITY_YEAR' and (string(ccv:Response/cbc:Quantity))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when test="not(@responseDataType='QUANTITY' and (string(ccv:Response/cbc:Quantity))=false())"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(@responseDataType='QUANTITY' and (string(ccv:Response/cbc:Quantity))=false())">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>The element used inside the Response to answer a Requirement MUST always match the type
                        of data indicated by the attribute ResponseDataType of the Requirement.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
    </axsl:template>

    <!--RULE -->

    <axsl:template match="ccv:RequirementGroup" priority="1000" mode="M12">

        <!--ASSERT -->

        <axsl:choose>
            <axsl:when
                    test="not(starts-with(parent::ccv:Criterion/cbc:TypeCode, 'CRITERION.EXCLUSION.')) or ((string(ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator)=false()) or not(ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator='true')) or (not((ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator='true') and (count(ccv:Requirement/ccv:Response) &lt; 2)))"/>
            <axsl:otherwise>
                <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                    test="not(starts-with(parent::ccv:Criterion/cbc:TypeCode, 'CRITERION.EXCLUSION.')) or ((string(ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator)=false()) or not(ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator='true')) or (not((ccv:Requirement[1]/ccv:Response/ccv-cbc:Indicator='true') and (count(ccv:Requirement/ccv:Response) &lt; 2)))">
                    <axsl:attribute name="location">
                        <axsl:apply-templates select="." mode="schematron-get-full-path"/>
                    </axsl:attribute>
                    <svrl:text>All Exclusion Criteria behave in this same way: if the answer to the first requirement is
                        affirmative (a “yes” answer) specific data related to that criterion MUST be provided.
                    </svrl:text>
                </svrl:failed-assert>
            </axsl:otherwise>
        </axsl:choose>
        <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
    </axsl:template>
    <axsl:template match="text()" priority="-1" mode="M12"/>
    <axsl:template match="@*|node()" priority="-2" mode="M12">
        <axsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
    </axsl:template>
</axsl:stylesheet>