//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          FormuleFormat : [Maraude];"MR_ListeInclueVeilleB"
//{
//{          Vendredi 1 juillet 2004 à 11:04
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur affichage corps:K2:22)
	va_NomClé:=Uut_HébergéClé(->[Maraude:24]MR_Nom:17; ->[Maraude:24]MR_Prénom:18; ->[Maraude:24]MR_DateNéLe:20)
End if 