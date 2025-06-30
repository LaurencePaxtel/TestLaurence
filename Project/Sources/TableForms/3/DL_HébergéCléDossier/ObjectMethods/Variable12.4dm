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
	va_IDT_Pré:=Uppercase:C13(va_IDT_Pré)
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
End if 