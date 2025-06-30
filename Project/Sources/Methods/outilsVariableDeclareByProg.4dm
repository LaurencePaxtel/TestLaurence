//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 21/12/22, 17:33:26
// ----------------------------------------------------
// Méthode : outilsVariableDeclareByProg
// Description
// Nom commande(89) = EFFACER VARIABLE
// Nom commande(284) = C_TEXTE
// Nom commande(285) = C_RÉEL
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Boolean
var ${3} : Text

var $i_el : Integer

For ($i_el; 3; Count parameters:C259)
	
	Case of 
		: ($1=Est un texte:K8:3)  // C_TEXTE
			Formula from string:C1601("C_TEXTE:C284("+${$i_el}+")").call()
		: ($1=Est un numérique:K8:4)  // C_REEL
			Formula from string:C1601("C_REEL:C285("+${$i_el}+")").call()
	End case 
	
	If ($2=True:C214)  // EFFACER VARIABLE
		Formula from string:C1601("EFFACER VARIABLE:C89("+${$i_el}+")").call()
	End if 
	
End for 