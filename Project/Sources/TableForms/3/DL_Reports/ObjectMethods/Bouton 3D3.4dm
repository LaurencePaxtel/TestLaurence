If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($vl_Fenetre)
	
	$vl_Fenetre:=i_FenêtreNo(357; 399; 1; ""; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_DialTri1")
	
	CLOSE WINDOW:C154($vl_Fenetre)
	
	P_HébergementReportSort
	
	FIRST RECORD:C50([HeberGement:5])
	PREVIOUS RECORD:C110([HeberGement:5])
End if 