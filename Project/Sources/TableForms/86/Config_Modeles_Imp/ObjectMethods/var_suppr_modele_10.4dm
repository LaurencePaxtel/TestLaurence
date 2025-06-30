Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_10)
		
		CLEAR VARIABLE:C89(var_strc_nom_10)
		CLEAR VARIABLE:C89(var_strc_nom_suite_10)
		
		CLEAR VARIABLE:C89(var_strc_adresse_10)
		CLEAR VARIABLE:C89(var_strc_telephone_10)
		CLEAR VARIABLE:C89(var_strc_email_10)
		
		CLEAR VARIABLE:C89(var_strc_logo_10)
		
		CLEAR VARIABLE:C89(var_strc_pied_10_1)
		CLEAR VARIABLE:C89(var_strc_pied_10_2)
		CLEAR VARIABLE:C89(var_strc_pied_10_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_10_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_10_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_10)
		CLEAR VARIABLE:C89(var_strc_bic_10)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_10)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 