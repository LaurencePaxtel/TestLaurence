//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_HBNotes  
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")

If (Ok=1)
	ACCEPT:C269
Else 
	CANCEL:C270
End if 