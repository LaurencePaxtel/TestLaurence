//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 24/03/21, 09:29:18
// ----------------------------------------------------
// Méthode : outilsTableSorterAddColorRow
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_OBJECT:C1216($1)
C_TEXT:C284($2)

C_TEXT:C284($propriete_t)

If (Num:C11($1.rows.length)>0)
	
	For each ($propriete_t; $1.rows[$1.rows.length-1])
		$1.rows[$1.rows.length-1][$propriete_t]:="<div class=\""+$2+"\">"+$1.rows[$1.rows.length-1][$propriete_t]+"</div>"
	End for each 
	
End if 