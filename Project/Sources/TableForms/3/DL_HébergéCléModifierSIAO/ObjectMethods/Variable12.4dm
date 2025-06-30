//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script va_IDT_Pré  
//{
//{          Lundi 28 Juillet 1997 à 16:54:29
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur données modifiées:K2:15)
	If (Length:C16(va_IDT_Pré)>20)
		ALERT:C41("La longueur du prénom ne peut pas dépasser 20 caractères !")
		va_IDT_Pré:=Substring:C12(va_IDT_Pré; 1; 20)
	End if 
	va_IDT_Pré:=Uppercase:C13(va_IDT_Pré)
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
End if 