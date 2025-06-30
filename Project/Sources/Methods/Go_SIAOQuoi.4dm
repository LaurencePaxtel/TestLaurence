//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_SIAOQuoi  
//{          vendredi 6 janvier 2012 à 17:15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
READ ONLY:C145(*)

If (7=8)
	$vl_Fenetre:=i_FenêtreNo(475; 457; 4; "SIAO"; 4; "Quit_Simple")
	$vl_Fenetre:=i_FenêtreNo(475; 457; 4; "SIAO"; -((16*45))-2; "Quit_Simple")
End if 
$vl_Fenetre:=i_FenêtreNo(475; 447; -((16*45))-2; "Aide SIAO"; 25; "Quit_Simple")
DIALOG:C40([DePart:1]; "DP_SIAOquoi")
CLOSE WINDOW:C154($vl_Fenetre)


<>PR_SiaoQuoi:=0

