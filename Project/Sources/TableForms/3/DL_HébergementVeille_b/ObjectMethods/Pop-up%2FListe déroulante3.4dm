Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(plageEnCoursDebutPEC; 7)
		
		outilsManagePopupDateGenerique(1; ->plageEnCoursDebutPEC)
	: (Form event code:C388=Sur clic:K2:4)
		outilsManagePopupDateGenerique(2; ->plageEnCoursDebutPEC; ->vDateDebutPECDu; ->vDateDebutPECAu)
End case 