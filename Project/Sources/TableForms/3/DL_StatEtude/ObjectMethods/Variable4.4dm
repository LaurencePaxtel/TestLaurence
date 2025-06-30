//Groupe
If (Form event code:C388=Sur clic:K2:4)
	$vl_Fenetre:=i_FenêtreNo(357; 399; 5; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_TabGroupex")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 