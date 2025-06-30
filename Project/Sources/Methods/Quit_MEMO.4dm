//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_MEMO  
//{
//{          Vendredi 15 mars 2002 à 10:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//BEEP
If (Modified record:C314([MemO:30]))
	[MemO:30]MO_Date:2:=Current date:C33
	[MemO:30]MO_Heure:3:=Current time:C178
	ACCEPT:C269
Else 
	CANCEL:C270
End if 