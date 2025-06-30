//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 26/10/18, 21:38:05
// ----------------------------------------------------
// Méthode : Web_JSON_Autres_Criteres
// Description
// 
//
// Paramètres
// ----------------------------------------------------

var $rO_Match : Collection
$rO_Match:=New collection:C1472()

For each ($enumeration_o; Session:C1714.storage.enumeration.query("champNumero IS NOT null").orderBy("libelle"))
	
	$id_critere:="CRI"+Generate UUID:C1066
	$enumWeb_o:=New object:C1471("id"; $id_critere; "value"; $enumeration_o.libelle; "title"; $enumeration_o.libelle; "type"; "checkbox")
	
	var $item_t : Text
	$enumWeb_o.list:=New collection:C1472()
	For each ($item_t; $enumeration_o.item)
		
		$enumWeb_o.list.push({id: "CRV"+Generate UUID:C1066; value: $item_t})
		
	End for each 
	
	$rO_Match.push(OB Copy:C1225($enumWeb_o))
End for each 


$object:={title: "Autres critères"; type: "label"; list: $rO_Match}


$JSON:=JSON Stringify:C1217($object)

WEB SEND TEXT:C677($JSON)