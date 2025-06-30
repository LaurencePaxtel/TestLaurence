//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/03/23, 16:44:56
// ----------------------------------------------------
// Méthode : outilsWebSendData
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer
var $2 : Pointer
var $3 : Variant
var $4 : Pointer

var $json_t : Text
var $data_o; $entity_o : Object
var $data_c : Collection

$data_c:=New collection:C1472
$data_o:=Web_AGL_Get_Post_Json_Data((Count parameters:C259=4))

Case of 
	: (Type:C295($2->)=Est un entier long:K8:6) | (Type:C295($2->)=Est un numérique:K8:4)
		outilsOrdaSearchSimple(Table name:C256($1); Field name:C257($2); Num:C11($data_o.id); ->$entity_o; "first")
	: (Type:C295($2->)=Est un champ alpha:K8:1) | (Type:C295($2->)=Est un texte:K8:3)
		outilsOrdaSearchSimple(Table name:C256($1); Field name:C257($2); String:C10($data_o.id); ->$entity_o; "first")
End case 

If ($entity_o#Null:C1517)
	
	Case of 
		: (Value type:C1509($3)=Est un texte:K8:3)  // Nom du lien entre 2 tables liées
			$data_c:=$entity_o[$3].toCollection()
			$json_t:=JSON Stringify array:C1228($data_c)
		: (Value type:C1509($3)=Est un pointeur:K8:14)  // Nom d'un champ objet de la table $1->
			$json_t:=JSON Stringify:C1217($entity_o[Field name:C257($3)])
	End case 
	
End if 

If (Count parameters:C259=4)
	$4->:=$json_t
Else 
	WEB SEND TEXT:C677($json_t)
End if 