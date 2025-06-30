//%attributes = {}
/*------------------------------------------------------------------------------
Methode projet : assurNum



Historique
07/01/2021 titouan@connect-io.fr - Création entête
20/04/2022 remy@connect-io.fr - Fix bug paramètre $1 integer -> real
------------------------------------------------------------------------------*/

//Déclaration
var $0 : Real
var $1 : Real
var $2 : Text
var $3 : Real

Case of 
	: (Count parameters:C259=1)
		$0:=Num:C11(String:C10(Round:C94($1; 2); "########0.00"))
	: (Count parameters:C259=2)
		$0:=Num:C11(String:C10(Round:C94($1; 2); $2))
	: (Count parameters:C259=3)
		$0:=Num:C11(String:C10(Round:C94($1; $3); $2))
End case 