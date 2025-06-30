Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_1)
		
		CLEAR VARIABLE:C89(var_strc_nom_1)
		CLEAR VARIABLE:C89(var_strc_nom_suite_1)
		
		CLEAR VARIABLE:C89(var_strc_adresse_1)
		CLEAR VARIABLE:C89(var_strc_telephone_1)
		CLEAR VARIABLE:C89(var_strc_email_1)
		
		CLEAR VARIABLE:C89(var_strc_logo_1)
		
		CLEAR VARIABLE:C89(var_strc_pied_1_1)
		CLEAR VARIABLE:C89(var_strc_pied_1_2)
		CLEAR VARIABLE:C89(var_strc_pied_1_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_1_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_1_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_1)
		CLEAR VARIABLE:C89(var_strc_bic_1)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_1)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 