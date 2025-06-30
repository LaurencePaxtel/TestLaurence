//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_SIAO  
//{
//{          Mardi 19 octobre 2010 à 14:14:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
If (Modified record:C314([Dossier_SIAO:49]))
	CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
	If (Ok=1)
		ACCEPT:C269
	Else 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 