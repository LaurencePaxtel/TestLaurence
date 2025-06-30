//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_CentreX
//{          Lundi 6 mars 2012 à 16:15
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

$vl_Fenetre:=i_FenêtreNo(357; 429; 5; $1; 4; "")

DIALOG:C40([DiaLogues:3]; "DL_TabCentrex")
CLOSE WINDOW:C154($vl_Fenetre)