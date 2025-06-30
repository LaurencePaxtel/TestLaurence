Class extends DataClass

local Function searchAndCreateRecordIfDontExist($privilege_t : Text)->$privilege_e : cs:C1710.PrivilegeEntity
	var $statut_o : Object
	
	var $privilege_es : cs:C1710.PrivilegeSelection
	
	$privilege_es:=ds:C1482.Privilege.query("nom = :1"; $privilege_t)
	
	Case of 
		: ($privilege_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($privilege_es.length=1)
			$privilege_e:=$privilege_es[0]
		Else   // Création de la fiche [Privilege]
			$privilege_e:=ds:C1482.Privilege.new()
			
			$privilege_e.nom:=$privilege_t
			$statut_o:=$privilege_e.save()
			
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			
	End case 