# Release Notes
include::partial$attributes.adoc[]

## v3.0.1 (early 2022)

### Online documentation
Documentation updated as follow:

#### Technical Handbook

1. **Section 2.3 ESPD Request cardinalities**
   * Removed sentence _'Notice that ESPD-EDM does not change anything else from the UBL-2.3 Schema.'_ because it did not help understanding what is kept from *UBL-2.3* and what is changed.

   * **Figure 12. ESPD-EDM 'QualificationApplicationRequest', UML diagram**
     * _cac:EconomicOperatorParty_ 
       * _Component_: removed because it is not used in the *ESPD Request*.
     * _cac:ProcurementProject_
       * _Component_: replaced by _cac:ProcurementProject/cbc:Description_ in alignment with *eForms*.
     * _cac:ProcurementProjectLot_
       * _Component_: replaced by _cac:TenderingCriterion/cac:ProcurementProjectLotReference/cbc:ID_.
       * _Cardinality_: updated from _1..n_ to _0..n_.
     * _cbc:QualificationApplicationTypeCode_
       * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.
     * _cbc:WeightScoringMethodologyDescription_
       * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.
     * _cbc:WeightingType_ 
       * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.

2. *Section 2.4 Root elements*
   * *Table 5.* Class QualificationApplicationRequest, components required by the ESPD-EDM
     * _cac:ProcurementProject_
       * _Component_: replaced by _cac:ProcurementProject/cbc:Description_ in alignment with *eForms*.
       * _Type_: updated from _Associated class_ to _Text_ in alignment with *eForms*.
       * _Cardinality_: updated from _0..1_ to _1_ according to _Figure 12. ESPD-EDM 'QualificationApplicationRequest', UML diagram_.
       * _Requirement_: updated from _'This information is not required for the ESPD 3.0.0 since the information related to the procedure will come from eForms.'_ to _'This element is required in the ESPD, however it should be identical to that provided in eForms. In general the corresponding eForm should feed the corresponding ESPD with the corresponding data.'_.
     * _cac:ProcurementProjectLot_
       * _Component_: replaced by _cac:TenderingCriterion/cac:ProcurementProjectLotReference/cbc:ID_.
       * _Type_: updated from _Associated class_ to _Identifier_.
       * _Cardinality_: updated from _1..n_ to _0..n_.
    * _cbc:ProcedureCode_
       * _Cardinality_: updated from _0..1_ to _1_ according to _Figure 12. ESPD-EDM 'QualificationApplicationRequest', UML diagram_.

3. *Section 2.5 Lot Management*
   * _cac:ProcurementLotReference_
     * Element replaced by _cac:ProcurementProjectLotReference_.

4. *Section 2.6 EU and notice publications*
   * *XSD Schema* 
     * _cac:AdditionalReferenceDocument_ 
     * _Component_: replaced by _cac:AdditionalDocumentReference_.
   * *Table 6.* Reference to additional documents, expected elements
     * _cac:AdditionalDocumentReference_
       * _Path_: replaced _/QualificationApplicationRequest/cac:AdditionalReferenceDocument_ by _/QualificationApplicationRequest/cac:AdditionalDocumentReference_.
   * *Table 7.* External Reference
     * _cac:AdditionalDocumentReference_
       * _Path_: replaced _/QualificationApplicationRequest/cac:AdditionalReferenceDocument/cac:Attachment/cac:ExternalReference_ by _/QualificationApplicationRequest/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference_.

5. *Section 2.7 Contracting Body* 
   * *Table 8.* Contracting body, expected elements
     * _cac:ContractParty_ 
       * _Component_: replaced by _cac:ContractingParty_ according to _Figure 11: QualificationApplicationRequest-2.3 main elements._.

   * *Table 9.* Contracting body party, expected elements
     * _cac:PartyIdentification/cbc:Identifier_ 
       * _Requirement_: updated from _'More than one identifier can be specified. When possible use the VAT identification of the contracting body (see the VIES platform for a EU cross-border national VAT number verification system). '_ to _'When possible use the VAT identification of the contracting body (see the link:https://ec.europa.eu/taxation_customs/vies/[VIES] platform for a EU cross-border national VAT number verification system). When not possible a different identifier may be used.'_ because previous text was ambiguous.

6. *Section 2.8. Service Provider*
   * *Table 38.* Service provider, expected elements
     * _cac:PostalAddress/cac:Country/cbc:IdentificationCode_
       * _Type_: updated from _Identifier_ to _Code_.

7. *Section 3. Common aspects for criteria*
   * *Figure 33.* Criterion - UML diagram
     * Updated wrong cardinalities _1..*..*_ to _1..*_ to fix the typo. Cardinalities corrected are: _cac:TenderingCriterionPropertyGroup_, _cac:TenderingCriterionProperty_ and _cac:ProcurementProjectLotReference_.
     * _cac:EconomicOperatorParty_ 
       * _Component_: removed because it is not used in the *ESPD Request*.
     * _cac:ProcurementProject_
       * _Component_: replaced by _cac:ProcurementProject/cbc:Description_ in alignment with *eForms*.
     * _cac:ProcurementProjectLot_
       * _Component_: removed because it is replaced by _cac:TenderingCriterion/cac:ProcurementProjectLotReference_ in the same figure.
     * _cac:TenderingCriterion/cac:ProcurementProjectLotReference_
       * _Cardinality_: update from _1..n_ to _0..n_.
     * _cbc:QualificationApplicationTypeCode_
       * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.
     * _cbc:WeightScoringMethodologyDescription_
       * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.
     * _cbc:WeightingType_ 
       * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.

8. *Section 3.1 General behavior*
   * *Table 20.* Criterion, expected elements
     * _cac:ProcurementProjectLotReference_
       * _Type_: updated from _Text_ to _Class_.
       * _Cardinality_: updated from _1..n_ to _0..n_.

9. *Section 3.2 Legislation*
   * *Table 21.* Legislation, expected elements
     * _cbc:ID_
       * _Component_: added.
     * _cbc:Description_
       * _Type_: updated from _Code_ to _Text_.
     * _cbc:LegislationTitle_
       * _Component_: replaced by _cbc:Title_.

10. *Section 3.4 Properties*
    * *Table 23.* Properties, expected elements
      * _cbc:ExpectedAmount_
        * _Component_: added.
      * _cbc:ExpectedDescription
        * _Component_: added.

11. *Section 5.1 Lot Management approach for Selection Criteria*
    * Text updated from _'The buyer may specify the criteria that each selection criteria apply by using the element cac:ProcurementProjectLotReference that includes cbc:TenderingCriterion.'_ to _'The buyer may specify the criteria that each selection criteria apply by using the element cac:TenderingCriterion that includes cac:ProcurementProjectLotReference.'_.
    * _cac:ProcurementLotReference_
      * Element replaced by _cac:ProcurementProjectLotReference_.


12. *Section 6.2 ESPD Response XSD Schema*
    * _cac:ContractingAuthorityParty_ 
      * _Component_: replaced by _cac:ContractingParty_ according to _Figure 191. QualificationApplicationResponse XSD Schema, global view_.


13. *Section 6.3 ESPD Response cardinalities*
    * *Figure 193.* ESPD-EDM 'QualificationApplicationResponse', UML diagram
      * _cac:ProcurementProject_
        * _Component_: replaced by _cac:ProcurementProject/cbc:Description_ in alignment with *eForms*.
      * _cac:ProcurementProjectLot_
        * _Cardinality_: updated from _1..n_ to _1_.
      * _cbc:ProfileExecutionID_
        * _Cardinality_: updated from _0..1_ to _1_.
      * _cbc:QualificationApplicationTypeCode_
        * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.
      * _cbc:WeightScoringMethodologyDescription_
        * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.
      * _cbc:WeightingType_ 
        * _Component_: removed because it is not used in *ESPD-EDM v3.0.x*.

14. *Section 6.4 Root elements*
    * *Table 26.* Class QualificationApplicationResponse, components required by the ESPD-EDM
      * _cac:ContractingParty_ 
        * _Desciption_: updated with text _'See section xref:2.7_Contracting_Body.adoc[Contracting Body] for more specification details.'_ where this element is described.
      * _cac:EconomicOperator_
        * _Component_: replaced by _cac:EconomicOperatorParty_ according to _Figure 193. ESPD-EDM 'QualificationApplicationResponse', UML diagram._.
        * _Cardinality_: updated from _0..1_ to _1_.
      * _cac:ProcurementProject_ 
        * _Component_: replaced by _cac:ProcurementProject/cbc:Description_ in alignment with *eForms*.
        * _Type_: updated from _Associated class_ to _Text_ in alignment with *eForms*.
        * _Cardinality_: updated from _0..1_ to _1_ according to _Figure 193. ESPD-EDM 'QualificationApplicationResponse', UML diagram._. 
        * _Requirement_: updated from _'Use this component to identify and describe the procurement administrative procedure. If the procurement procedure is divided into lots use the ProcurementProjectLot component to provide details specific to the lot and reserve the ProcurementProject component to describe the global characteristics of the procedure.'_ to _'This element is required in the ESPD, however it should be identical to that provided in eForms. In general the corresponding eForm should feed the corresponding ESPD with the corresponding data.'_.
     * _cac:ProcurementProjectLot_ 
       * _Cardinality_: updated from _0..1_ to _1_ according to _Figure 193. ESPD-EDM 'QualificationApplicationResponse', UML diagram._.
       * _Description_: updated from _'One of the procurement project lots into which this contract can be divided.'_ to _'The procurement project lot or group of lots this ESPD Response tenders to.'.'
    * _cbc:EconomicOperatorGroupName_ 
      * _Type_: updated from _Code_ to _Text_.
    * _cbc:ProcedureCode_ 
      * _Cardinality_: updated from _0..1_ to _1_ according to _Figure 193. ESPD-EDM 'QualificationApplicationResponse', UML diagram._. 
      * _Type_: updated from _Identifier_ to _Code_.
    * _cbc:ProfileExecutionID_ 
      * _Component_: added.
      * _Cardinality_: added _1_.
    * _cbc:UUID_ 
      * _Cardinality_: updated from _0..1_ to _1_.

15. *Section 6.5 Reference to publications and to the ESPD Request*
    * *Table 27.* Reference to the ESPD Request, expected elements
      * _cac:AdditionalDocumentReference_
        *_Path:_ replaced _/QualificationApplicationResponse/cac:AdditionalReferenceDocument_ by _/QualificationApplicationResponse/cac:AdditionalDocumentReference_.
      * _cbc:DocumentDescription_
        * _Component_: added.
        * _Cardinality_: added _0..1_.

    * *Table 28.* External Reference
      * _cac:ExternalReference_
        *_Path:_ replaced _/QualificationApplicationResponse/cac:AdditionalReferenceDocument_ by _/QualificationApplicationResponse/cac:AdditionalDocumentReference_.

16. *Section 6.6 Economic Operator*
    * _cac:EconomicOperator_
      * _Component_: replaced by _cac:EconomicOperatorParty_ according to _Figure 193. ESPD-EDM 'QualificationApplicationResponse', UML diagram_.

    * *Table 33.* Qualifying Party, expected elements
      * _cac:Party/cac:PartyIdentifier/cbc:ID_
        * _Component_: repleaced by _cac:Party/cac:PartyIdentification/cbc:ID_.

    * *Table 34.* Economic operator role, expected elements
      * _cbc:RoleDescription_
        * _Cardinality_: updated from _0..n_ to _0..1_.

    * *Table 35.* (Qualifying) economic operator party, expected elements
      * _cac:PartyIdentification/cbc:Identifier_ 
        * _Requirement_: updated from _'More than one identifier can be specified. Compulsory use of the attribute schemeAgencyID and highly recommended the use of the attribute schemeAgencyID. The preferred identifier is the national VAT number. Additional identifiers may be used'_ to _'When possible use the VAT identification of the contracting body (see the link:https://ec.europa.eu/taxation_customs/vies/[VIES] platform for a EU cross-border national VAT number verification system). When not possible a different identifier may be used.'_ because previous text was ambiguous.

    * *Table 36.* Economic operator postal address, expected elements
      * _cac:PostalAddress_
        * _Path_: updated from _/QualificationApplicationResponse/​cac:EconomicOperator/​cac:Party/​cac:PostalAddress_ to _/QualificationApplicationResponse/​cac:EconomicOperatorParty/​cac:Party/​cac:PostalAddress_ according to _Figure 198. cac:QualifyingParty element, XSD_.

    * *Table 38.* Service provider, expected elements
      * _cac:PostalAddress/cac:Country/cbc:IdentificationCode_
        * _Type_: updated from _Identifier_ to _Code_.

17. *Section 6.8 Evidences*
    * _cac:Evidence/cac:DocumentReference/cac:IssuerParty_
      * Element replaced by _cac:Evidence/cac:DocumentReference/cac:IssuerParty/cac:Party/cac:PartyIdentification/cbc:ID_.

    * *Table 44*. Elements expected in an Evidence
      * _cbc:CandidateStatement_ 
        * _Requirement_: updated from _'None. Not currently used in ESPD.'_ to _'None. No rule is applied.'_ because previous text was misleading.

    * *Table 45.* Elements expected from the 'cac:Evidence/cac:DocumentReference' element
      * _cac:Attachment/cac:ExternalReference/cbc:URI_ 
        * _Requirement_: updated from _'None. Not currently used in ESPD.'_ to _'None. No rule is applied.'_ because previous text was misleading.
      * _cac:IssuerParty/cbc:ID_
        * _Component_: replaced by _cac:IssuerParty/cac:PartyIdentification/cbc:ID_.
      * _cac:IssuerParty/cbc:Name_
        * _Component_: replaced by _cac:IssuerParty/cac:PartyName/cbc:Name_.
      * _cac:IssuerParty/cbc:WebsiteURI_
        * _Requirement_: updated from _'None. Not currently used in ESPD.'_ to _'None. No rule is applied.'_ because previous text was misleading.
