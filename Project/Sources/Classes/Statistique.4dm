Class extends DataClass

Function checkIfExist($structureID_t : Text; $table_el : Integer; $titre_t : Text)->$statistique_es : cs:C1710.StatistiqueSelection
	
	// Modifié par : Scanu Rémy (02/05/2023)
	// Ajout de la table [Statistique] pour récupérer une recherche déjà faite auparavant
	$statistique_es:=ds:C1482.Statistique.query("structureID = :1"; $structureID_t)
	
	If ($statistique_es.length>0)
		$statistique_es:=$statistique_es.query("table = :1 AND titre = :2"; $table_el; $titre_t)
	End if 