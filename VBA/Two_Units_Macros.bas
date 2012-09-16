Attribute VB_Name = "Module2"
Sub OwnerSummedTract_2Units()

'gets names of the additional spreadsheet, and ends the program if user selects cancel

Dim secondSheetName As String
secondSheetName = InputBox("In addition to the sheet already selected, what is the title of the second spreadsheet?", "Input Second Spreadsheet")
If secondSheetName = "" Then
    End
End If

'gets Owner#, Lessor Name, Lessor RI, and GMX NRI into a new spreadsheet
Dim current As Worksheet
Set current = ActiveSheet
current.Activate

Dim WS As Worksheet
Set WS = Sheets.Add
WS.Name = "Owner Summed Tract_2 Units"
current.Select
    Columns("A:C").Select
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("B:B").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    current.Select
    Columns("K:M").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("E:E").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False

Dim secondSheet As Worksheet                '*********************************************'
Set secondSheet = Sheets(secondSheetName)   '*****INSERT SECOND SPREADSHEET NAME HERE*****'
secondSheet.Activate                        '*********************************************'

secondSheet.Select
    Columns("A:C").Select
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("J:J").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    secondSheet.Select
    Columns("K:M").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("M:M").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False


'checks row length of all columns to see which is longest

Dim i, LastRow, LastRow1, LastRow2, LastRow3, LastRow4, LastRow5, LastRow6              'last rows for first sheet
LastRow1 = Range("B" & Rows.Count).End(xlUp).Row
LastRow2 = Range("C" & Rows.Count).End(xlUp).Row
LastRow3 = Range("D" & Rows.Count).End(xlUp).Row
LastRow4 = Range("E" & Rows.Count).End(xlUp).Row
LastRow5 = Range("F" & Rows.Count).End(xlUp).Row
LastRow6 = Range("G" & Rows.Count).End(xlUp).Row

LastRow = WorksheetFunction.Max(LastRow1, LastRow2, LastRow3, LastRow4, LastRow5, LastRow6)

Dim OtherLastRow, LastRow11, LastRow22, LastRow33, LastRow44, LastRow55, LastRow66   'last rows for second sheet
LastRow11 = Range("J" & Rows.Count).End(xlUp).Row
LastRow22 = Range("K" & Rows.Count).End(xlUp).Row
LastRow33 = Range("L" & Rows.Count).End(xlUp).Row
LastRow44 = Range("M" & Rows.Count).End(xlUp).Row
LastRow55 = Range("N" & Rows.Count).End(xlUp).Row
LastRow66 = Range("O" & Rows.Count).End(xlUp).Row

OtherLastRow = WorksheetFunction.Max(LastRow11, LastRow22, LastRow33, LastRow44, LastRow55, LastRow66)

'creates the Unit column

Range("A1").Value = current.Range("A1")
Range("A1").Select
Selection.AutoFill Destination:=Range("A1:A" & LastRow), Type:=xlFillDefault
Columns("A:J").EntireColumn.AutoFit

Range("I1").Value = secondSheet.Range("A1")
Range("I1").Select
Selection.AutoFill Destination:=Range("I1:I" & OtherLastRow), Type:=xlFillDefault
Columns("A:J").EntireColumn.AutoFit

'move data from second sheet underneath first sheet data
Range("I1:O" & OtherLastRow).Select
Selection.Copy
Range("A" & LastRow + 1).Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
Columns("I:O").Select                   'deletes unnecessary columns used in creation of this spreadsheet
Selection.Delete Shift:=xlToLeft

    Columns("F:F").Select
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    
    Columns("H:H").Select
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    
'recheck to see which row is the real last row

LastRow1 = Range("B" & Rows.Count).End(xlUp).Row
LastRow2 = Range("C" & Rows.Count).End(xlUp).Row
LastRow3 = Range("D" & Rows.Count).End(xlUp).Row
LastRow4 = Range("E" & Rows.Count).End(xlUp).Row
LastRow5 = Range("F" & Rows.Count).End(xlUp).Row
LastRow6 = Range("G" & Rows.Count).End(xlUp).Row

LastRow = WorksheetFunction.Max(LastRow1, LastRow2, LastRow3, LastRow4, LastRow5, LastRow6)
LastRow = LastRow + 1               'grabs the very last row

'delete all rows with no Owner # and also rounds interests to 8 decimal places

For i = LastRow To 1 Step -1
On Error Resume Next
If Cells(i, "C").Value = False Then
    Cells(i, "A").EntireRow.Delete
Else
    'check to see if rows have --- as their value, and if so, delete them
   Cells(i, "M").Formula = "=MID(C" & i & ",1,3)"
   If Cells(i, "M").Value = "---" Then
        Cells(i, "A").EntireRow.Delete
   Else

        'checks to see if the owner # is an actual number
        Cells(i, "N").Formula = "=IF(ISNUMBER(C" & i & "),1,0)"
        'trim lessor field to have no extra spaces
        Cells(i, "O").Formula = "=TRIM(D" & i & ")"
   End If
End If
Next

'paste trimmed lessor values back into the lessor column

    Columns("O:O").Select
    Application.CutCopyMode = False
    Selection.Copy
    Columns("D:D").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Columns("O:O").Select
    Application.CutCopyMode = False
    Selection.ClearContents
    
 LastRow = Range("A" & Rows.Count).End(xlUp).Row

'sets the titles for all of the rows before creating the table
    Range("A1").Value = "Unit"
    Range("B1").Value = "Tract"
    Range("C1").Value = "Owner No."
    Range("D1").Value = "Lessor"
    Range("E1").Value = "Royalty"
    Range("F1").Value = "Total Royalty"
    Range("G1").Value = "ORRI"
    Range("H1").Value = "Total ORRI"
    Range("I1").Value = "GMX NRI"
    Range("J1").Value = "Total GMX NRI"
    
'creates a table and sorts the data by owner number, then tract, then lessor name
    
Dim col1, col2, col3 As String
col2 = Range("B1").Value
col3 = Range("C1").Value
col4 = Range("D1").Value

    Range("A1").Select
    Range("A1:J1").Select
    Range(Selection, Selection.End(xlDown)).Select
    ActiveSheet.ListObjects.Add(xlSrcRange, Range("$A$1:$J$" & LastRow), , xlYes).Name = _
        "Table19"
    Range("Table19[#All]").Select
    ActiveSheet.ListObjects("Table19").TableStyle = "TableStyleLight9"
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table19"). _
        Sort.SortFields.Clear
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table19"). _
        Sort.SortFields.Add Key:=Range("Table19[" & col3 & "]"), SortOn:=xlSortOnValues, _
        Order:=xlAscending, DataOption:=xlSortNormal
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table19"). _
        Sort.SortFields.Add Key:=Range("Table19[" & col4 & "]"), SortOn:=xlSortOnValues, _
        Order:=xlAscending, DataOption:=xlSortNormal
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table19"). _
        Sort.SortFields.Add Key:=Range("Table19[" & col2 & "]"), SortOn:=xlSortOnValues, _
        Order:=xlAscending, DataOption:=xlSortNormal
    With ActiveWorkbook.Worksheets(WS.Name).ListObjects( _
        "Table19").Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    
'Sum up all interests with similar owner numbers
Dim x
x = 2

Dim firstSUSP As Boolean
firstSUSP = True

Dim firstRowSUSP, SUSPcount
firstRowSUSP = 0
SUSPcount = 0

Dim currentOwnerRoyaltySum, currentOwnerWorkingSum, currentOwnerORRISum
currentOwnerRoyaltySum = 0
currentOwnerORRISum = 0
currentOwnerWorkingSum = 0

LastRow = Range("A" & Rows.Count).End(xlUp).Row      'reset the value for last row

Do While x <= LastRow
     On Error Resume Next
        If Cells(x, "N").Value = 1 Then              'checks to see if owner code is a number
        
            currentOwnerRoyaltySum = currentOwnerRoyaltySum + Cells(x, "E")
            currentOwnerORRISum = currentOwnerORRISum + Cells(x, "G")
            currentOwnerWorkingSum = currentOwnerWorkingSum + Cells(x, "I")
            
            If Cells(x, "C").Value <> Cells(x + 1, "C").Value Then   'checks if the owner # below it is the same
        
                Cells(x + 1, "A").EntireRow.Insert
                Cells(x + 1, "B").Value = "Total"
                Cells(x + 1, "C") = Cells(x, "C")
                Cells(x + 1, "D") = Cells(x, "D")
                Cells(x + 1, "F") = currentOwnerRoyaltySum
                Cells(x + 1, "H") = currentOwnerORRISum
                Cells(x + 1, "J") = currentOwnerWorkingSum
                Range(Cells(x + 1, "A"), Cells(x + 1, "J")).Select
                Selection.Font.Bold = True
                With Selection.Font
                    .Color = -16776961
                    .TintAndShade = 0
                End With
                LastRow = LastRow + 1
                x = x + 2
                currentOwnerRoyaltySum = 0
                currentOwnerORRISum = 0
                currentOwnerWorkingSum = 0
            Else
                x = x + 1               'if bottom row is not equal to upper row, then it incremments the row number
            End If
        Else                            'if the owner code is not a numerical value...
            If Cells(x, "M").Value = "SUS" Then         'checks to see if it is a SUSP owner code
                If firstSUSP = True Then                'checks if this is the first SUSP entry
                    firstRowSUSP = x                    'if so, then it sets firstRowSUSP to the current row
                Else
                    SUSPcount = SUSPcount + 1           'increments the # of rows with SUSP owner code
                End If
                firstSUSP = False                       'sets boolean variable to false to show that the first row has already been found
            End If
            x = x + 1
        
        End If
    
Loop

LastRow = Range("A" & Rows.Count).End(xlUp).Row         'resets last row

Dim y, endingRowSUSP
y = firstRowSUSP
endingRowSUSP = firstRowSUSP + SUSPcount

currentOwnerRoyaltySum = 0
currentOwnerORRISum = 0
currentOwnerWorkingSum = 0

Do While y <= endingRowSUSP And SUSPcount <> 0          'sums all interests for SUSP owners, unless there aren't any
       On Error Resume Next
            currentOwnerRoyaltySum = currentOwnerRoyaltySum + Cells(y, "E")
            currentOwnerORRISum = currentOwnerORRISum + Cells(y, "G")
            currentOwnerWorkingSum = currentOwnerWorkingSum + Cells(y, "I")
            
            If Cells(y, "D").Value <> Cells(y + 1, "D").Value Then
        
                Cells(y + 1, "A").EntireRow.Insert
                Cells(y + 1, "B").Value = "Total"
                Cells(y + 1, "C") = Cells(y, "C")
                Cells(y + 1, "D") = Cells(y, "D")
                Cells(y + 1, "F") = currentOwnerRoyaltySum
                Cells(y + 1, "H") = currentOwnerORRISum
                Cells(y + 1, "J") = currentOwnerWorkingSum
                Range(Cells(y + 1, "A"), Cells(y + 1, "J")).Select
                Selection.Font.Bold = True
                With Selection.Font
                    .Color = -16776961
                    .TintAndShade = 0
                End With
                endingRowSUSP = endingRowSUSP + 1
                y = y + 2
                currentOwnerRoyaltySum = 0
                currentOwnerORRISum = 0
                currentOwnerWorkingSum = 0
            Else
                y = y + 1               'if bottom row is not equal to upper row, then it incremments the row number
            End If

Loop

Columns("M:N").Select                   'deletes unnecessary columns used in creation of this spreadsheet
Selection.Delete Shift:=xlToLeft

'final loop - rounding - until the next owner code is a blank cell
Dim z
z = 2

Do
    On Error Resume Next
        Cells(z, "E").Value = Math.Round(Cells(z, "E").Value, 8)
        Cells(z, "F").Value = Math.Round(Cells(z, "F").Value, 8)
        Cells(z, "G").Value = Math.Round(Cells(z, "G").Value, 8)
        Cells(z, "H").Value = Math.Round(Cells(z, "H").Value, 8)
        Cells(z, "I").Value = Math.Round(Cells(z, "I").Value, 8)
        Cells(z, "J").Value = Math.Round(Cells(z, "J").Value, 8)
        z = z + 1
Loop Until Cells(z, "C").Value = False

End Sub

Sub SummedOwnerUpload_2Units()

'gets names of the additional spreadsheet, and ends the program if user selects cancel

Dim secondSheetName As String
secondSheetName = InputBox("In addition to the sheet already selected, what is the title of the second spreadsheet?", "Input Second Spreadsheet")
If secondSheetName = "" Then
    End
End If

'gets Owner#, Lessor Name, Lessor RI, and GMX NRI into a new spreadsheet
Dim current As Worksheet
Set current = ActiveSheet
current.Activate

Dim WS As Worksheet
Set WS = Sheets.Add
WS.Name = "Summed Owner Upload_2 Units"
current.Select
    Columns("B:C").Select
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("B:B").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    current.Select
    Columns("K:M").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("D:D").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
        
Dim secondSheet As Worksheet                    '*********************************************'
Set secondSheet = Sheets(secondSheetName)       '*****INSERT SECOND SPREADSHEET NAME HERE*****'
secondSheet.Activate                            '*********************************************'

secondSheet.Select
    Columns("B:C").Select
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("J:J").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    secondSheet.Select
    Columns("K:M").Select
    Application.CutCopyMode = False
    Selection.Copy
    Sheets(WS.Name).Select
    Columns("L:L").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
'checks row length of all columns to see which is longest

Dim i, LastRow, LastRow1, LastRow2, LastRow3, LastRow4, LastRow5                    'last rows for first sheet
LastRow1 = Range("B" & Rows.Count).End(xlUp).Row
LastRow2 = Range("C" & Rows.Count).End(xlUp).Row
LastRow3 = Range("D" & Rows.Count).End(xlUp).Row
LastRow4 = Range("E" & Rows.Count).End(xlUp).Row
LastRow5 = Range("F" & Rows.Count).End(xlUp).Row

LastRow = WorksheetFunction.Max(LastRow1, LastRow2, LastRow3, LastRow4, LastRow5)

Dim OtherLastRow, LastRow11, LastRow22, LastRow33, LastRow44, LastRow55             'last rows for second sheet
LastRow11 = Range("J" & Rows.Count).End(xlUp).Row
LastRow22 = Range("K" & Rows.Count).End(xlUp).Row
LastRow33 = Range("L" & Rows.Count).End(xlUp).Row
LastRow44 = Range("M" & Rows.Count).End(xlUp).Row
LastRow55 = Range("N" & Rows.Count).End(xlUp).Row

OtherLastRow = WorksheetFunction.Max(LastRow11, LastRow22, LastRow33, LastRow44, LastRow55)

'creates the Unit column

Range("A1").Value = current.Range("A1")
Range("A1").Select
Selection.AutoFill Destination:=Range("A1:A" & LastRow), Type:=xlFillDefault

Range("I1").Value = secondSheet.Range("A1")
Range("I1").Select
Selection.AutoFill Destination:=Range("I1:I" & OtherLastRow), Type:=xlFillDefault

'move data from second sheet underneath first sheet data
Range("I1:O" & OtherLastRow).Select
Selection.Copy
Range("A" & LastRow + 1).Select
Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
Columns("A:F").EntireColumn.AutoFit
        
Columns("I:N").Select                   'deletes unnecessary columns used in creation of this spreadsheet
Selection.Delete Shift:=xlToLeft

'reset the last row to include the data from the second sheet
LastRow1 = Range("B" & Rows.Count).End(xlUp).Row
LastRow2 = Range("C" & Rows.Count).End(xlUp).Row
LastRow3 = Range("D" & Rows.Count).End(xlUp).Row
LastRow4 = Range("E" & Rows.Count).End(xlUp).Row
LastRow5 = Range("F" & Rows.Count).End(xlUp).Row

LastRow = WorksheetFunction.Max(LastRow1, LastRow2, LastRow3, LastRow4, LastRow5)

'delete all rows with no Owner # and also rounds interests to 8 decimal places

For i = LastRow + 1 To 1 Step -1
On Error Resume Next
If Cells(i, "B").Value = False Then
    Cells(i, "B").EntireRow.Delete
Else
    'check to see if rows have --- as their value, and if so, delete them
   Cells(i, "I").Formula = "=MID(B" & i & ",1,3)"
   If Cells(i, "I").Value = "---" Then
        Cells(i, "A").EntireRow.Delete
   Else

        'checks to see if the owner # is an actual number
        Cells(i, "H").Formula = "=IF(ISNUMBER(B" & i & "),1,0)"
        'trim lessor field to have no extra spaces
        Cells(i, "J").Formula = "=TRIM(C" & i & ")"
   End If
End If
Next

'paste trimmed lessor values back into the lessor column

    Columns("J:J").Select
    Application.CutCopyMode = False
    Selection.Copy
    Columns("C:C").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Columns("J:J").Select
    Application.CutCopyMode = False
    Selection.ClearContents
    
LastRow = Range("A" & Rows.Count).End(xlUp).Row
 
    Range("A1").Value = "Unit"
    Range("B1").Value = "Owner No."
    Range("C1").Value = "Lessor"
    Range("D1").Value = "Total Royalty"
    Range("E1").Value = "Total ORRI"
    Range("F1").Value = "Total GMX NRI"

'sorts the data so far by owner number, then tract, then lessor name

Dim col1, col2 As String
col1 = Range("B1").Value
col2 = Range("C1").Value

        Range("A1").Select
    Range(Selection, Selection.End(xlToRight)).Select
    Range(Selection, Selection.End(xlDown)).Select
    ActiveSheet.ListObjects.Add(xlSrcRange, Range("$A$1:$F$" & LastRow), , xlYes).Name = _
        "Table14"
    Range("Table14[#All]").Select
    ActiveSheet.ListObjects("Table14").TableStyle = "TableStyleLight9"
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table14").Sort _
        .SortFields.Clear
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table14").Sort _
        .SortFields.Add Key:=Range("Table14[" & col1 & "]"), SortOn:=xlSortOnValues, _
        Order:=xlAscending, DataOption:=xlSortNormal
    ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table14").Sort _
        .SortFields.Add Key:=Range("Table14[" & col2 & "]"), SortOn:=xlSortOnValues, _
        Order:=xlAscending, DataOption:=xlSortNormal
    With ActiveWorkbook.Worksheets(WS.Name).ListObjects("Table14") _
        .Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With

'Sum up all interests with similar owner numbers
Dim x
x = 2

Dim firstSUSP As Boolean
firstSUSP = True

Dim firstRowSUSP, SUSPcount
firstRowSUSP = 0
SUSPcount = 0

LastRow = Range("A" & Rows.Count).End(xlUp).Row      'reset the value for last row

Do While x <= LastRow
     On Error Resume Next
        If Cells(x, "H").Value = 1 Then              'checks to see if owner code is a number
        
            If Cells(x, "B").Value = Cells(x + 1, "B").Value Then   'checks if the owner # below it is the same
        
                Cells(x, "D") = Cells(x, "D") + Cells(x + 1, "D")   'if so, then it adds the interests together
                Cells(x, "E") = Cells(x, "E") + Cells(x + 1, "E")   'deletes the bottom row, and reduces the last row
                Cells(x, "F") = Cells(x, "F") + Cells(x + 1, "F")   'by one
                Cells(x + 1, "A").EntireRow.Delete
                LastRow = LastRow - 1
            Else
                x = x + 1               'if bottom row is not equal to upper row, then it incremments the row number
               
            End If
        Else                            'if the owner code is not a numerical value...
            If Cells(x, "I").Value = "SUS" Then         'checks to see if it is a SUSP owner code
                If firstSUSP = True Then                'checks if this is the first SUSP entry
                    firstRowSUSP = x                    'if so, then it sets firstRowSUSP to the current row
                Else
                    SUSPcount = SUSPcount + 1           'increments the # of rows with SUSP owner code
                End If
                firstSUSP = False                       'sets boolean variable to false to show that the first row has already been found
            End If
            x = x + 1
        
        End If
    
Loop


Cells(firstRowSUSP, "L").Value = firstRowSUSP           'displays the first row that contains SUSP and then the count of rows
Cells(firstRowSUSP, "M").Value = SUSPcount              'for test purposes

LastRow = Range("A" & Rows.Count).End(xlUp).Row         'resets last row

Dim y, endingRowSUSP
y = firstRowSUSP
endingRowSUSP = firstRowSUSP + SUSPcount


Do While y <= endingRowSUSP And SUSPcount <> 0                            'sums all interests for SUSP owners
    On Error Resume Next
            If Cells(y, "C").Value = Cells(y + 1, "C").Value Then
        
                Cells(y, "D") = Cells(y, "D") + Cells(y + 1, "D")   'if so, then it adds the interests together
                Cells(y, "E") = Cells(y, "E") + Cells(y + 1, "E")   'deletes the bottom row, and reduces the last row
                Cells(y, "F") = Cells(y, "F") + Cells(y + 1, "F")
                Cells(y + 1, "A").EntireRow.Delete
                endingRowSUSP = endingRowSUSP - 1
            Else
                y = y + 1
               
            End If

Loop

Columns("H:M").Select                   'deletes unnecessary columns used in creation of this spreadsheet
Selection.Delete Shift:=xlToLeft

Columns("D:D").Select
Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove  'creates a column for the Royalty Type

Range("D1").Value = "Royalty Type"
Columns("D:D").EntireColumn.AutoFit

'final loop - rounding - until the next owner code is a blank cell and also determines the royalty type

LastRow = Range("A" & Rows.Count).End(xlUp).Row         'resets last row

Dim z
z = 2

Do
   On Error Resume Next
        Cells(z, "E").Value = Math.Round(Cells(z, "E").Value, 8)
        Cells(z, "F").Value = Math.Round(Cells(z, "F").Value, 8)
        Cells(z, "G").Value = Math.Round(Cells(z, "G").Value, 8)
        
        If Cells(z, "B").Value = 100 Then
            Cells(z, "D") = "WI"
            Cells(z, "I") = Cells(z, "E").Value
            Cells(z, "J").Formula = "=SUM(G2:G" & LastRow & ")"
            Cells(z, "K").Formula = "=I" & z & " + J" & z & " + F" & z
            Cells(z, "E").Value = Cells(z, "K").Value
            Cells(z, "E").Value = Math.Round(Cells(z, "E").Value, 8)
            
        ElseIf Cells(z, "E").Value <> 0 And Cells(z, "F").Value <> 0 Then    'if an owner has both a royalty and an override
            Cells(z, "D") = "RI"
            Cells(z + 1, "A").EntireRow.Insert
            Cells(z + 1, "A") = Cells(z, "A")
            Cells(z + 1, "B") = Cells(z, "B")
            Cells(z + 1, "C") = Cells(z, "C")
            Cells(z + 1, "D") = "OR"
            Cells(z + 1, "E") = Cells(z, "F")
            z = z + 1
        ElseIf Cells(z, "E").Value = 0 And Cells(z, "F").Value <> 0 Then    'if an owner only has an override
            Cells(z, "D") = "OR"
            Cells(z, "E") = Cells(z, "F")
        Else                                                                'if an owner only has a royalty
            Cells(z, "D") = "RI"
        End If
        
        z = z + 1
        
Loop Until Cells(z, "B").Value = False

    Columns("F:K").Select                                   'delete previous ORRI, GMX NRI, and extra columns
    Selection.Delete Shift:=xlToLeft

Range("E1").Value = "Total Royalty"

End Sub





