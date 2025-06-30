//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : DébutInitReportAuto  
//{          Jeudi 24 février 2011 à 18:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283(vl_ColPage)
C_TEXT:C284(va_ColDefinition)
va_ColDefinition:=$2
vl_ColPage:=$3


C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(466; 202; 16; $1; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_Colonnes")
CLOSE WINDOW:C154($vl_Fenetre)
