//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 23/03/21, 12:12:20
// ----------------------------------------------------
// Méthode : outilsAddToArray
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_VARIANT:C1683(${2})

C_LONGINT:C283($i_el)

For ($i_el; 2; Count parameters:C259)
	APPEND TO ARRAY:C911($1->; ${$i_el})
End for 