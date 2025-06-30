//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/04/23, 17:26:04
// ----------------------------------------------------
// Méthode : outilsVariableAffectValueByProg
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Variant

var $variable_o : Object

Case of 
	: (Value type:C1509($1)=Est une collection:K8:32)
		
		For each ($variable_o; $1)
			Formula from string:C1601($variable_o.name+":="+$variable_o.value).call()
			
/*
Formule sur chaîne("ALERTE:C41(\""+$variable_o.name+" : \"+Chaine:C10("+$variable_o.name+"))").call()
Formule sur chaîne("ALERTE:C41(\""+$variable_o.value+" : \"+Chaine:C10("+$variable_o.value+"))").call()
*/
		End for each 
		
	: (Value type:C1509($1)=Est un objet:K8:27)
		Formula from string:C1601($1.name+":="+$1.value).call()
End case 