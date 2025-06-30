If ([HeBerge:4]HB_Cas10:16)
	[HeBerge:4]HB_CasDt10:28:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib10:38)
Else 
	[HeBerge:4]HB_CasDt10:28:=!00-00-00!
	[HeBerge:4]HB_CasLib10:38:=""
End if 