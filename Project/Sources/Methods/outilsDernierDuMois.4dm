//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 29/07/21, 16:21:45
// ----------------------------------------------------
// Méthode : outilsDernierDuMois
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_DATE:C307($0)
C_DATE:C307($1)

If (Month of:C24($1)=Décembre:K10:12)
	$0:=Date:C102("01/01/"+String:C10(Year of:C25($1)+1))-1
Else 
	$0:=Date:C102("01/"+String:C10(Month of:C24($1)+1)+"/"+String:C10(Year of:C25($1)))-1
End if 