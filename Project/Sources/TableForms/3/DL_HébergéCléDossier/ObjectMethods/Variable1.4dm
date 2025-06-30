//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script va_IDT_Nom  
//{
//{          Lundi 28 Juillet 1997 à 16:54:03
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (Form event code:C388=Sur données modifiées:K2:15)
	If (Substring:C12(va_IDT_Nom; 1; 1)=" ")
		While (Substring:C12(va_IDT_Nom; 1; 1)=" ")
			va_IDT_Nom:=Substring:C12(va_IDT_Nom; 2)
		End while 
	End if 
	va_IDT_Nom:=Uppercase:C13(va_IDT_Nom)
	If (va_IDT_Nom>"")
		Repeat 
			If (Character code:C91(va_IDT_Nom[[1]])<=32)
				va_IDT_Nom:=Substring:C12(va_IDT_Nom; 2)
			End if 
		Until (Character code:C91(va_IDT_Nom[[1]])>32)
	End if 
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
End if 