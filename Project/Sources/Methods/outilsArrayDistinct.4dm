//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 14/04/23, 18:23:54
// ----------------------------------------------------
// Méthode : outilsArrayDistinct
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Pointer

var $collection_c : Collection

$collection_c:=New collection:C1472
ARRAY TO COLLECTION:C1563($collection_c; $1->)

$collection_c:=$collection_c.distinct()
COLLECTION TO ARRAY:C1562($collection_c; $1->)