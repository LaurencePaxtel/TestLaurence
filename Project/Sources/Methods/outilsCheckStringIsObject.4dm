//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 09/02/24, 18:30:04
// ----------------------------------------------------
// Méthode : outilsCheckStringIsObject
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Boolean
var $1 : Text

If (Length:C16($1)>=2)
	$0:=(Substring:C12($1; 0; 1)="{") & (Substring:C12($1; Length:C16($1); 1)="}")
End if 