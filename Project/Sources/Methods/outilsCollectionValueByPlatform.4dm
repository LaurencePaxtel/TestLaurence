//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 17/07/23, 17:41:31
// ----------------------------------------------------
// Méthode : outilsCollectionValueByPlatform
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Object
var $2 : Collection

var $plateforme_t : Text
var $char_el; $charArobase_el : Integer
var $stop_b : Boolean

$1.result:=$1.value
$charArobase_el:=Character code:C91(Char:C90(Arobase:K15:46))

For each ($plateforme_t; $2) Until ($stop_b=True:C214)
	
	For ($i_el; 1; Length:C16($plateforme_t))
		$char_el:=Character code:C91($plateforme_t[[$i_el]])
		$stop_b:=($char_el=$charArobase_el)
	End for 
	
End for each 

If ($stop_b=False:C215)
	
	Case of 
		: (Value type:C1509($1.result)=Est un objet:K8:27)
			
			If ($2.indexOf(Substring:C12($1.value.value; 1; 2))<0)
				$1.result.value:="valueToDelete"
			End if 
			
		: ($2.indexOf(Substring:C12($1.value; 1; 2))<0)
			$1.result:="valueToDelete"
	End case 
	
End if 