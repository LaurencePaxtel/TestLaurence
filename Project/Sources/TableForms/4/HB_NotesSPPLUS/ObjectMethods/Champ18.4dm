If ([HeBerge:4]HB_Cas6:12)
	[HeBerge:4]HB_CasDt6:24:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib6:34)
Else 
	[HeBerge:4]HB_CasDt6:24:=!00-00-00!
	[HeBerge:4]HB_CasLib6:34:=""
End if 