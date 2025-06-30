//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 23/02/22, 17:13:24
// ----------------------------------------------------
// Méthode : outilsManageCollection
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_VARIANT:C1683($element_v)

For each ($element_v; $2->)
	
	Case of 
		: ($1=1)
			$2->[$2->indexOf($element_v)]:=Num:C11($element_v)
		: ($1=2)
			$2->[$2->indexOf($element_v)]:=String:C10($element_v)
	End case 
	
End for each 