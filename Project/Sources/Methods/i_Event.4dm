//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : i_Event
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (KeyCode=32) | (KeyCode=13) | (KeyCode=3) | (MOUSEDOWN=1) | (KeyCode=27)
	<>e_MouseDown:=1
End if 