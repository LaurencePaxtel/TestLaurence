Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CLEAR VARIABLE:C89(var_modele_nom_7)
		
		CLEAR VARIABLE:C89(var_strc_nom_7)
		CLEAR VARIABLE:C89(var_strc_nom_suite_7)
		
		CLEAR VARIABLE:C89(var_strc_adresse_7)
		CLEAR VARIABLE:C89(var_strc_telephone_7)
		CLEAR VARIABLE:C89(var_strc_email_7)
		
		CLEAR VARIABLE:C89(var_strc_logo_7)
		
		CLEAR VARIABLE:C89(var_strc_pied_7_1)
		CLEAR VARIABLE:C89(var_strc_pied_7_2)
		CLEAR VARIABLE:C89(var_strc_pied_7_3)
		
		CLEAR VARIABLE:C89(var_strc_commentaire_7_1)
		CLEAR VARIABLE:C89(var_strc_commentaire_7_2)
		
		CLEAR VARIABLE:C89(var_strc_iban_7)
		CLEAR VARIABLE:C89(var_strc_bic_7)
		
		CLEAR VARIABLE:C89(var_strc_sans_tva_7)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 