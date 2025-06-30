//%attributes = {}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

$vl_Fenetre:=i_FenêtreNo(632; 468; 4; "Solidarité libellés"; 1; "Quit_Simple")

DIALOG:C40([DiaLogues:3]; "DL_Départ_libellés")
CLOSE WINDOW:C154($vl_Fenetre)
<>PR_GenéralLib:=0
