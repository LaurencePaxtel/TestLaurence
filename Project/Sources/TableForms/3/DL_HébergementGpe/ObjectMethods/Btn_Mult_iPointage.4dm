Case of 
	: (Form event code:C388=Sur clic:K2:4)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
		// On ne créé que des fiches nuits avec le bouton multi-pointage
		vb_IDT_JN:=True:C214
		
		$vl_Fenetre:=Open form window:C675([DiaLogues:3]; "DL_Multi_Pointage"; Form fenêtre standard:K39:10; À gauche:K39:2; En haut:K39:5)
		DIALOG:C40([DiaLogues:3]; "DL_Multi_Pointage")
		
		CLOSE WINDOW:C154($vl_Fenetre)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 