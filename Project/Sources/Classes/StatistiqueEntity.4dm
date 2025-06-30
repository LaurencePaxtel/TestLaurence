Class extends Entity

Function init($structureID_t : Text; $table_el : Integer; $titre_t : Text)
	var $statut_o : Object
	
	This:C1470.structureID:=$structureID_t
	This:C1470.table:=$table_el
	This:C1470.titre:=$titre_t
	
	$statut_o:=This:C1470.save()
	
Function getData($entree_el : Integer)->$resultat_v : Variant
	var $sauvegarde_t : Text
	
	ARRAY OBJECT:C1221($data_ao; 0)
	
	Case of 
		: ($entree_el=1)  // Statistique séjour
			
			// Obliger de rechercher par méthode classique car on ne peut pas encore manipuler des blob dans les entity...
			QUERY:C277([Statistique:133]; [Statistique:133]UID:2=This:C1470.UID)
			
			If (BLOB size:C605([Statistique:133]sauvegarde:5)>0)
				$sauvegarde_t:=Convert to text:C1012([Statistique:133]sauvegarde:5; "UTF-8")
				JSON PARSE ARRAY:C1219($sauvegarde_t; $data_ao)
			End if 
			
			$resultat_v:=New collection:C1472
			ARRAY TO COLLECTION:C1563($resultat_v; $data_ao)
	End case 
	
Function saveData($entree_el : Integer; $data_v : Variant)->$sauvegarde_b : Blob
	ARRAY OBJECT:C1221($data_ao; 0)
	
	Case of 
		: ($entree_el=1)  // Statistique séjour
			COLLECTION TO ARRAY:C1562($data_v; $data_ao)
			CONVERT FROM TEXT:C1011(JSON Stringify array:C1228($data_ao); "UTF-8"; $sauvegarde_b)
			
			// Obliger de rechercher par méthode classique car on ne peut pas encore manipuler des blob dans les entity...
			QUERY:C277([Statistique:133]; [Statistique:133]UID:2=This:C1470.UID)
			
			[Statistique:133]sauvegarde:5:=$sauvegarde_b
			[Statistique:133]ts:4:=outilsTimeStamp(Current date:C33; Current time:C178)
			SAVE RECORD:C53([Statistique:133])
	End case 