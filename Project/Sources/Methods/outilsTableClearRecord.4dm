//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 21/03/23, 17:17:16
// ----------------------------------------------------
// Méthode : outilsTableClearRecord
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Boolean
var ${2} : Pointer

var $i_el : Integer
var $table_p : Pointer

If ($1=True:C214)  // On souhaite libérer les enregistrements de toutes les tables
	
	For ($i_el; 1; Get last table number:C254)
		
		If (Is table number valid:C999($i_el)=True:C214)  // Le numéro sur lequel je suis en train de boucler est un numéro de table valide
			$table_p:=Table:C252($i_el)
			UNLOAD RECORD:C212($table_p->)
		End if 
		
	End for 
	
Else   // On souhaite libérer les enregistrements de quelques tables ciblées
	
	For ($i_el; 2; Count parameters:C259)
		$table_p:=${$i_el}
		UNLOAD RECORD:C212($table_p->)
	End for 
	
End if 