<?xml version="1.0" encoding="UTF-8"?>
<!--
  File: 04-ESPD-req-other-br.sch
  Scope: ESPD Request only
  Version: 5.0.0
  Maintenance: Manual
  Dependencies: None
  Rules: BR-ESPD-DOCREF-01
  Description: ESPD Request-specific other business rules.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>ESPD Request Other Business Rules</title>
  
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
	<ns prefix="espd" uri="urn:oasis:names:specification:ubl:schema:xsd:QualificationApplicationRequest-2"/>
	
<!--
    Start of synthesis of rules from other constraints ESPD Request

    Illustration of procurer constraints - 04-ESPD-req-other-br.sch
	ESPD Version: 5.0.0
-->

	<pattern id="espd-req-docref-content-type">
		<!--
			BR-ESPD-DOCREF-01
			The DocRefContentType code list (an EU-wide vocabulary) contains the
			values 'ESPD_REQUEST' and 'epo-acc-espd-request', which designate the
			ESPD Request document itself. An AdditionalDocumentReference inside an
			ESPD Request points at the *published* notice that launched the
			procedure (e.g. TED_CN, a national/regional journal reference), never
			at the ESPD Request. These two codes are therefore not valid content
			types for a publication reference and are rejected here, even though
			the generic code-list-values binding (01-ESPD-codelist-values) accepts
			the full vocabulary.
		-->
		<rule context="cac:AdditionalDocumentReference/cbc:DocumentTypeCode">
			<assert id="BR-ESPD-DOCREF-01" flag="fatal"
				test="not(normalize-space(.) = 'ESPD_REQUEST') and not(normalize-space(.) = 'epo-acc-espd-request')"
				>[BR-ESPD-DOCREF-01] Invalid publication-reference type: '<value-of select="."/>'. The codes 'ESPD_REQUEST' and 'epo-acc-espd-request' denote the ESPD Request document itself and must not be used as the content type of a publication reference (cac:AdditionalDocumentReference/cbc:DocumentTypeCode).</assert>
		</rule>
	</pattern>

</schema>
