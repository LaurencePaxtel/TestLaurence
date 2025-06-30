// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 11/07/2020, 14:18:19
// ----------------------------------------------------
// Method: [Financeurs].Liste_PE.btn_pe_nouveau
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		FORM SET INPUT:C55([Prise_en_Charge:118]; "Saisie_PE")
		
		READ WRITE:C146([Prise_en_Charge:118])
		ADD RECORD:C56([Prise_en_Charge:118])
		
		DIALOG:C40([Prise_en_Charge:118]; "Saisie_PE")
		
		READ ONLY:C145([Prise_en_Charge:118])
		
		QUERY:C277([Prise_en_Charge:118]; [Prise_en_Charge:118]PE_HB_ID:4=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[Prise_en_Charge:118])
		
		
End case 