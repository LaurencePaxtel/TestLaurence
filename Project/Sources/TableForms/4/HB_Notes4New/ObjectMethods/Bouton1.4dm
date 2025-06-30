Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsManagePopupDate(3; ->dateDu_d; ->dateAu_d; 1)
		
/*Form.changeDate:=Vrai
GÉNÉRER APPEL EXTÉRIEUR(Numéro du process courant)*/
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 