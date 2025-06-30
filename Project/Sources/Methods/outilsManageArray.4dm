//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 27/08/21, 14:25:53
// ----------------------------------------------------
// Méthode : outilsManageArray
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($i_el)

For ($i_el; 1; Size of array:C274($2->))
	
	Case of 
		: ($1=1)
			APPEND TO ARRAY:C911($3->; Num:C11($2->{$i_el}))
		: ($1=2)
			APPEND TO ARRAY:C911($3->; String:C10(($2->{$i_el})))
	End case 
	
End for 