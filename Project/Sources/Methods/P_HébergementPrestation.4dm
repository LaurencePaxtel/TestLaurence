//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementPrestation
//{
//{          Jeudi 3 juin 2004 à 9:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//vl_RéfU_HG  : HÉBÉRGEMENT
//vl_RéfU_HBB : HÉBNERGÉ

C_LONGINT:C283($1)
C_TEXT:C284($2)

C_TEXT:C284($3)
C_TEXT:C284(va_IdentitS)
C_TEXT:C284(va_Origine)
va_Origine:=$3

vl_RéfU_HBB:=$1
va_IdentitS:=$2

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementPrestation")

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(632; 434; 4; "PRESTATIONS"; 11; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3]; *)
UNLOAD RECORD:C212([DiaLogues:3])
READ ONLY:C145([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)