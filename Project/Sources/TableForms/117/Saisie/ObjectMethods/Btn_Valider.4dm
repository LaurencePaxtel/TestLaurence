// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 08/07/2020, 08:02:32
// ----------------------------------------------------
// Method: [Financeurs].Saisie1.Btn_Valider
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Is new record:C668([Financeurs:117]))
			MultiSoc_Init_Structure(->[Financeurs:117])
		End if 
		
		SAVE RECORD:C53([Financeurs:117])
		
		SAVE RECORD:C53([Adresses:53])
		
		ACCEPT:C269
		
		
End case 
