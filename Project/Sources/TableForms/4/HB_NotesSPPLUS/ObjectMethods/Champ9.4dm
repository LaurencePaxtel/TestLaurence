If ([HeBerge:4]HB_Cas3:9)
	[HeBerge:4]HB_CasDt3:21:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib3:31)
Else 
	[HeBerge:4]HB_CasDt3:21:=!00-00-00!
	[HeBerge:4]HB_CasLib3:31:=""
End if 