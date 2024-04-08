Attribute VB_Name = "Module_Main_Request"
'Variables
Public s_max, s_nr As Integer
Public s_type As String
Public s_next As Boolean
Public c, c_max, c_heading, c_insert, c_request, c_resstruc, c_prop, c_occ, c_code, c_desc, c_bve, c_vex, c_comm, c_nr, c_nr2, c_nr3, c_nr4, c_rq, c_num As Integer
Public r, r2, r_heading, r_insert, r_max, r_min, r_smax, r_nr, r_nr2, r_nr3, r_nr4, r_rq, r_bve, r_rndmax, r_rndmin, r_rnd As Integer
Public lvl_max, lvl_min, lvl_current, lvl_master, lvl_above, lvl_end As Integer
Public lvl(), lvl_row(), lvl_col() As Integer
Public ca(), qg(), qsg(), q(), l(), rg(), rsg(), rq(), sbc(), adl() As Integer
Public rq_pos_path, rq_len_path, rq_occ_path As Integer
Public rqsb_min, rqsb_max, rqsb_occ, c_rqsb, r_rqsb, rqsb_nr, rqsb_min2, rqsb_max2, rqsb_add As Integer
Public rqsb_card As String
Public reqval, resstruc, restcont As String
Public rnd_list, rq_list, txt_bve, rq_uuid, rq_lot As String
Public rq_occ, rnd_pool, rq_pool, rnd_num, rnd_lmax, rnd_count, rnd_counttot, lot_max, rnd_max, rnd_min, rnd_add As Integer
Public rq_check As Boolean

'------------------------------
'Main function for Request file
'-------------------------------
Sub main_request_xml_path()

Application.ScreenUpdating = False

'Sheet selection part 1
s_max = Sheets.Count
For s_nr = 1 To s_max
Sheets(s_nr).Activate

If InStr(1, ActiveSheet.Name, "EG", 1) = 1 Or InStr(1, ActiveSheet.Name, "SC", 1) = 1 Or InStr(1, ActiveSheet.Name, "OTHER", 1) = 1 Then

'Set up (module 2)

Call variables_reset
Call column_selection
Call type_selection

'Call xmlpath_bve

Call xmlpath_crequest

Call column_number

'Procedure (module 3)
r_nr = 0
Do
    'Call randomvariable_setup
    Call row_selection
    Call lvl_setup
    'Call requirementlot_list
    Do
        Call variables_setup
        For c_nr = 1 To c_max
            c_nr2 = c_nr - 1
            c_nr3 = c_nr + 1
            c_nr4 = c_nr + 2
            Call level_start
            If InStr(1, Cells(r_nr, c_nr), "{", 1) > 0 Then
                Call tag_identifier
                Call coloring
                Call xmlpath_request
                Call xmlpath_occurence
                'Call requirementlot
            End If
            Call level_end
        Next c_nr
    Loop Until r_nr = r_max
Loop Until s_next = True

End If

'Sheet selection part 2
Range("A1").Select
Next s_nr

'End
Sheets(1).Activate
Application.ScreenUpdating = True
End Sub

Sub variables_reset()

r_smax = 1048576
r_heading = 5
c_heading = 100
c_max = 0
c_request = 0
c_resstruc = 0
r_insert = 0
c_occ = 0
c_code = 0
c_prop = 0
c_desc = 0
c_com = 0
c_num = 0
r_max = 0

End Sub

Sub column_selection()

For r = 1 To r_heading
    For c = 1 To c_heading
        If InStr(1, Cells(r, c), "Name", 1) > 0 Then
            c_max = c - 1
        ElseIf InStr(1, Cells(r, c), "ElementUUID", 1) > 0 Then
            c_insert = c
            c_request = c - 1
            c_resstruc = c + 1
            r_insert = r
        ElseIf InStr(1, Cells(r, c), "Cardinality", 1) > 0 Then
            c_occ = c
        ElseIf InStr(1, Cells(r, c), "Element Code", 1) > 0 Then
            c_code = c
        ElseIf InStr(1, Cells(r, c), "PropertyDataType", 1) > 0 Then
            c_prop = c
        ElseIf InStr(1, Cells(r, c), "Description", 1) > 0 Then
            c_desc = c
        ElseIf InStr(1, Cells(r, c), "Buyer Value (example)", 1) > 0 Then
            c_vex = c
            c_bve = c 
        ElseIf InStr(1, Cells(r, c), "Comment", 1) > 0 Then
            c_comm = c
        End If
    If c_max <> 0 And c_request <> 0 And c_occ <> 0 And c_code <> 0 And c_prop <> 0 And c_desc <> 0 And c_bve <> 0 And c_com <> 0 Then
        Exit For
    End If
    Next c
If c_max <> 0 And c_request <> 0 And c_occ <> 0 And c_code <> 0 And c_prop <> 0 And c_desc <> 0 And c_bve <> 0 And c_com <> 0 Then
    Exit For
End If
Next r

End Sub

Sub type_selection()

If InStr(1, ActiveSheet.Name, "EG", 1) = 1 Then
    s_type = "EG"
ElseIf InStr(1, ActiveSheet.Name, "SC", 1) = 1 Then
    s_type = "SC"
ElseIf InStr(1, ActiveSheet.Name, "OTHER", 1) = 1 Then
    s_type = "OT"
End If

End Sub

Sub xmlpath_crequest()

If InStr(1, Cells(r_insert, c_request).Value, "XML PATH Like VARIANT ID Request", 1) = 0 Then
    Columns(c_insert).Select
    Selection.Insert
    Cells(r_insert, c_insert).Value = "XML PATH Like VARIANT ID Request"
    c_code = c_code + 1
    c_request = c_insert
    c_insert = c_insert + 1
    c_resstruc = c_resstruc + 1
End If

End Sub

Sub xmlpath_bve()

If InStr(1, Cells(r_insert, c_bve).Value, "Buyer Value (example)", 1) = 0 Then
    Columns(c_vex).Select
    Selection.Insert
    Cells(r_insert, c_vex).Value = "Buyer Value (example)"
    c_code = c_code + 1
    c_bve = c_vex
    'c_vex = c_vex + 1
    c_occ = c_occ + 1
    c_insert = c_insert + 1
    c_request = c_request + 1
    c_resstruc = c_resstruc + 1
    c_prop = c_prop + 1
    End If
    
End Sub

Sub column_number()
r = 1
For c = 1 To c_comm
    c_num = c_num + 1
    Cells(r, c).Value = c_num
Next c
End Sub

Sub row_selection()

r_min = r_max + 1
For r = r_min To r_smax
    r2 = r + 1
    For c = 1 To c_max
        If InStr(1, Cells(r, c), "CRITERION}", 1) > 0 And InStr(1, Cells(r, c), "SUBCRITERION", 1) = 0 Then
            r_max = r
            If InStr(1, Cells(r2, c), "{CRITERION", 1) > 0 Then
                s_next = False
            Else
                s_next = True
            End If
        End If
    If r_max > r_min Then
        Exit For
    End If
    Next c
If r_max > r_min Then
    Exit For
End If
Next r

End Sub

Sub lvl_setup()

lvl_min = 1
lvl_max = r_smax
ReDim lvl(lvl_min To lvl_max), lvl_row(lvl_min To lvl_max), lvl_col(lvl_min To lvl_max) As Integer
ReDim ca(lvl_min To lvl_max), qg(lvl_min To lvl_max), qsg(lvl_min To lvl_max), q(lvl_min To lvl_max), l(lvl_min To lvl_max), rg(lvl_min To lvl_max), rsg(lvl_min To lvl_max), rq(lvl_min To lvl_max), sbc(lvl_min To lvl_max), adl(lvl_min To lvl_max) As Integer

End Sub

Sub variables_setup()

r_rndmax = 3
r_rndmin = 1
r_nr = r_nr + 1
r_nr2 = r_nr - 1
r_nr3 = r_nr + 1
r_rnd = Int((r_rndmax - r_rndmin + 1) * Rnd + r_rndmin)
r_nr4 = r_nr + r_rnd

End Sub

Sub level_start()

    If InStr(1, Cells(r_nr, c_nr), "{", 1) > 0 Then
        For lvl_current = 1 To lvl_max
        If lvl(lvl_current) = 0 Then
            lvl(lvl_current) = 1
            lvl_row(lvl_current) = r_nr
            lvl_col(lvl_current) = c_nr2
            Exit For
        End If
        Next lvl_current
    End If
    
End Sub

Sub tag_identifier()

If InStr(1, Cells(r_nr, c_nr), "{CRITERION", 1) > 0 Then
    c = Cells(r_nr, c_nr2).Value
    If InStr(1, c, "C", 1) = 0 Then
        Cells(r_nr, c_nr2).Value = "C" & c
    End If
ElseIf InStr(1, Cells(r_nr, c_nr), "{CAPTION", 1) > 0 Then
    ca(lvl_current) = ca(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "CA" & ca(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION_GROUP", 1) > 0 Then
    qg(lvl_current) = qg(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "QG" & qg(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION_SUBGROUP", 1) > 0 Then
    qsg(lvl_current) = qsg(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "QSG" & qsg(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION", 1) > 0 Then
    q(lvl_current) = q(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "Q" & q(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{LEGISLATION", 1) > 0 Then
    l(lvl_current) = l(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "L" & l(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_GROUP", 1) > 0 Then
    If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
        If rg(lvl_current) = 0 Then
            rg(lvl_current) = 1
        End If
    Else
        rg(lvl_current) = rg(lvl_current) + 1
    End If
    Cells(r_nr, c_nr2).Value = "RG" & rg(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_SUBGROUP", 1) > 0 Then
    If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
        If rsg(lvl_current) = 0 Then
            rsg(lvl_current) = 1
        End If
    Else
        rsg(lvl_current) = rsg(lvl_current) + 1
    End If
    Cells(r_nr, c_nr2).Value = "RSG" & rsg(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT", 1) > 0 Then
    If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
        If rq(lvl_current) = 0 Then
            rq(lvl_current) = 1
        End If
    Else
        rq(lvl_current) = rq(lvl_current) + 1
    End If
    Cells(r_nr, c_nr2).Value = "RQ" & rq(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{SUBCRITERION", 1) > 0 Then
    sbc(lvl_current) = sbc(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "SBC" & sbc(lvl_current)
ElseIf InStr(1, Cells(r_nr, c_nr), "{ADDITIONAL_DESCRIPTION_LINE", 1) > 0 Then
    adl(lvl_current) = adl(lvl_current) + 1
    Cells(r_nr, c_nr2).Value = "ADL" & adl(lvl_current)
End If
        
End Sub

Sub coloring()

Cells(r_nr, c_nr2).Select
Selection.Font.Bold = True
With Selection.Font
    .Color = -11489280
    .TintAndShade = 0
End With

End Sub

Sub xmlpath_request()

If InStr(1, Cells(r_nr, c_nr), "{CRITERION", 1) > 0 Then
    Cells(r_nr, c_request).Value = Cells(r_nr, c_nr2).Value & "_" & s_type & "_" & Cells(r_nr, c_code).Value
Else
    For lvl_master = 1 To lvl_current
        If lvl_master = 1 Then
            Cells(r_nr, c_request).Value = Cells(lvl_row(lvl_master), c_request).Value
        Else
            Cells(r_nr, c_request).Value = Cells(r_nr, c_request).Value & "/" & Cells(lvl_row(lvl_master), lvl_col(lvl_master)).Value
        End If
    Next lvl_master
End If
        
End Sub

Sub xmlpath_occurence()

    If InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT", 1) > 0 And InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_GROUP", 1) = 0 And InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_SUBGROUP", 1) = 0 Then
            
        For lvl_above = 1 To lvl_current
            If InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) > 0 Then
                rq_pos_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) + 1
                rq_len_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), ")", 1) - InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) - 1
                rq_occ_path = Mid(Cells(lvl_row(lvl_above), c_occ).Value, rq_pos_path, rq_len_path)
                Cells(r_nr, c_request).Value = Cells(r_nr, c_request).Value & "/R" & rq_occ_path
            ElseIf InStr(1, Cells(lvl_row(lvl_above), c_occ), "1..n", 1) > 0 Or InStr(1, Cells(lvl_row(lvl_above), c_occ), "0..n", 1) > 0 Then
                'element cardinality is 1..n or 0..n , and single occurrence is not explicit
                Cells(r_nr, c_request).Value = Cells(r_nr, c_request).Value & "/R1"
            ElseIf lvl_above = lvl_current Then
                'current element RQ or Q when the cardinality is 1 or 0..1 - this layer can be deleted but can lead to some confusion in the mapping of the R(s) in the path with its corresponding elt
                Cells(r_nr, c_request).Value = Cells(r_nr, c_request).Value & "/R1"
            End If
        Next lvl_above
            
    End If
        
End Sub

Sub level_end()

If InStr(1, Cells(r_nr, c_nr), "}", 1) > 0 Then
    For lvl_current = 1 To lvl_max
    If lvl(lvl_current) = 0 Then
        lvl_end = lvl_current - 1
        Exit For
    End If
Next lvl_current
        
lvl(lvl_end) = 0
ca(lvl_current) = 0
qg(lvl_current) = 0
qsg(lvl_current) = 0
q(lvl_current) = 0
l(lvl_current) = 0
rg(lvl_current) = 0
rsg(lvl_current) = 0
rq(lvl_current) = 0
sbc(lvl_current) = 0
adl(lvl_current) = 0

End If

End Sub

Sub randomvariable_setup()

lot_max = 9999
rnd_max = 9
rnd_min = 0
rnd_add = 0
rnd_lmax = 0
rnd_count = 0
rnd_counttot = 0
rnd_list = ""

For rnd_num = rnd_min To rnd_max
    rnd_add = rnd_add + 1
Next rnd_num
For rnd_num = rnd_min To lot_max
    rnd_lmax = rnd_lmax + 1
Next rnd_num
rnd_pool = Int(rnd_lmax / rnd_add) + 1

End Sub

Sub requirementlot_list()

rnd_list = ""
rnd_count = 0
rnd_counttot = 0
For r_bve = r_min To r_max
    If InStr(1, Cells(r_bve, c_bve).Value, "LOT-", 1) > 0 Then
        txt_bve = Cells(r_bve, c_bve).Value
        txt_bve = WorksheetFunction.Trim(txt_bve)
        Cells(r_bve, c_bve).Value = txt_bve
        rnd_list = rnd_list & ", " & Cells(r_bve, c_bve).Value
        rnd_counttot = rnd_counttot + 1
    End If
Next r_bve

End Sub

Sub requirement_pool()

For rq_pool = 1 To rnd_pool
    For rnd_num = rnd_min To rnd_max
        rq_lot = "LOT-0000"
        len_lot = Len(rq_lot) - Len(rnd_num)
        rq_lot = Left(rq_lot, len_lot) & rnd_num
        If InStr(1, rnd_list, rq_lot, 1) > 0 Then
            rnd_count = rnd_count + 1
        End If
    Next rnd_num
    If rnd_count < rnd_add Then
        Exit For
    Else
        rnd_min = rnd_min + rnd_add
        rnd_max = rnd_max + rnd_add
        rnd_count = 0
    End If
Next rq_pool

End Sub

Sub requirementlot()

If InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_GROUP", 1) > 0 And s_type = "SC" And rnd_counttot <= rnd_lmax Then
    rq_occ = 1
    For r_rq = r_nr3 To r_nr4
        
    If rnd_counttot < rnd_lmax Then
        If rnd_count = 0 Then
            Call requirement_pool
        ElseIf rnd_count = rnd_add Then
            rnd_max = rnd_max + rnd_add
            rnd_min = rnd_min + rnd_add
            rnd_count = 0
            Call requirement_pool
        End If
    ElseIf rnd_counttot = rnd_lmax Then
        rnd_counttot = rnd_counttot + 1
        MsgBox ("You have too many LOT for that criterion. You cannot add more.")
        Exit For
    Else
        Exit For
    End If
                'Checking if a lign has to be added
                For c_rq = 1 To c_max
                    If InStr(1, Cells(r_rq, c_rq), "{REQUIREMENT}", 1) > 0 And InStr(1, Cells(r_rq, c_desc), "LOT Identifier", 1) > 0 Then
                        rq_list = "Yes"
                        Exit For
                    Else
                        rq_list = "No"
                    End If
                Next c_rq
                
                If rq_list = "No" Then
                    Rows(r_rq).Select
                    Selection.Insert
                    r_max = r_max + 1
                End If
                
                'Buyer Value Example (random)
                If InStr(1, Cells(r_rq, c_bve).Value, "LOT-", 1) = 0 Or Len(Cells(r_rq, c_bve).Value) <> 8 Then
                    rq_lot = "LOT-0000"
                    rq_check = False
                        Do
                            rnd_num = Int((rnd_max - rnd_min + 1) * Rnd + rnd_min)
                            rq_lot = Left(rq_lot, Len(rq_lot) - Len(rnd_num)) & rnd_num
                            If InStr(1, rnd_list, rq_lot, 1) = 0 Then
                                rq_check = True
                            Else
                                rq_check = False
                            End If
                        Loop Until rq_check = True
                    rnd_list = rnd_list & ", " & rq_lot
                    Cells(r_rq, c_bve).Value = rq_lot
                    rnd_count = rnd_count + 1
                    rnd_counttot = rnd_counttot + 1
                End If
                    
                Cells(r_rq, c_nr3).Value = "{REQUIREMENT}"
                   
                'Description
                Cells(r_rq, c_desc).Value = "LOT Identifier"
                       
                'Cardinality
                Cells(r_rq, c_occ).Value = "1..n (" & rq_occ & ")"
                
                'UUID
                rq_uuid = "UUID"
                For lvl_above = 1 To lvl_current
                    If InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) > 0 Then
                        rq_pos_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) + 1
                        rq_len_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), ")", 1) - InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) - 1
                        rq_occ_path = Mid(Cells(lvl_row(lvl_above), c_occ).Value, rq_pos_path, rq_len_path)
                        rq_uuid = rq_uuid & "/R" & rq_occ_path
                    ElseIf InStr(1, Cells(lvl_row(lvl_above), c_occ), "1..n", 1) > 0 Or InStr(1, Cells(lvl_row(lvl_above), c_occ), "0..n", 1) > 0 Then
                        'element cardinality is 1..n or 0..n , and single occurrence is not explicit
                        rq_uuid = rq_uuid & "/R1"
                    End If
                Next lvl_above
                rq_uuid = rq_uuid & "/R" & rq_occ
                Cells(r_rq, c_insert).Value = rq_uuid
                rq_occ = rq_occ + 1
    
                rq_list = ""
            Next r_rq
Call requirementsubgroup
End If

End Sub

Sub requirementsubgroup()

rqsb_max = 0
rqsb_min = r_nr4 + 1
If Cells(rqsb_min, c_nr3).Value <> "{REQUIREMENT_SUBGROUP" Then
    Rows(rqsb_min).Select
        Selection.Insert
        r_max = r_max + 1
    Cells(rqsb_min, c_nr3).Value = "{REQUIREMENT_SUBGROUP"
    rqsb_occ = InStr(1, Cells(r_nr4, c_occ), "(", 1) - 1
    rqsb_card = Left(Cells(r_nr4, c_occ), rqsb_occ)
    Cells(rqsb_min, c_occ).Value = rqsb_card & "(1)"
    
    For r_rqsb = rqsb_min To r_max
        For c_rqsb = 1 To c_max
        If InStr(1, Cells(r_rqsb, c_rqsb), "REQUIREMENT_GROUP}", 1) > 0 Then
            rqsb_max = r_rqsb
        End If
        If rqsb_max <> 0 Then
            Exit For
        End If
        Next c_rqsb
    If rqsb_max <> 0 Then
        Exit For
    End If
    Next r_rqsb
    Rows(rqsb_max).Select
        Selection.Insert
        r_max = r_max + 1
    Cells(rqsb_max, c_nr3).Value = "REQUIREMENT_SUBGROUP}"
        
    Range(Cells(rqsb_min + 1, c_nr3), Cells(rqsb_max - 1, c_max)).Select
    Selection.Cut
    Cells(rqsb_min + 1, c_nr4).Select
    ActiveSheet.Paste
    
    rqsb_add = rqsb_max - rqsb_min + 1
    If r_rnd > 1 Then
        For rqsb_nr = 2 To r_rnd
            rqsb_min2 = rqsb_max + 1
            rqsb_max2 = rqsb_min2 + rqsb_add
            
            Rows(rqsb_min2).Select
            Selection.EntireRow.Resize(rqsb_add).Insert
            r_max = r_max + rqsb_add
            
            Range(Cells(rqsb_min, c_nr3), Cells(rqsb_max, c_prop)).Select
            Selection.Copy
            Cells(rqsb_min2, c_nr3).Select
            ActiveSheet.Paste
            
            rqsb_card = Left(Cells(rqsb_min2, c_occ), rqsb_occ)
            Cells(rqsb_min2, c_occ).Value = rqsb_card & "(" & rqsb_nr & ")"
            
            rqsb_min = rqsb_min2
            rqsb_max = rqsb_max2 - 1
        Next rqsb_nr
    End If
        
End If

End Sub


