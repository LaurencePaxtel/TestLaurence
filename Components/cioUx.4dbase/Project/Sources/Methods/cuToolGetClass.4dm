//%attributes = {"shared":true,"preemptive":"capable"}
/*------------------------------------------------------------------------------
Méthode : cuToolGetClass

Renvoie une class vers la base hôte.

Historique
12/04/22 - Grégory Fromain <gregory@connect-io.fr> - Import du composant cioWeb
------------------------------------------------------------------------------*/

// Déclarations
var $1 : Text  // Nom de la classe à renvoyer.
var $0 : Object  // Objet de la class


ASSERT:C1129($1#""; "La variable $1 est vide.")

$1:=Uppercase:C13(Substring:C12($1; 1; 1))+Substring:C12($1; 2)

$0:=cs:C1710[$1]