//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementMultiple  
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)

$vl_Fenetre:=i_FenêtreNo(507; 309; -((16*45))-2; "Réservation multiple"; 3; "")
DIALOG:C40([DiaLogues:3]; "DL_HébergementMultiple")
CLOSE WINDOW:C154($vl_Fenetre)
<>va_RéserveAction:=""
POST OUTSIDE CALL:C329(<>PR_Hébergement)
<>PR_HébergementMul:=0