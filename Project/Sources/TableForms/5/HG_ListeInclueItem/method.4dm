If (Form event code:C388=Sur affichage corps:K2:22)
	va_Item:=String:C10(tp_ItemRub{ta_ItemRub}->)
	
	If ([HeberGement:5]HG_Genre:96)
		va_sex:="F."
	Else 
		va_sex:="M."
	End if 
	
End if 