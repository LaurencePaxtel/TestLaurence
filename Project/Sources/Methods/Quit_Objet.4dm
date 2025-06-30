//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_Objet
//{
//{          Mercredi 12 janvier 2011 à 14:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//BEEP
If (Modified record:C314([Objets:56]))
	CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
	If (Ok=1)
		ACCEPT:C269
	Else 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 