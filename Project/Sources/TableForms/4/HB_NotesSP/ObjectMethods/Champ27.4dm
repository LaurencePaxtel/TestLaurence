If ([HeBerge:4]HB_Cas9:15)
	[HeBerge:4]HB_CasDt9:27:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib9:37)
Else 
	[HeBerge:4]HB_CasDt9:27:=!00-00-00!
	[HeBerge:4]HB_CasLib9:37:=""
End if 