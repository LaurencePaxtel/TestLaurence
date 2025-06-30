//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 12/02/24, 14:48:55
// ----------------------------------------------------
// Méthode : outilsTableGetFieldDetail
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Collection
var $1 : Variant  // Pointeur de la table OU Nom de la table
var $2 : Boolean  // Indique si on veut les tables exposées seulement (utile pour REST)

var $field_c : Collection

Case of 
	: (Value type:C1509($1)=Est un pointeur:K8:14)
		$field_c:=OB Entries:C1720(ds:C1482[Table name:C256($1)])
	: (Value type:C1509($1)=Est un texte:K8:3)
		$field_c:=OB Entries:C1720(ds:C1482[$1])
End case 

If ($2=True:C214)
	$field_c:=$field_c.query("value.exposed = :1"; True:C214)
End if 

$0:=$field_c.extract("key"; "fieldName"; "value.type"; "type")