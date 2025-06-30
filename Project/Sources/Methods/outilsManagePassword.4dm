//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 20/02/24, 16:26:03
// ----------------------------------------------------
// Méthode : outilsManagePassword
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Boolean
var $1 : Integer  // Point d'entrée
var $2 : Integer  // ID de l'intervenant
var $3 : Text  // Mot de passe

var $intervenant_e : cs:C1710.INtervenantsEntity

Case of 
	: ($1=1)  // Check si le mot de passe $3 est bien celui de l'intervenant $2
		outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]ID:16; $2; ->$intervenant_e; "first")
		
		If ($intervenant_e#Null:C1517)
			$0:=Verify password hash:C1534($3; $intervenant_e.IN_HashPassword)
		End if 
		
End case 