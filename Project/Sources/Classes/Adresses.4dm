Class extends DataClass

Function searchAndCreateRecordIfDontExist($recordID_el : Integer; $tableID_el : Integer; $refStructure_t : Text)->$adresse_e : cs:C1710.AdressesEntity
	var $statut_o : Object
	
	var $adresse_es : cs:C1710.AdressesSelection
	
	$adresse_es:=ds:C1482.Adresses.query("AD_ID_Origine = :1 AND AD_ID_Table_Origine = :2 AND Ref_Structure = :3"; $recordID_el; $tableID_el; $refStructure_t)
	
	Case of 
		: ($adresse_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($adresse_es.length=1)
			$adresse_e:=$adresse_es[0]
		Else   // Création de la fiche [Adresses]
			$adresse_e:=ds:C1482.Adresses.new()
			
			$adresse_e.AD_ID_Origine:=$recordID_el
			$adresse_e.AD_ID_Table_Origine:=$tableID_el
			$adresse_e.Ref_Structure:=$refStructure_t
			
			$statut_o:=$adresse_e.save()
			
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			
	End case 