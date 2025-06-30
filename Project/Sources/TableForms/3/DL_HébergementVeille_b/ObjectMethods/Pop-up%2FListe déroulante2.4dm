Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(plageEnCoursEntree; 7)
		
		outilsManagePopupDateGenerique(1; ->plageEnCoursEntree)
	: (Form event code:C388=Sur clic:K2:4)
		outilsManagePopupDateGenerique(2; ->plageEnCoursEntree; ->vDateAnneeEntreeDu; ->vDateAnneeEntreeAu)
End case 