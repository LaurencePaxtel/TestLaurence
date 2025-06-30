If ([HeBerge:4]HB_Cas2:8)
	[HeBerge:4]HB_CasDt2:20:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib2:30)
Else 
	[HeBerge:4]HB_CasDt2:20:=!00-00-00!
	[HeBerge:4]HB_CasLib2:30:=""
End if 