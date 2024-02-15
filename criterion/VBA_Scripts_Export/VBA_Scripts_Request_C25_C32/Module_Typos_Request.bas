Attribute VB_Name = "Module_Typos_Request"
Sub typos_request()

'Application.ScreenUpdating = False

'Dim variables
Dim s_max, s_nr, lb, ub As Integer
Dim r, r_description, r_max, r2 As Integer
Dim c, c_description, c_max As Integer
Dim txt_description, txt_old, txt_new As String

Dim previous_w, current_w As String
Dim words() As String
ReDim words(1 To 1000)

'Page selection
s_max = Sheets.Count
For s_nr = 1 To s_max
Sheets(s_nr).Activate

'Reset
r_description = 0
r_max = 0
c_description = 0
c_max = 0

'Column Selection
For r = 1 To 1000
    For c = 1 To 1000
        If Cells(r, c) = "Name" Then
            c_max = c - 1
        ElseIf Cells(r, c) = "Description" Then
            r_description = r + 1
            c_description = c
        End If
    If c_max <> 0 And c_description <> 0 Then
        Exit For
    End If
    Next c
If c_max <> 0 And c_description <> 0 Then
    Exit For
End If
Next r

'Row Selection
For r = 1 To 1000
    r2 = r + 1
    For c = 1 To c_max
        If InStr(1, Cells(r, c), "CRITERION}", 1) > 0 And InStr(1, Cells(r2, c), "{CRITERION", 1) = 0 Then
            r_max = r
        End If
    Next c
Next r

  
'Start Proccess

For r = r_description To r_max

    'Keeping old cell value
    txt_old = Cells(r, c_description).Value
    
    'Start Process for spelling check
    If Cells(r, c_description).Value <> "" Then
        Cells(r, c_description).Select
        Selection.CheckSpelling SpellLang:=2057
    End If
    
    'Start Process for removing extra spaces
    txt_description = WorksheetFunction.Trim(Cells(r, c_description).Value)
    Cells(r, c_description).Value = txt_description
    
    'Start verification of changes
    If txt_old <> Cells(r, c_description).Value Then
        Cells(r, c_description).Select
        With Selection.Font
            .Color = -16776961
            .TintAndShade = 0
        End With
    Else
        Cells(r, c_description).Select
        With Selection.Font
            .ColorIndex = xlAutomatic
            .TintAndShade = 0
        End With
    End If
    
    txt_old = ""

Next r

'Sheet selection part 2
Range("A1").Select
Next s_nr

'End for each sheet
Sheets(1).Activate
End Sub


