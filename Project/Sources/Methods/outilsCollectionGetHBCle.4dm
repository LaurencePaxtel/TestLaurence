//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/03/24, 15:22:15
// ----------------------------------------------------
// Méthode : outilsCollectionGetHBCle
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Object

var $heberge_e : cs:C1710.HeBergeEntity

$1.value.HB_Cle:=""
outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; $1.value.HG_HB_ID; ->$heberge_e; "first")

If ($heberge_e#Null:C1517)
	$1.value.HB_Cle:=$heberge_e.HB_Clé
End if 

$1.result:=$1.value