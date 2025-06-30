//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementGroupe  
//{
//{          Lundi 08 mars 2004 à 9:44:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

C_LONGINT:C283($vl_Fenetre)

C_TEXT:C284(va_GPNom; va_GPNb)
C_TIME:C306(vh_xClic1)

va_GPNom:=$1
vh_xClic1:=Current time:C178

READ ONLY:C145(*)
SET MENU BAR:C67(1)

$vl_Fenetre:=i_FenêtreNo(647; 399; -((16*45))-2; F_HébergementGroupeTitre($1); 3; "")
DIALOG:C40([DiaLogues:3]; "DL_HébergementGroupe")

CLOSE WINDOW:C154($vl_Fenetre)
<>va_GroupeAction:=""

POST OUTSIDE CALL:C329(<>PR_Hébergement)
<>PR_HébergementGpe:=0