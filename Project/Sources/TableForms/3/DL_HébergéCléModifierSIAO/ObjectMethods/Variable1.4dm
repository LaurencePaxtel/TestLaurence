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
	
	If (Length:C16(va_IDT_Nom)>30)
		ALERT:C41("La longueur du nom ne peut pas dépasser 30 caractères !")
		va_IDT_Nom:=Substring:C12(va_IDT_Nom; 1; 30)
	End if 
	va_IDT_Nom:=Uppercase:C13(va_IDT_Nom)
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
End if 