//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_OptionVeille
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TIME:C306(vh_Clic1; vh_xClic1)
C_LONGINT:C283(vl_xOld)
vh_Clic1:=?00:00:00?
vh_xClic1:=?00:00:00?
vl_xOld:=0

$vl_Fenetre:=i_FenêtreNo(479; 360; 5; "Option veille"; 3; "")
DIALOG:C40([DiaLogues:3]; "DL_VeilleOption")
CLOSE WINDOW:C154($vl_Fenetre)
