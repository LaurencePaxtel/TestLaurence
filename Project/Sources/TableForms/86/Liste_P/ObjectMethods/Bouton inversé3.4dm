// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25/02/20, 11:11:29
// ----------------------------------------------------
// Method: [Factures].Liste_HB.Bouton inversé3
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (F_PlageEnCours(ve_Date_Cas; -1; ->txt_filtre_date1; ->txt_filtre_date2))
			//FAC_P_Get_Records 
		End if 
		
End case 

