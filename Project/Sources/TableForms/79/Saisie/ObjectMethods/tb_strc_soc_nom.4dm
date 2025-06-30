C_LONGINT:C283($pos)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET ENABLED:C1123(Self:C308->; ([Structures:79]Ref_Structure:3#"TMP") & ([Structures:79]Ref_Structure:3#""))
		
		Case of 
			: ([Structures:79]STRC_Societe_ID:6#0) & ([Structures:79]Ref_Structure:3#"TMP")
				QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
				
				$pos:=Find in array:C230(tb_strc_soc_nom; [SOciete:18]SO_Libel00:2)
				
				If ($pos>0)
					Self:C308->:=$pos
					Self:C308->{0}:=[SOciete:18]SO_Libel00:2
				End if 
				
			: ([Structures:79]STRC_Societe_ID:6#0) & ([Structures:79]Ref_Structure:3="TMP")
				ARRAY TEXT:C222(tb_strc_soc_nom; 0)
				ARRAY LONGINT:C221(tb_strc_soc_id; 0)
				
				APPEND TO ARRAY:C911(tb_strc_soc_id; [SOciete:18]ID:94)
				APPEND TO ARRAY:C911(tb_strc_soc_nom; [SOciete:18]SO_Libel00:2)
				
				$pos:=Find in array:C230(tb_strc_soc_nom; [SOciete:18]SO_Libel00:2)
				
				If ($pos>0)
					Self:C308->:=$pos
					Self:C308->{0}:=[SOciete:18]SO_Libel00:2
				End if 
				
		End case 
		
	: (Form event code:C388=Sur clic:K2:4)
		$pos:=Find in array:C230(tb_strc_soc_nom; tb_strc_soc_nom{tb_strc_soc_nom})
		
		If ($pos>0)
			[Structures:79]STRC_Societe_ID:6:=tb_strc_soc_id{$pos}
		End if 
		
End case 