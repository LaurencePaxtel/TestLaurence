//%attributes = {}
//{==================================================}
//{          Procédure : Go_àPropos
//{
//{          Lundi 05 Janvier 1998 à 14:37:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


If (<>PR_APropos=0)
	<>PR_APropos:=New process:C317("Go_àProposV"; 0; "àPropos")
Else 
	Process_Show(<>PR_APropos)
End if 