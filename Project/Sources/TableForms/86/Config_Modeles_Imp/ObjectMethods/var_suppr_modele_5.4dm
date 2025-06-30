Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_5)
		
		CLEAR VARIABLE:C89(var_strc_nom_5)
		CLEAR VARIABLE:C89(var_strc_nom_suite_5)
		
		CLEAR VARIABLE:C89(var_strc_adresse_5)
		CLEAR VARIABLE:C89(var_strc_telephone_5)
		CLEAR VARIABLE:C89(var_strc_email_5)
		
		CLEAR VARIABLE:C89(var_strc_logo_5)
		
		CLEAR VARIABLE:C89(var_strc_pied_5_1)
		CLEAR VARIABLE:C89(var_strc_pied_5_2)
		CLEAR VARIABLE:C89(var_strc_pied_5_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_5_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_5_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_5)
		CLEAR VARIABLE:C89(var_strc_bic_5)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_5)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 