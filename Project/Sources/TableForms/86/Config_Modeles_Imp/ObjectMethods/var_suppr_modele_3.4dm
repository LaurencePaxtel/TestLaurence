Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_3)
		
		CLEAR VARIABLE:C89(var_strc_nom_3)
		CLEAR VARIABLE:C89(var_strc_nom_suite_3)
		
		CLEAR VARIABLE:C89(var_strc_adresse_3)
		CLEAR VARIABLE:C89(var_strc_telephone_3)
		CLEAR VARIABLE:C89(var_strc_email_3)
		
		CLEAR VARIABLE:C89(var_strc_logo_3)
		
		CLEAR VARIABLE:C89(var_strc_pied_3_1)
		CLEAR VARIABLE:C89(var_strc_pied_3_2)
		CLEAR VARIABLE:C89(var_strc_pied_3_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_3_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_3_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_3)
		CLEAR VARIABLE:C89(var_strc_bic_3)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_3)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 