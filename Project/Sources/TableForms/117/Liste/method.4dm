Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		
		C_BOOLEAN:C305(STRC_Champ_Indexation; STRC_Var_Indexation)
		
		STRC_Champ_Indexation:=False:C215
		STRC_Var_Indexation:=False:C215
		
		READ ONLY:C145([Structures:79])
		READ ONLY:C145([SOciete:18])
		
		ALL RECORDS:C47([Structures:79])
		ALL RECORDS:C47([SOciete:18])
		
		If (Records in selection:C76([Structures:79])=1) & (Records in selection:C76([SOciete:18])=1)
			If (([Structures:79]Ref_Structure:3#"") & ([Structures:79]Ref_Structure:3#"TMP") & ([Structures:79]STRC_Indexation:7=False:C215))
				STRC_Champ_Indexation:=True:C214
			End if 
		End if 
		
		ARRAY LONGINT:C221(tb_strc_soc_id; 0)
		ARRAY TEXT:C222(tb_strc_soc_nom; 0)
		
		SELECTION TO ARRAY:C260([SOciete:18]ID:94; tb_strc_soc_id; [SOciete:18]SO_Libel00:2; tb_strc_soc_nom)
		
End case 

