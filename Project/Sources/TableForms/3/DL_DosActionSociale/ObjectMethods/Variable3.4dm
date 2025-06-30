If ([ActionSociale:26]AA_Référence:1>0)
	READ WRITE:C146([ActionSociale:26])
	If (i_NonVerrou(->[ActionSociale:26]))
		FORM SET INPUT:C55([ActionSociale:26]; "AA_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(358; 357; 4; "Actions sociale : modifier"; 3; "")
		MODIFY RECORD:C57([ActionSociale:26]; *)
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
	READ ONLY:C145([ActionSociale:26])
Else 
	StrAlerte(22; "")
End if 