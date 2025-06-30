//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_appelAd
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $vl_Fenetre : Integer

SET MENU BAR:C67(1)
READ ONLY:C145(*)

HIDE PROCESS:C324(<>PR_Appel)

READ WRITE:C146([APpels:19])
FORM SET INPUT:C55([APpels:19]; "AP_EcranSaisie")

$vl_Fenetre:=i_FenêtreNo(465; 140; 4; "Appel : nouveau"; 3; "")
ADD RECORD:C56([APpels:19])  // lpc 08122017 ascenceur

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([APpels:19])

Process_Show(<>PR_Appel)
<>PR_AppelAdd:=0