// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 11/06/2020, 16:02:54
// ----------------------------------------------------
// Method: [Factures].Config_Modeles_Imp.b_Fermer_Rech_appel
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CANCEL TRANSACTION:C241
		CANCEL:C270
End case 

