Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(plageEnCoursCHRS; 7)
		
		outilsManagePopupDateGenerique(1; ->plageEnCoursCHRS)
	: (Form event code:C388=Sur clic:K2:4)
		outilsManagePopupDateGenerique(2; ->plageEnCoursCHRS; ->vd_Date1; ->vd_Date2)
End case 