Attribute VB_Name = "Module_Clearcontents_Request"
Sub xml_path_fullcode_clearcontents_request()

'Dim variables
Dim s_current As Worksheet
Dim s_type, c_tag As String
Dim c, c_max, c_insert, r_insert, c_insert2, c_occ, c_code, c_nr, c_nr2 As Integer
Dim r, r2, r_max, r_nr, r_nr2 As Integer
Dim lvl_max, lvl_current, lvl_master, lvl_above, lvl_end As Integer
Dim lvl(), lvl_row(), lvl_col() As Integer
Dim ca(), qg(), qsg(), q(), l(), rg(), rsg(), rq(), sbc(), adl() As Integer
Dim rq_pos_path, rq_len_path, rq_occ_path As Integer

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
c_insert = 0
r_insert = 0
'previous column
c_insert2 = 0
c_occ = 0
For r = 1 To nb_max
    For c = 1 To nb_max
        If Cells(r, c) = "Name" Then
            c_max = c - 1
        ElseIf Cells(r, c) = "ElementUUID" Then
            c_insert = c
            r_insert = r
            c_insert2 = c - 1
        ElseIf Cells(r, c) = "Cardinality" Then
            c_occ = c
        ElseIf Cells(r, c) = "Element Code" Then
            c_code = c
        End If
    If c_max <> 0 And c_insert <> 0 And c_occ <> 0 And c_code <> 0 Then
        Exit For
    End If
    Next c
If c_max <> 0 And c_insert <> 0 And c_occ <> 0 And c_code <> 0 Then
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
If Cells(r_insert, c_insert2).Value <> "XML PATH Like VARIANT ID Request" Then
    Columns(c_insert).Select
    Selection.Insert
    Cells(r_insert, c_insert).Value = "XML PATH Like VARIANT ID Request"
Else
    c_insert = c_insert2
    c_insert2 = c_insert - 1
End If

'Level setup
lvl_max = r_max

ReDim lvl(1 To lvl_max), lvl_row(1 To lvl_max), lvl_col(1 To lvl_max) As Integer
ReDim ca(1 To lvl_max), qg(1 To lvl_max), qsg(1 To lvl_max), q(1 To lvl_max), l(1 To lvl_max), rg(1 To lvl_max), rsg(1 To lvl_max), rq(1 To lvl_max), sbc(1 To lvl_max), adl(1 To lvl_max) As Integer

'Start procedure - tags filled line by line
For r_nr = 1 To r_max
r_nr2 = r_nr - 1
    For c_nr = 1 To c_max
    c_nr2 = c_nr - 1
    
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
            qg(lvl_current) = qg(lvl_current) + 1
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION_SUBGROUP", 1) > 0 Then
            qsg(lvl_current) = qsg(lvl_current) + 1
            Cells(r_nr, c_nr2).Value = ""
        ElseIf InStr(1, Cells(r_nr, c_nr), "{QUESTION", 1) > 0 Then
            q(lvl_current) = q(lvl_current) + 1
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
            Cells(r_nr, c_insert).Value = ""
        Else
            For lvl_master = 1 To lvl_current
                If lvl_master = 1 Then
                    Cells(r_nr, c_insert).Value = ""
                Else
                    Cells(r_nr, c_insert).Value = ""
                End If
            Next lvl_master
        End If
        
        'XML path with occurences - Warning : "REQUIREMENT" is part of the strings "REQUIREMENT_GROUP" and "REQUIREMENT_SUBGROUP".
        If InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT", 1) > 0 And InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_GROUP", 1) = 0 And InStr(1, Cells(r_nr, c_nr), "{REQUIREMENT_SUBGROUP", 1) = 0 Then
            For lvl_above = 1 To lvl_current
            If InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) > 0 Then
                rq_pos_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) + 1
                rq_len_path = InStr(1, Cells(lvl_row(lvl_above), c_occ), ")", 1) - InStr(1, Cells(lvl_row(lvl_above), c_occ), "(", 1) - 1
                rq_occ_path = Mid(Cells(lvl_row(lvl_above), c_occ).Value, rq_pos_path, rq_len_path)
                Cells(r_nr, c_insert).Value = ""
                ElseIf InStr(1, Cells(lvl_row(lvl_above), c_occ), "1..n", 1) > 0 Or InStr(1, Cells(lvl_row(lvl_above), c_occ), "0..n", 1) > 0 Then
                    'element cardinality is 1..n or 0..n , and single occurrence is not explicit
                    Cells(r_nr, c_insert).Value = ""
                ElseIf lvl_above = lvl_current Then
                    'current element RQ or Q when the cardinality is 1 or 0..1
                    Cells(r_nr, c_insert).Value = ""
                End If
            Next lvl_above
        End If
    End If
    
    'Level end - closing element found
    If InStr(1, Cells(r_nr, c_nr), "}", 1) > 0 Then
        
    'opening and closing of a given element can be on different lines. So, it is best to compute lvl_end.
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

'End for each sheet

Sheets(1).Activate
Application.ScreenUpdating = True
End Sub


