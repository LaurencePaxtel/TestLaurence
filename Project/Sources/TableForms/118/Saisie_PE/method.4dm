Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_TEXT:C284(var_hb_nom_prenom)
		ARRAY TEXT:C222(tb_pe_financeurs; 0)
		C_LONGINT:C283($pos)
		
		ALL RECORDS:C47([Financeurs:117])
		MultiSoc_Filter(->[Financeurs:117])
		
		SELECTION TO ARRAY:C260([Financeurs:117]FIN_Code:4; tb_pe_financeurs)
		
		var_hb_nom_prenom:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4
		
		READ ONLY:C145([Financeurs:117])
		QUERY:C277([Financeurs:117]; [Financeurs:117]ID:1=[Prise_en_Charge:118]PE_Financeur_ID:3)
		MultiSoc_Filter(->[Financeurs:117])
		
		$pos:=Find in array:C230(tb_pe_financeurs; [Financeurs:117]FIN_Code:4)
		
		If ($pos>0)
			tb_pe_financeurs:=$pos
			tb_pe_financeurs{0}:=[Financeurs:117]FIN_Code:4
		End if 
		
		If (Is new record:C668([Prise_en_Charge:118]))
			
			MultiSoc_Init_Structure(->[Prise_en_Charge:118])
			[Prise_en_Charge:118]PE_HB_ID:4:=[HeBerge:4]HB_ReferenceID:1
			[Prise_en_Charge:118]PE_Date_du:5:=Current date:C33
			[Prise_en_Charge:118]PE_Date_au:6:=Add to date:C393(Current date:C33; 0; 1; 0)
			
		End if 
		
		
End case 
