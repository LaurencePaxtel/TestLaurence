Case of 
	: (Form event code:C388=Sur clic:K2:4)
		STRC_Create_Societe
		
		$vl_Fenetre:=Open form window:C675([Structures:79]; "Saisie"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4)
		DIALOG:C40([Structures:79]; "Saisie")
		CLOSE WINDOW:C154($vl_Fenetre)
		
		READ ONLY:C145([Structures:79])
		ALL RECORDS:C47([Structures:79])
End case 
