Attribute VB_Name = "Module_Clearcontents_Response"
Sub xml_path_fullcode_clearcontents_response()

'Dim variables
Dim s_current As Worksheet
Dim s_type, c_tag As String
Dim c, c_max, c_insert, c_request, c_resstruc, c_rescont, c_rescont2, c_rescont3, c_prop, c_occ, c_code, c_desc, c_bve, c_nr, c_nr2, c_nr3, c_rq As Integer
Dim r, r2, r_insert, r_max, r_nr, r_nr2, r_nr3, r_nr4, r_rq As Integer
Dim lvl_max, lvl_current, lvl_master, lvl_above, lvl_end As Integer
Dim lvl(), lvl_row(), lvl_col() As Integer
Dim ca(), qg(), qsg(), q(), l(), rg(), rsg(), rq(), sbc(), adl() As Integer
Dim rq_pos_path, rq_len_path, rq_occ_path As Integer
Dim request, response, resstruc, restcont As String
Dim rnd_list, rq_uuid, rq_lot As String
Dim rq_list() As String
Dim rq_occ, rnd_num, rnd_max, rnd_min As Integer
Dim rq_check As Boolean

Dim nb_max As Integer
nb_max = 1000

'Sheet selection part 1
Application.ScreenUpdating = False

'For Each s_current In Worksheets

'sheets number
Dim s_max As Integer
s_max = Sheets.Count

'For each sheet
Dim s_nr As Integer
For s_nr = 1 To s_max
Sheets(s_nr).Activate

'Column selection
c_max = 0
c_request = 0
c_resstruc = 0
c_rescont = 0
c_rescont2 = 0
c_rescont3 = 0
r_insert = 0
c_occ = 0
c_code = 0
c_prop = 0
c_desc = 0
c_bve = 0

For r = 1 To nb_max
    For c = 1 To nb_max
        If InStr(1, Cells(r, c), "Name", 1) > 0 Then
            c_max = c - 1
        ElseIf InStr(1, Cells(r, c), "ElementUUID", 1) > 0 Then
            c_insert = c
            c_request = c - 1
            c_resstruc = c + 1
            c_rescont = c + 2
            c_rescont2 = c + 3
            c_rescont3 = c + 4
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
            c_bve = c
        End If
    If c_max <> 0 And c_request <> 0 And c_occ <> 0 And c_code <> 0 And c_prop <> 0 And c_desc <> 0 And c_bve <> 0 Then
        Exit For
    End If
    Next c
If c_max <> 0 And c_request <> 0 And c_occ <> 0 And c_code <> 0 And c_prop <> 0 And c_desc <> 0 And c_bve <> 0 Then
    Exit For
End If
Next r

'Row selection
For r = 1 To nb_max
    r2 = r + 1
    
    For c = 1 To c_max
        If InStr(1, Cells(r, c), "CRITERION}", 1) > 0 And InStr(1, Cells(r2, c), "{CRITERION", 1) = 0 Then
            r_max = r
        Exit For
        End If
    Next c
Next r

'Sheet type
If InStr(1, ActiveSheet.Name, "EG", 1) > 0 Then
    s_type = "EG"
ElseIf InStr(1, ActiveSheet.Name, "SC", 1) > 0 Then
    s_type = "SC"
ElseIf InStr(1, ActiveSheet.Name, "OTHER", 1) > 0 Then
    s_type = "OT"
End If

'New column insertion for IDs
If InStr(1, Cells(r_insert, c_request).Value, "XML PATH Like VARIANT ID Request", 1) = 0 Then
    Columns(c_request).Select
    Selection.Insert
    Cells(r_insert, c_request).Value = "XML PATH Like VARIANT ID Request"
    c_code = c_code + 1
End If
If InStr(1, Cells(r_insert, c_resstruc).Value, "XML PATH LIKE VARIANT ID Response Structure", 1) = 0 Then
    Columns(c_resstruc).Select
    Selection.Insert
    Cells(r_insert, c_resstruc).Value = "XML PATH LIKE VARIANT ID Response Structure"
    c_code = c_code + 1
End If
If InStr(1, Cells(r_insert, c_rescont).Value, "XML PATH LIKE VARIANT ID Response Contents (1)", 1) = 0 Then
    Columns(c_rescont).Select
    Selection.Insert
    Cells(r_insert, c_rescont).Value = "XML PATH LIKE VARIANT ID Response Contents (1)"
    c_code = c_code + 1
End If
If InStr(1, Cells(r_insert, c_rescont2).Value, "XML PATH LIKE VARIANT ID Response Contents (2)", 1) = 0 Then
    Columns(c_rescont2).Select
    Selection.Insert
    Cells(r_insert, c_rescont2).Value = "XML PATH LIKE VARIANT ID Response Contents (2)"
    c_code = c_code + 1
End If
If InStr(1, Cells(r_insert, c_rescont3).Value, "XML PATH LIKE VARIANT ID Response Contents (3)", 1) = 0 Then
    Columns(c_rescont3).Select
    Selection.Insert
    Cells(r_insert, c_rescont3).Value = "XML PATH LIKE VARIANT ID Response Contents (3)"
    c_code = c_code + 1
End If

'Level setup
lvl_max = r_max

ReDim lvl(1 To lvl_max), lvl_row(1 To lvl_max), lvl_col(1 To lvl_max) As Integer
ReDim ca(1 To lvl_max), qg(1 To lvl_max), qsg(1 To lvl_max), q(1 To lvl_max), l(1 To lvl_max), rg(1 To lvl_max), rsg(1 To lvl_max), rq(1 To lvl_max), sbc(1 To lvl_max), adl(1 To lvl_max) As Integer

'Start procedure - tags filled line by line
For r_nr = 1 To r_max
r_nr2 = r_nr - 1
r_nr3 = r_nr + 1
r_nr4 = r_nr + 2
    For c_nr = 1 To c_max
    c_nr2 = c_nr - 1
    c_nr3 = c_nr + 1
    
    'Level start - opening element found - new level found
    If InStr(1, Cells(r_nr, c_nr), "{", 1) > 0 Then
        For lvl_current = 1 To lvl_max
        If lvl(lvl_current) = 0 Then
            lvl(lvl_current) = 1
            lvl_row(lvl_current) = r_nr
            lvl_col(lvl_current) = c_nr2
            Exit For
        End If
        Next lvl_current
        
        'Identifier - lvl_current obtained previously
        If InStr(1, Cells(r_nr, c_nr), "{CRITERION", 1) > 0 Then
            c_tag = Cells(r_nr, c_nr2).Value
            If InStr(1, c_tag, "C", 1) > 0 Then
                Cells(r_nr, c_nr2).Value = Right(c_tag, Len(c_tag) - 1)
            End If
        ElseIf InStr(1, Cells(r_nr, c_nr), "{CAPTION", 1) > 0 Then
            ca(lvl_current) = ca(lvl_current) + 1
            Cells(r_nr, c_nr2).Value = ""
            
        ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION_GROUP", 1) > 0 Then
            'qg(lvl_current) = qg(lvl_current) + 1
            If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
                If qg(lvl_current) = 0 Then
                    qg(lvl_current) = 1
                End If
            Else
                qg(lvl_current) = qg(lvl_current) + 1
            End If
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION_SUBGROUP", 1) > 0 Then
            'qsg(lvl_current) = qsg(lvl_current) + 1
            If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
                If qsg(lvl_current) = 0 Then
                    qsg(lvl_current) = 1
                End If
            Else
                qsg(lvl_current) = qsg(lvl_current) + 1
            End If
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION", 1) > 0 Then
            'q(lvl_current) = q(lvl_current) + 1
            If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
                If q(lvl_current) = 0 Then
                    q(lvl_current) = 1
                End If
            Else
                q(lvl_current) = q(lvl_current) + 1
            End If
            Cells(r_nr, c_nr2).Value = ""
            
        ElseIf InStr(1, Cells(r_nr, c_nr), "{LEGISLATION", 1) > 0 Then
            l(lvl_current) = l(lvl_current) + 1
            Cells(r_nr, c_nr2).Value = ""
            
        ElseIf InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_GROUP", 1) > 0 Then
            If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
                If rg(lvl_current) = 0 Then
                    rg(lvl_current) = 1
                End If
            Else
                rg(lvl_current) = rg(lvl_current) + 1
            End If
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_SUBGROUP", 1) > 0 Then
            If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
                If rsg(lvl_current) = 0 Then
                    rsg(lvl_current) = 1
                End If
            Else
                rsg(lvl_current) = rsg(lvl_current) + 1
            End If
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT", 1) > 0 Then
            If InStr(1, Cells(r_nr, c_occ), "(", 1) > 0 Then
                If rq(lvl_current) = 0 Then
                    rq(lvl_current) = 1
                End If
            Else
                rq(lvl_current) = rq(lvl_current) + 1
            End If
            Cells(r_nr, c_nr2).Value = ""
            
        ElseIf InStr(1, Cells(r_nr, c_nr), "{SUBCRITERION", 1) > 0 Then
            sbc(lvl_current) = sbc(lvl_current) + 1
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{ADDITIONAL_DESCRIPTION_LINE", 1) > 0 Then
            adl(lvl_current) = adl(lvl_current) + 1
            Cells(r_nr, c_nr2).Value = ""
        End If
        
        'Coloring
        Cells(r_nr, c_nr2).Select
        Selection.Font.Bold = True
        With Selection.Font
            .Color = -11489280
            .TintAndShade = 0
        End With
        
        'XML path
        If InStr(1, Cells(r_nr, c_nr), "{CRITERION", 1) > 0 Then
           'Cells(r_nr, c_request).Value = Cells(r_nr, c_nr2).Value & "_" & s_type & "_" & Cells(r_nr, c_code).Value
            Cells(r_nr, c_request).Value = ""
        Else
            For lvl_master = 1 To lvl_current
                If lvl_master = 1 Then
                    Cells(r_nr, c_request).Value = ""
                Else
                    Cells(r_nr, c_request).Value = ""
                End If
            Next lvl_master
        End If
        
        'XML path with occurences - Warning : "REQUIREMENT" is part of the strings "REQUIREMENT_GROUP" and "REQUIREMENT_SUBGROUP".
        If InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT", 1) > 0 And InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_SUBGROUP", 1) = 0 And InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_GROUP", 1) = 0 Then
            
            For lvl_above = 1 To lvl_current
                If InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) > 0 Then
                    rq_pos_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) + 1
                    rq_len_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), ")", 1) - InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) - 1
                    rq_occ_path = Mid(Cells(lvl_row(lvl_above), c_occ).Value, rq_pos_path, rq_len_path)
                    Cells(r_nr, c_request).Value = ""
                ElseIf InStr(1, Cells(lvl_row(lvl_above), c_occ), "1..n", 1) > 0 Or InStr(1, Cells(lvl_row(lvl_above), c_occ), "0..n", 1) > 0 Then
                    'element cardinality is 1..n or 0..n , and single occurrence is not explicit
                    Cells(r_nr, c_request).Value = ""
                ElseIf lvl_above = lvl_current Then
                    'current element RQ or Q when the cardinality is 1 or 0..1
                    Cells(r_nr, c_request).Value = ""
                End If
            Next lvl_above
            
        End If
        
        'Element ID VARIANT Response Structure
        Cells(r_nr, c_resstruc).Value = ""
        
        'Element ID VARIANT Response Contents
        If InStr(1, Cells(r_nr, c_nr), "{QUESTION", 1) > 0 And InStr(1, Cells(r_nr, c_nr), "{QUESTION_SUBGROUP", 1) = 0 And InStr(1, Cells(r_nr, c_nr), "{QUESTION_GROUP", 1) = 0 Then
            response = Cells(r_nr, c_request).Value
            resstruc = Cells(r_nr, c_resstruc).Value
            
            For lvl_above = 1 To lvl_current
                If InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) > 0 Then
                    rq_pos_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) + 1
                    rq_len_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), ")", 1) - InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) - 1
                    rq_occ_path = Mid(Cells(lvl_row(lvl_above), c_occ).Value, rq_pos_path, rq_len_path)
                    response = response & "/R" & rq_occ_path
                ElseIf InStr(1, Cells(lvl_row(lvl_above), c_occ), "1..n", 1) > 0 Or InStr(1, Cells(lvl_row(lvl_above), c_occ), "0..n", 1) > 0 Then
                    'element cardinality is 1..n or 0..n , and single occurrence is not explicit
                    response = response & "/R1"
                ElseIf lvl_above = lvl_current Then
                    'current element Q when the cardinality is 1 or 0..1
                     response = response & "/R1"
                End If
            Next lvl_above
            
            If InStr(1, Cells(r_nr, c_prop), "PERIOD", 1) > 0 Then
                rescont = response & "/RAP"
            ElseIf InStr(1, Cells(r_nr, c_prop), "EVIDENCE_IDENTIFIER", 1) > 0 Then
                rescont = response & "/RES"
            Else
                rescont = response & "/RV"
            End If
            
            'Cells(r_nr, c_rescont) = "1) " & response & " 2) " & resstruc & " 3) " & rescont
            Cells(r_nr, c_rescont) = ""
            Cells(r_nr, c_rescont2) = ""
            Cells(r_nr, c_rescont3) = ""
        End If
    End If
    

    'Level end - closing element found
    If InStr(1, Cells(r_nr, c_nr), "}", 1) > 0 Then
        
    'opening and closing of a given element can be on different lines and we can also have a sequence of closing elements. So, it is best to compute lvl_end.
    'At this point, "lvl_current" is the level_end, if we also found a closing element at the same line.
    For lvl_current = 1 To lvl_max
        If lvl(lvl_current) = 0 Then
            lvl_end = lvl_current - 1
            Exit For
        End If
        Next lvl_current
        
        lvl(lvl_end) = 0

        'At this point, lvl_current = lvl_end+1.
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
    
    Next c_nr
Next r_nr

'Sheet selection part 2
Range("A1").Select
Next s_nr

'Next s_current

'End for each sheet

Sheets(1).Activate
Application.ScreenUpdating = True
End Sub


