//%attributes = {}
//Procédure : P_HébergéModifier1
C_TEXT:C284($1)
C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(352; 362; 5; "Modifier : "+$1; 4; "Quit_Simple")
DIALOG:C40([DePart:1]; "DP_HébergéModifier")
CLOSE WINDOW:C154($vl_Fenetre)

