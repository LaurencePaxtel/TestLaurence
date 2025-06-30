// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 03:11:19
// ----------------------------------------------------
// Méthode : Login_utilisateur.Zone de défilement
// Description
// 
//
// Paramètres
// ----------------------------------------------------s
If (Self:C308->=0)
	
	If (Size of array:C274(Self:C308->)>0)
		Self:C308->:=1
		BEEP:C151
	End if 
	
End if 