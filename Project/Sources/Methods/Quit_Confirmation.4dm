//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Quit_Confirmation
//{
//{          Lundi 05 Janvier 1998 à 14:37:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
If (Ok=1)
	ACCEPT:C269
Else 
	CANCEL:C270
End if 