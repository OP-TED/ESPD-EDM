<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <title>Common Code lists Values Restrictions</title>
    
    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
    
    <pattern id="BR-COM-CL-RESTR">
        
        <!--
		ESPD code list values restrictions - 01 ESPD Common CL Values Resitrctions.sch
		Version 2.1.0
	
        $Id: 01 ESPD Common CL Values Restrictions.sch,v 2.1.0 $

        -->
        <let name="selfcontained" value="if (/*[1]/cbc:QualificationApplicationTypeCode = 'SELFCONTAINED') then 'SELF-CONTAINED' else 'REGULATED'"/><!-- TRUE is selfcontained / FALSE is regulated -->
        
        <!-- CONTEXT -->
        <rule context="cbc:ValueDataTypeCode">
            <let name="gc" value="document('../../../../cl/gc/ResponseDataType-CodeList.gc')//SimpleCodeList"/>
            <let name="currentValue" value="."/>
            
            <assert test="(not(exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue])) or (exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]) and contains($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]/Value[@ColumnRef = 'context']/SimpleValue, $selfcontained)))" 
                flag="fatal" id="BR-COM-CL-RESTR-01.01">The context of the value '<value-of select="local-name()"/>=<value-of select="."/>' does not match the type of 'cbc:QualificationApplicationTypeCode'.</assert>
         </rule>
        <rule context="cbc:WeightingTypeCode">
            <let name="gc" value="document('../../../../cl/gc/WeightingType-CodeList.gc')//SimpleCodeList"/>
            <let name="currentValue" value="."/>
            
            <assert test="(not(exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue])) or (exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]) and contains($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]/Value[@ColumnRef = 'context']/SimpleValue, $selfcontained)))" 
                flag="fatal" id="BR-COM-CL-RESTR-01.02">The context of the value '<value-of select="local-name()"/>=<value-of select="."/>' does not match the type of 'cbc:QualificationApplicationTypeCode'.</assert>
        </rule>
        <rule context="cac:TenderingCriterion/cbc:EvaluationMethodTypeCode">
            <let name="gc" value="document('../../../../cl/gc/EvaluationMethodType-CodeList.gc')//SimpleCodeList"/>
            <let name="currentValue" value="."/>
            
            <assert test="(not(exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue])) or (exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]) and contains($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]/Value[@ColumnRef = 'context']/SimpleValue, $selfcontained)))" 
                flag="fatal" id="BR-COM-CL-RESTR-01.03">The context of the value '<value-of select="local-name()"/>=<value-of select="."/>' does not match the type of 'cbc:QualificationApplicationTypeCode'.</assert>
        </rule>
        <rule context="cbc:CriterionTypeCode">
            <let name="gc" value="document('../../../../cl/gc/ESPD-CriteriaTaxonomy_V2.1.0.gc')//SimpleCodeList"/>
            <let name="currentValue" value="."/>
            
            <assert test="(not(exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue])) or (exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]) and contains($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]/Value[@ColumnRef = 'context']/SimpleValue, $selfcontained)))" 
                flag="fatal" id="BR-COM-CL-RESTR-01.04">The context of the value '<value-of select="local-name()"/>=<value-of select="."/>' does not match the type of 'cbc:QualificationApplicationTypeCode'.</assert>
        </rule>
        
        <!-- STATUS -->
        <rule context="cac:EconomicOperatorParty/cac:EconomicOperatorRole/cbc:RoleCode">
            <let name="gc" value="document('../../../../cl/gc/EORoleType-CodeList.gc')//SimpleCodeList"/>
            <let name="currentValue" value="."/>
            
            <assert test="(not(exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue])) or (exists($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]) and ($gc/Row[Value[@ColumnRef = 'code']/SimpleValue = $currentValue]/Value[@ColumnRef = 'status']/SimpleValue = 'ACTIVE')))" 
                flag="warning" id="BR-COM-CL-RESTR-02.01">The status of the value '<value-of select="local-name()"/>=<value-of select="."/>' is deprecated, instead, use a code in this same code list with the status='ACTIVE'.</assert>
        </rule>
    </pattern>
</schema>
