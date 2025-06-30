If ([HeBerge:4]HB_Cas5:11)
	[HeBerge:4]HB_CasDt5:23:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib5:33)
Else 
	[HeBerge:4]HB_CasDt5:23:=!00-00-00!
	[HeBerge:4]HB_CasLib5:33:=""
End if 