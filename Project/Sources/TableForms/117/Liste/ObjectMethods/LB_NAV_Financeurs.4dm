// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 09/07/2020, 03:48:41
// ----------------------------------------------------
// Method: [Financeurs].Liste.LB_NAV_Financeurs
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(colonne; ligne; order_max)

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		LISTBOX GET CELL POSITION:C971(LB_NAV_Financeurs; colonne; ligne)
		
		READ WRITE:C146([Financeurs:117])
		GOTO SELECTED RECORD:C245([Financeurs:117]; ligne)
		LOAD RECORD:C52([Financeurs:117])
		
		MODIFY RECORD:C57([Financeurs:117])
		
		READ ONLY:C145([Financeurs:117])
		ALL RECORDS:C47([Financeurs:117])
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($i)
		ARRAY TEXT:C222(ta_FMGrp; 0)
		
		READ ONLY:C145([Financeurs:117])
		
		Début_LoadTables("FM Groupe"; ->ta_FMGrp)
		
		For ($i; 1; Size of array:C274(ta_FMGrp))
			
			If (ta_FMGrp{$i}#"")
				
				QUERY:C277([Financeurs:117]; [Financeurs:117]FIN_Code:4=ta_FMGrp{$i})
				MultiSoc_Filter(->[Financeurs:117])
				
				If (Records in selection:C76([Financeurs:117])=0)
					CREATE RECORD:C68([Financeurs:117])
					MultiSoc_Init_Structure(->[Financeurs:117])
					[Financeurs:117]FIN_Code:4:=ta_FMGrp{$i}
					SAVE RECORD:C53([Financeurs:117])
				End if 
				
			End if 
			
		End for 
		
		READ WRITE:C146([Financeurs:117])
		
		QUERY WITH ARRAY:C644([Financeurs:117]FIN_Code:4; ta_FMGrp)
		CREATE SET:C116([Financeurs:117]; "$enums")
		
		ALL RECORDS:C47([Financeurs:117])
		CREATE SET:C116([Financeurs:117]; "$all")
		
		DIFFERENCE:C122("$all"; "$enums"; "$result")
		USE SET:C118("$result")
		DELETE SELECTION:C66([Financeurs:117])
		
		CLEAR SET:C117("$enums")
		CLEAR SET:C117("$all")
		CLEAR SET:C117("$result")
		
		ALL RECORDS:C47([Financeurs:117])
		
End case 


