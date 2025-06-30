Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_9)
		
		CLEAR VARIABLE:C89(var_strc_nom_9)
		CLEAR VARIABLE:C89(var_strc_nom_suite_9)
		
		CLEAR VARIABLE:C89(var_strc_adresse_9)
		CLEAR VARIABLE:C89(var_strc_telephone_9)
		CLEAR VARIABLE:C89(var_strc_email_9)
		
		CLEAR VARIABLE:C89(var_strc_logo_9)
		
		CLEAR VARIABLE:C89(var_strc_pied_9_1)
		CLEAR VARIABLE:C89(var_strc_pied_9_2)
		CLEAR VARIABLE:C89(var_strc_pied_9_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_9_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_9_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_9)
		CLEAR VARIABLE:C89(var_strc_bic_9)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_9)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 