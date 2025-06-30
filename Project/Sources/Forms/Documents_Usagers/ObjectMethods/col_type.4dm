C_TEXT:C284($position_t)
C_OBJECT:C1216($table_o; $autreTable_o)

If (Size of array:C274(col_type)>0)
	$table_o:=ds:C1482.Base_documentaire.query("DOC_Origine_ID is :1"; [HeBerge:4]HB_ReferenceID:1).orderBy("DOC_Document_Nom asc")
	
	// Modifié par : Scanu Rémy (21/04/2021)
	// Modification d'un type de document
	$autreTable_o:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Type Document Upload")
	
	If ($autreTable_o.length=1)
		$autreTable_o:=outilsOrdaSearch($autreTable_o; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
		USE ENTITY SELECTION:C1513($autreTable_o)
		
		LOAD RECORD:C52([TAbles:12])
		MultiSoc_Filter(->[TAbles:12])
		
		$autreTable_o:=Create entity selection:C1512([TAbles:12])
		
		$position_t:="center"
		outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $autreTable_o.toCollection("TB_Texte").extract("TB_Texte"; "type"); \
			"property"; "type"; "selectSubTitle"; "Merci de sélectionner un type de document"; "title"; "Choix du type du document :"))
		
		If (selectValue_t#"")
			READ WRITE:C146([Base_documentaire:90])
			QUERY:C277([Base_documentaire:90]; [Base_documentaire:90]ID:1=$table_o[col_type-1].ID)
			
			[Base_documentaire:90]DOC_Document_Type:3:=selectValue_t
			SAVE RECORD:C53([Base_documentaire:90])
		End if 
		
		SET TIMER:C645(-1)
	Else 
		ALERT:C41("La liste d'énumération \"Type Document Upload\" n'a pas pu être trouver, merci de la créer pour pouvoir continuer")
	End if 
	
End if 