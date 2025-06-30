//%attributes = {}
// ======================================================================
// Methode projet : outilsOrdaSearch
// 
// Méthode qui permet de faire une recherche grâce à ORDA entre deux tables liées mais avec aucun lien retour
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 01/04/20 remy@connect-io.fr - Création
	// 13/05/20 remy@connect-io.fr - Ajout de la multiRecherche sur plusieurs champs avec la recherche sur 3 tables
	// 22/05/20 remy@connect-io.fr - Ajout de la recherche lien (sans critère de recherche)
End if 

If (True:C214)  // Déclarations
	C_OBJECT:C1216($0)  // Objet Entity Selection modifié avec les différentes manipulations de l'objet Entity Selection $1
	C_OBJECT:C1216($1)  // Objet Entity Selection (1° table) || OU || Pour une recherche lien (2° table)
	C_TEXT:C284($2)  // Texte qui contient le nom du champ qui relie les tables $1 et $3 (1° table) || OU || Pour une recherche lien clé étrangère de la 2° table
	C_TEXT:C284($3)  // Texte qui contient le nom de la table qui est en lien avec mon Entity Selection (2° table) || OU || Pour une recherche lien (1° table)
	C_TEXT:C284($4)  // Texte qui contient le nom du champ qui doit servir de référence de la table $3 (généralement la clé primaire PK) (2° table) || OU || Pour une recherche lien clé primaire de la 1° table
	C_TEXT:C284($5)  // Texte qui contient le nom du champ de la table $3 ou de la 3° table non nommé directement pour un critère de recherche [optionnel] (2° table OU 3° table)
	C_TEXT:C284($6)  // Texte qui contient le critère de recherche [optionnel] (2° table OU 3° table)
	C_TEXT:C284($7)  // Texte qui contient le nom du lien aller pour faire une recherche sur une 3° table qui est en relation avec la table $3  [optionnel] (3° table)
	C_TEXT:C284($8)  // Texte qui contient le nom du lien retour pour faire une recherche sur une 3° table qui est en relation avec la table $3  [optionnel] (3° table)
	
	C_LONGINT:C283($i_el)
	C_OBJECT:C1216($tableLien_o)
	C_COLLECTION:C1488($cleEtrangere_c)
	
	ARRAY TEXT:C222($champNomRecherche_at; 0)
	ARRAY TEXT:C222($champValeurRecherche_at; 0)
End if 

$cleEtrangere_c:=$1.toCollection($2)
$tableLien_o:=ds:C1482[$3].query($4+" in :1"; $cleEtrangere_c.extract($2))

If (Count parameters:C259=8)  // Recherche ORDA sur 3 tables, la 2° est liée directement avec la 3° & la 1° et 2° non liées directement mais via le champ $2 et $4
	
	If ($5="[@]")
		JSON PARSE ARRAY:C1219($5; $champNomRecherche_at)
		JSON PARSE ARRAY:C1219($6; $champValeurRecherche_at)
		
		For ($i_el; 1; Size of array:C274($champNomRecherche_at))
			$tableLien_o:=$tableLien_o[$7].query($champNomRecherche_at{$i_el}+" = :1"; $champValeurRecherche_at{$i_el})[$8]
		End for 
		
	Else 
		$tableLien_o:=$tableLien_o[$7].query($5+" = :1"; $6)[$8]
	End if 
	
Else   // Recherche ORDA sur 2 tables, la 1° et 2° non liées directement mais via le champ $2 et $4
	
	If (Count parameters:C259>4)
		$tableLien_o:=$tableLien_o.query($5+" = :1"; $6)
	End if 
	
End if 

If (Count parameters:C259>4)
	$cleEtrangere_c:=$tableLien_o.toCollection($4)
	$1:=$1.query($2+" in :1"; $cleEtrangere_c.extract($4))
	
	$0:=$1
Else 
	$0:=$tableLien_o
End if 