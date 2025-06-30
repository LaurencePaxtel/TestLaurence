// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 10/07/2020, 12:14:43
// ----------------------------------------------------
// Method: [Prise_en_Charge].Saisie_PE.btn_supprimer
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		
		If (i_Confirmer("Confirmez-vous la suppression de cette prise en charge ? "))
			
			DELETE RECORD:C58([Prise_en_Charge:118])
			
			ACCEPT:C269
			
		End if 
		
End case 
