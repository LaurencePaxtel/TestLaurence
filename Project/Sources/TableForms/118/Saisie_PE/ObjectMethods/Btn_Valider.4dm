
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		//If (Is new record([Prise_en_Charge]))
		//End if 
		QUERY:C277([Financeurs:117]; [Financeurs:117]FIN_Code:4=tb_pe_financeurs{tb_pe_financeurs})
		MultiSoc_Filter(->[Financeurs:117])
		
		If (Records in selection:C76([Financeurs:117])=1)
			[Prise_en_Charge:118]PE_Financeur_ID:3:=[Financeurs:117]ID:1
		End if 
		
		
		
		SAVE RECORD:C53([Prise_en_Charge:118])
		
		ACCEPT:C269
		
		
End case 
