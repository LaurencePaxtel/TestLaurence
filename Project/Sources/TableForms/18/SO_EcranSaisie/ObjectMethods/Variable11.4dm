If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($vl_Fenetre)
	vt_CheminRepertoire:=""
	<>tt_T_CheminsRegionaux:=0
	$vl_Fenetre:=i_FenêtreNo(467; 406; 5; "Chemin des dossiers à relever pour le mode régional"; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_RegionalChemins")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 