//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          FormuleFormat : [DossierSocial];"DS_ListeInclueVeille"
//{
//{          Vendredi 3 mars 2006 à 14:56
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur affichage corps:K2:22)
	va_NomClé:=Uut_HébergéClé(->[DossierSocial:25]DS_Nom:12; ->[DossierSocial:25]DS_Prénom:16; ->[DossierSocial:25]DS_DateNéLe:18)
End if 