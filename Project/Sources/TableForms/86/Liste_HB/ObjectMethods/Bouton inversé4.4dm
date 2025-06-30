// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25/02/20, 10:13:21
// ----------------------------------------------------
// Method: [Factures].Liste_HB.Bouton inversé4
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		
		If (F_PlageEnCours(ve_Date_Cas; 1; ->txt_filtre_date1; ->txt_filtre_date2))
			//FAC_Get_Records 
		End if 
		
End case 

