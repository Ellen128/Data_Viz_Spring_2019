Sub YearSum()

'Create yearly report
    
Worksheets(1).Cells(1, 9).Value = "Ticker"
Worksheets(1).Cells(1, 10).Value = "Yearly Change"
Worksheets(1).Cells(1, 11).Value = "Percent Change"
Worksheets(1).Cells(1, 12).Value = "Total Stock Volume"
Range("J1:N4").Columns.AutoFit

Dim w As Integer 'set the row for writing ticker and volume
w = 2
    
Dim openp As Single 'set initial min price

Dim r As Long
'r = 3

Dim sum As Double

For s = 1 To Worksheets.Count

    r = 3
    
    
    'in case open price is 0
    Dim n As Double
    n = 2
    
    Do While Worksheets(s).Cells(n, 3).Value = 0
    n = n + 1
    Loop
    
    openp = Worksheets(s).Cells(n, 3).Value
    
    sum = Worksheets(s).Cells(2, 7).Value

    Do While Worksheets(s).Cells(r, 1).Value <> ""
    
        If Worksheets(s).Cells(r, 1).Value = Worksheets(s).Cells(r - 1, 1).Value Then
            sum = sum + Worksheets(s).Cells(r, 7).Value
             
            
        Else
                'write result for this ticket
                'MsgBox (Worksheets(s).Cells(r - 1, 6).Value)
                
                Worksheets(s).Cells(w, 9).Value = Worksheets(s).Cells(r - 1, 1).Value 'write ticker
                Worksheets(s).Cells(w, 10).Value = Worksheets(s).Cells(r - 1, 6).Value - openp 'write yearly price change
               
                Worksheets(s).Cells(w, 11).Value = Format((Worksheets(s).Cells(r - 1, 6).Value - openp) / openp, "percent") 'write price change percentage
                Worksheets(s).Cells(w, 12).Value = sum  'write yearly sum
                
               If sum = 0 Then
                MsgBox (sum)
                MsgBox (s)
                MsgBox (r)
                End If
                
                'set color for yearly price change
                If Worksheets(s).Cells(w, 10).Value < 0 Then
                    Worksheets(s).Cells(w, 10).Interior.ColorIndex = 4
                    Else
                    Worksheets(s).Cells(w, 10).Interior.ColorIndex = 3
                    End If
                    
                
                
                'reset for next new ticket
                'in case open price is 0
                n = r
                
                Do While Worksheets(s).Cells(n, 3).Value = 0
                n = n + 1
                Loop
                
                openp = Worksheets(s).Cells(n, 3).Value
                            
                'openp = Worksheets(s).Cells(r, 3).Value
                sum = Worksheets(s).Cells(r, 7).Value   'Reset sum as the first new ticker's volume
                
                w = w + 1
                
        End If
                
           r = r + 1
        
    Loop
    
    'for the last row need to write results
    Worksheets(s).Cells(w, 9).Value = Worksheets(s).Cells(r - 1, 1).Value 'write ticker for the last row
    Worksheets(s).Cells(w, 10).Value = Worksheets(s).Cells(r - 1, 6).Value - openp 'write yearly sum
    Worksheets(s).Cells(w, 11).Value = Format((Worksheets(s).Cells(r - 1, 6).Value - openp) / openp, "percent") 'write price change percentage
    Worksheets(s).Cells(w, 12).Value = sum  'write yearly sum
    
    'set color for yearly price change
    If Worksheets(s).Cells(w, 10).Value < 0 Then
    Worksheets(s).Cells(w, 10).Interior.ColorIndex = 4
    Else
    Worksheets(s).Cells(w, 10).Interior.ColorIndex = 3
    End If


    'find the greatest %
    Dim gmax As Single
    Dim gmin As Single
    Dim vmax As Double
    
    gmax = Worksheets(s).Cells(2, 11).Value
    gmin = Worksheets(s).Cells(2, 11).Value
    vmax = Worksheets(s).Cells(2, 12).Value

    Dim imax As Integer
    Dim imin As Integer
    Dim ivol As Integer

    imax = 2
    imin = 2
    ivol = 2
    
    For i = 3 To w
    
        If gmax < Worksheets(s).Cells(i, 11).Value Then
            gmax = Worksheets(s).Cells(i, 11).Value
            imax = i
            
            End If
            
        If gmin > Worksheets(s).Cells(i, 11).Value Then
            gmin = Worksheets(s).Cells(i, 11).Value
            imin = i
            
            End If
        
        If vmax < Worksheets(s).Cells(i, 12).Value Then
        vmax = Worksheets(s).Cells(i, 12).Value
        ivol = i
        
        End If
    
    Next i
    
        Worksheets(s).Cells(1, 15).Value = "Ticker"
        Worksheets(s).Cells(1, 16).Value = "Value"
        Worksheets(s).Cells(2, 14).Value = "Greastest % Increase"
        Worksheets(s).Cells(3, 14).Value = "Greastest % Decrease"
        Worksheets(s).Cells(4, 14).Value = "Greastest Total Volume"
        
        'MsgBox (imax)
        Worksheets(s).Cells(2, 15).Value = Worksheets(s).Cells(imax, 9).Value
        Worksheets(s).Cells(3, 15).Value = Worksheets(s).Cells(imin, 9).Value
        Worksheets(s).Cells(4, 15).Value = Worksheets(s).Cells(ivol, 9).Value
      
        Worksheets(s).Cells(2, 16).Value = Format(gmax, "percent") 'Worksheets(s).Cells(imax, 11).Value
        Worksheets(s).Cells(3, 16).Value = Format(gmin, "percent") 'Worksheets(s).Cells(imin, 11).Value
        Worksheets(s).Cells(4, 16).Value = vmax 'Worksheets(s).Cells(ivol, 12).Value
    
    'ActiveWorkbook.Worksheets
    
    'Worksheets(s).Cells(4, 16).Value = 343
    'Worksheets(s).Cells(4, 16).for

    
    'reset for the new sheet-------------------------------
    
    If s < pages Then
    
            Worksheets(s + 1).Cells(1, 9).Value = "Ticker"
            Worksheets(s + 1).Cells(1, 10).Value = "Yearly Change"
            Worksheets(s + 1).Cells(1, 11).Value = "Percent Change"
            Worksheets(s + 1).Cells(1, 12).Value = "Total Stock Volume"
            
            'set the row for writing ticker and volume
            w = 2
                
            'set initial min price
             'in case open price is 0
            n = 2
            
            Do While Worksheets(s).Cells(n, 3).Value = 0
            n = n + 1
            Loop
            
            openp = Worksheets(s).Cells(n, 3).Value
            'w = w + 1
    End If '------------------------------------------------
 
Next s

End Sub


