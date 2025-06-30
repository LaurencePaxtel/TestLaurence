//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_MemoFusion  
//{
//{          Quit_MemoFusion
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//BEEP
If (Modified record:C314([DePart:1]))
	ACCEPT:C269
Else 
	CANCEL:C270
End if 