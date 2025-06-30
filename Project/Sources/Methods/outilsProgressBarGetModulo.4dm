//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Rémy Scanu
// Date et heure : 09/11/22, 14:25:52
// ----------------------------------------------------
// Méthode : outilsProgressBarGetModulo
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Integer
var $1 : Integer

Case of 
	: ($1>1000)
		$0:=Round:C94($1/100; 0)
	: ($1>=50) & ($1<=100)
		$0:=Round:C94($1/10; 0)
	: ($1>=10) & ($1<50)
		$0:=Round:C94($1/5; 0)
	Else 
		$0:=Round:C94($1/2; 0)
End case 