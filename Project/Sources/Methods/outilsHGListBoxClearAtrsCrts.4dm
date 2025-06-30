//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 21/12/22, 11:29:16
// ----------------------------------------------------
// Méthode : outilsHGListBoxClearA(u)tr(e)sCr(i)t(ère)sSel(e)ct(ed)
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var ${1} : Pointer

var $i_el; $j_el : Integer

For ($i_el; 1; Count parameters:C259)
	
	For ($j_el; 1; Size of array:C274(${$i_el}->))
		${$i_el}->{$j_el}:=1
	End for 
	
End for 