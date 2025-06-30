Class extends DataClass



Function delete($ID_i : Integer; ) : Object
/*------------------------------------------------------------------------------
Fonction : HebergementStatistiqueModele.delete()
	
Suppression d'un modèle.
	
Historique
02/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	var $structure_t : Text
	var $HSM_es : cs:C1710.HebergementStatistiqueModeleSelection
	
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End if 
	
	$HSM_es:=ds:C1482.HebergementStatistiqueModele.query("ID = :1 AND Ref_Structure = :2"; $ID_i; $structure_t)
	
	If ($HSM_es.length=0)
		return {success: False:C215; statusText: "Impossible de retrouver le modèle des statistiques."; data: Null:C1517}
	End if 
	
	$HSM_es:=$HSM_es.drop()
	
	If ($HSM_es.length#0)
		return {success: False:C215; statusText: "Erreur durant la suppression du modele des statistiques."; data: Null:C1517}
	End if 
	
	return {success: True:C214; statusText: "Ok"; data: Null:C1517}
	
	
	
Function list() : Object
/*------------------------------------------------------------------------------
Fonction : HebergementStatistiqueModele.list()
	
Retourne la liste des modèles d'une structure (ID et nom)
	
Historique
02/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	var $structure_t : Text
	var $HSM_es : cs:C1710.HebergementStatistiqueModeleSelection
	
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End if 
	
	$HSM_es:=ds:C1482.HebergementStatistiqueModele.query("Ref_Structure = :1"; $structure_t)
	
	return {success: True:C214; statusText: "Ok"; data: $HSM_es.toCollection("ID, affichageNom")}
	
	
	
Function read($ID_i : Integer) : Object
/*------------------------------------------------------------------------------
Fonction : HebergementStatistiqueModele.read()
	
Retourne toutes les informations d'un modèle.
	
Historique
02/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	var entity_o : Object
	
	entity_o:=ds:C1482.HebergementStatistiqueModele.get($ID_i).toObject()
	entity_o.dataRetour:=JSON Parse:C1218(entity_o.dataRetour)
	
	return entity_o
	
	
	
Function update($ID_i : Integer; $statParam_o : Object) : Object
/*------------------------------------------------------------------------------
Fonction : HebergementStatistiqueModele.update()
	
Ajoute ou modifie un modèle :
si ID = 0, ajout d'un modele
Si ID = inconnu, ajout d'un modele
sinon modification d'un modèle.
	
Historique
02/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	var $structure_t : Text
	var $HSM_es : cs:C1710.HebergementStatistiqueModeleSelection
	var $HSM_e : cs:C1710.HebergementStatistiqueModeleEntity
	var $state_o : Object
	
	If ($statParam_o.affichageNom="")
		return {success: False:C215; statusText: "Le nom du modèle est obligatoire."; data: Null:C1517}
	End if 
	
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End if 
	
	$HSM_es:=ds:C1482.HebergementStatistiqueModele.query("ID = :1"; $ID_i)
	
	If ($HSM_es.length#0)
		$HSM_e:=$HSM_es.first()
	Else 
		$HSM_e:=ds:C1482.HebergementStatistiqueModele.new()
	End if 
	
	$HSM_e.Ref_Structure:=$structure_t
	$HSM_e.affichageNom:=$statParam_o.affichageNom
	$HSM_e.filtreRecherche:=$statParam_o.filtreRecherche
	$HSM_e.dataRetour:=JSON Stringify:C1217($statParam_o.dataRetour)
	$HSM_e.typeGraph:=$statParam_o.typeGraph
	$HSM_e.statistiqueComptage:=$statParam_o.statistiqueComptage
	$HSM_e.statistiqueType:=$statParam_o.statistiqueType
	$HSM_e.statistiqueFicheUnique:=$statParam_o.statistiqueFicheUnique
	$HSM_e.statistiqueFicheEntree:=$statParam_o.statistiqueFicheEntree
	
	$state_o:=$HSM_e.save()
	
	If ($state_o.success=False:C215)
		return {success: False:C215; statusText: "Erreur durant la création du modele des statistiques."; data: Null:C1517}
	End if 
	
	return {success: True:C214; statusText: "Ok"; data: {ID: $HSM_e.ID}}