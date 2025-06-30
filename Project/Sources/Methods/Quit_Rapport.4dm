//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_Rapport
//{
//{          Lundi 09 février 2004 à 16:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//BEEP
If (Modified record:C314([Rapport:35]))
	ACCEPT:C269
Else 
	CANCEL:C270
End if 