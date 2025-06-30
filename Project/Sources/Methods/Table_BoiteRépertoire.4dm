//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Table_BoiteRépertoire
//{
//{          Vendredi 19 décembre 2008 à 12:05:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

If (<>PR_AppelBAL=0)
	If (7=8)
		<>PR_AppelBAL:=New process:C317("Go_BoiteAuLettre"; 0; "BAL"; $1)  //updt
	Else 
		<>PR_AppelBAL:=New process:C317("Go_BoiteAuLettre_B"; 0; "BAL"; $1)  //updt
	End if 
	
Else 
	If ($1=<>va_T_QuelleBoiteLettres)
	Else 
		ALERT:C41("Veuillez au préalable fermer la boîte affichée !")
	End if 
	Process_Show(<>PR_AppelBAL)
End if 