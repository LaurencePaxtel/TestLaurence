//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 23/07/24, 15:41:02
// ----------------------------------------------------
// Méthode : outilsManagePagination
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer  // Numéro de la page
var $2 : Integer  // Nombre de résultat par page
var $3 : Pointer  // Collection ou EntitySelection
var $4 : Object  // [Optionnel] Objet pour le tri de $3

var $from_el; $to_el : Integer

If ($1=0)
	$1:=1
End if 

If ($2=0)
	$to_el:=$3->length
Else 
	$from_el:=(($1-1)*$2)
	$to_el:=$from_el+$2
End if 

If (Count parameters:C259=4)
	$3->:=$3->orderBy(String:C10($4.orderField)+" "+String:C10($4.orderInstruction))
End if 

$3->:=$3->slice($from_el; $to_el)

If (Count parameters:C259=4)
	$3->:=$3->orderBy(String:C10($4.orderField)+" "+String:C10($4.orderInstruction))
End if 