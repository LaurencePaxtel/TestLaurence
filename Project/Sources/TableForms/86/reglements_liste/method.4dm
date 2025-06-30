// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/01/20, 20:16:29
// ----------------------------------------------------
// Method: [Factures].reglements_liste
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		txt_titre_fenetre_regl:="Liste des règlements"
		REG_Get_Liste
End case 