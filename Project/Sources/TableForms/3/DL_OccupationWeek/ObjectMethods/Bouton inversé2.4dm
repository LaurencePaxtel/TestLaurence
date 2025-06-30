If (vd_Date1>!00-00-00!)
	vd_Date1:=Add to date:C393(vd_Date1; 0; 0; 7)
Else 
	vd_Date1:=Current date:C33
End if 
P_SemaineDate(1; vd_Date1; ->vd_Date1; ->vd_Date2)