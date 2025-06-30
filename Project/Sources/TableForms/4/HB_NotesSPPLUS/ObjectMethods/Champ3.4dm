If ([HeBerge:4]HB_Cas1:7)
	[HeBerge:4]HB_CasDt1:19:=Current date:C33
	GOTO OBJECT:C206([HeBerge:4]HB_CasLib1:29)
Else 
	[HeBerge:4]HB_CasDt1:19:=!00-00-00!
	[HeBerge:4]HB_CasLib1:29:=""
End if 