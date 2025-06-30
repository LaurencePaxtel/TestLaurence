//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 01/02/24, 18:08:03
// ----------------------------------------------------
// Méthode : outilsWebGetParamValue
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text
var $2 : Pointer
var $3 : Pointer

var $chaine_t : Text

$chaine_t:=$1

outilsCollectionInit($2; $3)

While (Position:C15("="; $chaine_t)>0)
	$2->push(Substring:C12($chaine_t; 0; Position:C15("="; $chaine_t)-1))
	$chaine_t:=Substring:C12($chaine_t; Position:C15("="; $chaine_t)+1)
	
	If (Position:C15("&"; $chaine_t)>0)  // Il y a encore plusieurs value de params dans la chaine
		$3->push(Substring:C12($chaine_t; 0; Position:C15("&"; $chaine_t)-1))
		$chaine_t:=Substring:C12($chaine_t; Position:C15("&"; $chaine_t)+1)
	Else   // C'est la dernière value d'un param de la chaine 
		$3->push($chaine_t)
	End if 
	
End while 