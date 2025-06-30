Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_6)
		
		CLEAR VARIABLE:C89(var_strc_nom_6)
		CLEAR VARIABLE:C89(var_strc_nom_suite_6)
		
		CLEAR VARIABLE:C89(var_strc_adresse_6)
		CLEAR VARIABLE:C89(var_strc_telephone_6)
		CLEAR VARIABLE:C89(var_strc_email_6)
		
		CLEAR VARIABLE:C89(var_strc_logo_6)
		
		CLEAR VARIABLE:C89(var_strc_pied_6_1)
		CLEAR VARIABLE:C89(var_strc_pied_6_2)
		CLEAR VARIABLE:C89(var_strc_pied_6_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_6_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_6_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_6)
		CLEAR VARIABLE:C89(var_strc_bic_6)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_6)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 