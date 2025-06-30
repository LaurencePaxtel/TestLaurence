//%attributes = {}
//{==================================================}
//{ LOGICIEL : Route Postale
//{ © DBsolutions
//{
//{          Procédure : Go_MireDébut  
//{
//{          Vendredi 10 Janvier 1997 à 12:26:17
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (<>PR_Mire=0)
	<>PR_Mire:=New process:C317("Go_MireDébutV"; 0; "Mire")
Else 
	Process_Show(<>PR_Mire)
End if 