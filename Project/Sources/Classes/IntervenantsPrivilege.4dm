Class extends DataClass

Function searchAndCreateRecordIfDontExist($intervenantID_el : Integer; $privilegeUUID_t : Text)->$intervenantPrivilege_e : cs:C1710.IntervenantsPrivilegeEntity
	var $statut_o : Object
	var $intervenantPrivilege_es : cs:C1710.IntervenantsPrivilegeSelection
	
	$intervenantPrivilege_es:=ds:C1482.IntervenantsPrivilege.query("intervenantID = :1 AND privilegeID = :2"; $intervenantID_el; $privilegeUUID_t)
	
	Case of 
		: ($intervenantPrivilege_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($intervenantPrivilege_es.length=1)
			$intervenantPrivilege_e:=$intervenantPrivilege_es[0]
		Else   // Création de la fiche [IntervenantsPrivilege]
			$intervenantPrivilege_e:=ds:C1482.IntervenantsPrivilege.new()
			
			$intervenantPrivilege_e.intervenantID:=$intervenantID_el
			$intervenantPrivilege_e.privilegeID:=$privilegeUUID_t
			$statut_o:=$intervenantPrivilege_e.save()
			
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			
	End case 