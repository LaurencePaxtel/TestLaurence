// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 07/09/2020, 08:06:22
// ----------------------------------------------------
// Method: [SOciete].SO_EcranSaisie.btn_ged_parcourir
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		[SOciete:18]SO_Chemin_GED:96:=Select folder:C670("Sélectionner le dossier pour le stockage des documents")
		
End case 