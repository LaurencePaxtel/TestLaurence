//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 20/12/22, 14:30:56
// ----------------------------------------------------
// Méthode : outilsTableCheckIfFieldExist
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Boolean
var $1 : Variant  // Pointeur de la table OU Nom de la table
var $2 : Text  // Nom du champ à tester

var $field_c : Collection

$field_c:=New collection:C1472

Case of 
	: (Value type:C1509($1)=Est un pointeur:K8:14)
		$field_c:=OB Keys:C1719(ds:C1482[Table name:C256($1)])
	: (Value type:C1509($1)=Est un texte:K8:3)
		$field_c:=OB Keys:C1719(ds:C1482[$1])
End case 

$0:=($field_c.indexOf($2)>=0)