Class extends DataClass

Function searchAndCreateRecordIfDontExist($structureUUID_t : Text; $intervenantID_el : Integer; $refStructure_t : Text)->$structureUser_e : cs:C1710.Structure_UserEntity
	var $statut_o : Object
	var $structureUser_es : cs:C1710.Structure_UserSelection
	
	$structureUser_es:=ds:C1482.Structure_User.query("UID_Structure = :1 AND UID_Utilisateur = :2"; $structureUUID_t; $intervenantID_el)
	
	Case of 
		: ($structureUser_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($structureUser_es.length=1)
			$structureUser_e:=$structureUser_es[0]
		Else   // Création de la fiche [Structure_User]
			$structureUser_e:=ds:C1482.Structure_User.new()
			
			$structureUser_e.UID_Structure:=$structureUUID_t
			$structureUser_e.UID_Utilisateur:=$intervenantID_el
			$structureUser_e.Ref_Structure:=$refStructure_t
			$statut_o:=$structureUser_e.save()
			
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			
	End case 