
If (Form event code:C388=Sur clic:K2:4)
	If (va_InC_login>"")
		
		[INtervenants:10]IN_Nom:4:=va_InC_Nom
		[INtervenants:10]IN_Prénom:5:=va_InC_Prénom
		[INtervenants:10]IN_Login:3:=va_InC_login
		[INtervenants:10]IN_Type:2:=ve_inC_Type
		[INtervenants:10]IN_Initiales:7:=va_inC_Initiales
		[INtervenants:10]IN_NomPrénom:8:=va_inC_NomPrénom
		[INtervenants:10]IN_Signature:9:=vi_inC_Signature
		[INtervenants:10]IN_LOFT:10:=vb_inC_Loft
		[INtervenants:10]IN_Messagerie:12:=vb_inC_Messagerie
		[INtervenants:10]IN_Pointage:14:=vb_inC_Pointage
		[INtervenants:10]IN_Plateforme:13:=va_inC_Plateforme
		If ([INtervenants:10]IN_Type:2#0)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
			va_TypeN:=String:C10([INtervenants:10]IN_Type:2)
		Else 
			[INtervenants:10]IN_Type:2:=1
			va_TypeN:=String:C10([INtervenants:10]IN_Type:2)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
		End if 
		
	End if 
End if 