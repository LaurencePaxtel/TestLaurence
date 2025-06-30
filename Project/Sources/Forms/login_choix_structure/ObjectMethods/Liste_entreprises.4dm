// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 29/08/18, 21:12:38
// ----------------------------------------------------
// Méthode : login_structure.Liste_entreprises
// Description
// 
//
// Paramètres
// ----------------------------------------------------

If (Self:C308->=0)
	If (Size of array:C274(Self:C308->)>0)
		Self:C308->:=1
		BEEP:C151
	End if 
End if 