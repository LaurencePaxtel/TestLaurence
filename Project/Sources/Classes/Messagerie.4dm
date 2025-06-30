Class extends DataClass

Function createEntityAppMobileImportDataNote($date_d : Date; $utilisateur_t : Text; $texte_t : Text; $refStructure_t : Text)->$messagerie_e : cs:C1710.MessagerieEntity
	var $nomPrenom_c : Collection
	
	var $intervenant_es : cs:C1710.InterventionSelection
	
	$nomPrenom_c:=Split string:C1554($utilisateur_t; " ")
	
	$intervenant_es:=ds:C1482.INtervenants.newSelection()
	
	If ($nomPrenom_c.length>0)
		$intervenant_es:=ds:C1482.INtervenants.query("IN_Nom = :1 AND Ref_Structure = :2"; $nomPrenom_c[0]; $refStructure_t)
		
		If ($intervenant_es.length>1) & ($nomPrenom_c.length>1)
			$intervenant_es:=$intervenant_es.query("IN_Prénom = :1"; $nomPrenom_c[1])
		End if 
		
	End if 
	
	$messagerie_e:=ds:C1482.Messagerie.new()
	$messagerie_e.MS_User:=-1
	
	If ($intervenant_es.length>0)
		$messagerie_e.MS_User:=$intervenant_es.first().IN_RéférenceID
	End if 
	
	$messagerie_e.MS_RéférenceID:=Uut_Numerote(->[Messagerie:34])
	$messagerie_e.MS_Date:=$date_d
	$messagerie_e.MS_Heure:=Current time:C178
	$messagerie_e.MS_Texte:=$texte_t
	$messagerie_e.MS_Catégorie:="Import appli mobile"
	$messagerie_e.Ref_Structure:=$refStructure_t
	
	$statut_o:=$messagerie_e.save()
	
Function createRecord($date_d : Date; $intervenantID_el : Integer; $hebergeID_el : Integer; $groupe_t : Text; $priorite_el : Integer; $message_t : Text; $refStructure_t : Text)->$messagerie_e : cs:C1710.MessagerieEntity
	var $intervenant_e : cs:C1710.INtervenantsEntity
	
	$messagerie_e:=ds:C1482.Messagerie.new()
	$intervenant_e:=ds:C1482.INtervenants.get($intervenantID_el)
	
	$messagerie_e.MS_User:=-1
	
	If ($intervenant_e#Null:C1517)
		$messagerie_e.MS_User:=$intervenant_e.IN_RéférenceID
		$messagerie_e.intervenantID:=$intervenant_e.ID
	End if 
	
	$messagerie_e.hebergeID:=$hebergeID_el
	
	$messagerie_e.MS_Date:=$date_d
	$messagerie_e.MS_Heure:=Current time:C178
	
	$messagerie_e.MS_Groupe:=$groupe_t
	$messagerie_e.priorite:=$priorite_el
	$messagerie_e.MS_Texte:=$message_t
	$messagerie_e.Ref_Structure:=$refStructure_t
	$messagerie_e.MS_RéférenceID:=Uut_Numerote(->[Messagerie:34])
	
	$statut_o:=$messagerie_e.save()
	
Function modifyRecord($id_t : Text; $date_d : Date; $intervenantID_el : Integer; $hebergeID_el : Integer; $groupe_t : Text; $priorite_el : Integer; $message_t : Text; $refStructure_t : Text)->$messagerie_e : cs:C1710.MessagerieEntity
	var $intervenant_e : cs:C1710.INtervenantsEntity
	
	$messagerie_e:=ds:C1482.Messagerie.get($id_t)
	
	If ($messagerie_e=Null:C1517)
		return 
	End if 
	
	$intervenant_e:=ds:C1482.INtervenants.get($intervenantID_el)
	
	$messagerie_e.MS_User:=-1
	
	If ($intervenant_e#Null:C1517)
		$messagerie_e.MS_User:=$intervenant_e.IN_RéférenceID
		$messagerie_e.intervenantID:=$intervenant_e.ID
	End if 
	
	$messagerie_e.hebergeID:=$hebergeID_el
	
	$messagerie_e.MS_Date:=$date_d
	$messagerie_e.MS_Heure:=Current time:C178
	
	$messagerie_e.MS_Groupe:=$groupe_t
	$messagerie_e.priorite:=$priorite_el
	$messagerie_e.MS_Texte:=$message_t
	$messagerie_e.Ref_Structure:=$refStructure_t
	
	$statut_o:=$messagerie_e.save()