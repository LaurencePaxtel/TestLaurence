var $statut_o : Object

var $structure_e; $structureB_e : cs:C1710.StructuresEntity

var $societe_e : cs:C1710.SOcieteEntity

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var STRC_Champ_Indexation; STRC_Var_Indexation : Boolean
		
		ARRAY TEXT:C222(tb_strc_soc_nom; 0)
		ARRAY LONGINT:C221(tb_strc_soc_id; 0)
		
		STRC_Champ_Indexation:=False:C215
		STRC_Var_Indexation:=False:C215
		
		For each ($societe_e; ds:C1482.SOciete.all())
			
			If ($societe_e.SO_Libel00#"")
				outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]STRC_Societe_ID:6; $societe_e.ID; ->$structure_e; "first")
				outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]Ref_Structure:3; $societe_e.Ref_Structure; ->$structureB_e; "first")
				
				If ($structure_e=Null:C1517) & ($structureB_e=Null:C1517)
					$structure_e:=ds:C1482.Structures.new()
					
					$structure_e.UID:=Generate UUID:C1066
					$structure_e.STRC_Societe_ID:=$societe_e.ID
					$structure_e.Ref_Structure:=$societe_e.Ref_Structure
					$structure_e.STRC_Initiales:=$societe_e.Ref_Structure
					$structure_e.STRC_Nom:=$societe_e.SO_Libel00
					
					$statut_o:=$structure_e.save()
				End if 
				
			End if 
			
			APPEND TO ARRAY:C911(tb_strc_soc_id; $societe_e.ID)
			APPEND TO ARRAY:C911(tb_strc_soc_nom; $societe_e.SO_Libel00)
		End for each 
		
End case 