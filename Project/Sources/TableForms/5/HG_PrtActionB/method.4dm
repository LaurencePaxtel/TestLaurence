C_OBJECT:C1216($table_o; $enregistrement_o; $element_o)

Case of 
	: (Form event code:C388=Sur chargement:K2:1) | (Form event code:C388=Sur impression corps:K2:18)
		$table_o:=ds:C1482.PARAM.query("type = :1 AND valeur = :2 AND structureRef = :3"; "*IMPRESSION"; "Impression B34"; <>ref_soc_active)
		
		If ($table_o.length=1)
			$enregistrement_o:=$table_o.first()
			
			For each ($element_o; $enregistrement_o.extraParam.detail)
				OBJECT SET VISIBLE:C603(*; $element_o.champ+"@"; $element_o.visible)
			End for each 
			
		End if 
		
End case 