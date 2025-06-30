Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_4)
		
		CLEAR VARIABLE:C89(var_strc_nom_4)
		CLEAR VARIABLE:C89(var_strc_nom_suite_4)
		
		CLEAR VARIABLE:C89(var_strc_adresse_4)
		CLEAR VARIABLE:C89(var_strc_telephone_4)
		CLEAR VARIABLE:C89(var_strc_email_4)
		
		CLEAR VARIABLE:C89(var_strc_logo_4)
		
		CLEAR VARIABLE:C89(var_strc_pied_4_1)
		CLEAR VARIABLE:C89(var_strc_pied_4_2)
		CLEAR VARIABLE:C89(var_strc_pied_4_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_4_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_4_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_4)
		CLEAR VARIABLE:C89(var_strc_bic_4)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_4)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 