If (vd_Date1>!00-00-00!)
	vd_Date1:=vd_Date1-1
Else 
	vd_Date1:=Current date:C33
End if 

F_SommeVeille(va_ValeurItem; vd_Date1)