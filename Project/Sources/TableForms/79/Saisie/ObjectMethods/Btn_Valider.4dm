// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 27/08/18, 11:30:34
// ----------------------------------------------------
// Méthode : [Structures].Saisie.Btn_Valider
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($ref_soc_active_tmp)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If ([Structures:79]STRC_Societe_ID:6#0) | ([Structures:79]UID:1="")
			
			If ([Structures:79]UID:1="")
				[Structures:79]UID:1:=Generate UUID:C1066
			End if 
			
			[Structures:79]Ref_Structure:3:=[Structures:79]STRC_Initiales:2
			
			SAVE RECORD:C53([Structures:79])
			SAVE RECORD:C53([SOciete:18])
			
			READ WRITE:C146([SOciete:18])
			QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
			
			If (Records in selection:C76([SOciete:18])=1)
				
				If ([SOciete:18]Ref_Structure:97="TMP")
					STRC_Var_Indexation:=True:C214
					
					[SOciete:18]Ref_Structure:97:=[Structures:79]Ref_Structure:3
					SAVE RECORD:C53([SOciete:18])
				End if 
				
			End if 
			
			UNLOAD RECORD:C212([SOciete:18])
			READ ONLY:C145([SOciete:18])
			
			If (STRC_Var_Indexation) & ([Structures:79]STRC_Indexation:7=False:C215)
				$ref_soc_active_tmp:=<>ref_soc_active
				
				<>ref_soc_active:=[Structures:79]Ref_Structure:3
				ref_soc_active:=[Structures:79]Ref_Structure:3
				
				Maint_Ref_Structure_All
				
				<>ref_soc_active:=$ref_soc_active_tmp
				ref_soc_active:=$ref_soc_active_tmp
				
				[Structures:79]STRC_Indexation:7:=True:C214
				SAVE RECORD:C53([Structures:79])
			End if 
			
			STRC_Save_Logo([Structures:79]UID:1)
			
			If (<>ref_soc_active="TMP")
				<>ref_soc_active:=[Structures:79]Ref_Structure:3
			End if 
			
			ACCEPT:C269
		Else 
			ALERT:C41("Vous devez sélectionner la société correspondante")
		End if 
		
End case 
