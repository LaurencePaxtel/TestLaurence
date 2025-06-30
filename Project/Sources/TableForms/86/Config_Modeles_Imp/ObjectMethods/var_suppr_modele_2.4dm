Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_2)
		
		CLEAR VARIABLE:C89(var_strc_nom_2)
		CLEAR VARIABLE:C89(var_strc_nom_suite_2)
		
		CLEAR VARIABLE:C89(var_strc_adresse_2)
		CLEAR VARIABLE:C89(var_strc_telephone_2)
		CLEAR VARIABLE:C89(var_strc_email_2)
		
		CLEAR VARIABLE:C89(var_strc_logo_2)
		
		CLEAR VARIABLE:C89(var_strc_pied_2_1)
		CLEAR VARIABLE:C89(var_strc_pied_2_2)
		CLEAR VARIABLE:C89(var_strc_pied_2_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_2_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_2_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_2)
		CLEAR VARIABLE:C89(var_strc_bic_2)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_2)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 