If ([HeBerge:4]HB_Cas4:10)
	[HeBerge:4]HB_CasDt4:22:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib4:32)
Else 
	[HeBerge:4]HB_CasDt4:22:=!00-00-00!
	[HeBerge:4]HB_CasLib4:32:=""
End if 