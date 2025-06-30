//%attributes = {}
//Procédure : i_InfoPurge
SET MENU BAR:C67(1)
C_TEXT:C284(va_Info1)
C_TEXT:C284(va_Info2)
va_Info1:="Bouton"
va_Info2:="Action du bouton"

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(527; 341; 5; "Info Purge"; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_PurgeInfo")
CLOSE WINDOW:C154($vl_Fenetre)