//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 12/07/23, 11:15:46
// ----------------------------------------------------
// Méthode : outilsPasswordCheckValid
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text  // Mot de passe
var $2 : Text  // Mot de passe validation
var $3 : Integer  // Nombre de caractère minimale mot de passe
var $4 : Text  // Nom de l'objet qui sert à valider le formulaire

var $motPasse_t; $motPasseValid_t : Text
var $char_el : Integer

$char_el:=Character code:C91("@")

$motPasse_t:=Replace string:C233($1; Char:C90($char_el); "")
$motPasseValid_t:=Replace string:C233($2; Char:C90($char_el); "")

OBJECT SET ENABLED:C1123(*; $4; (Length:C16($motPasse_t)=Length:C16($motPasseValid_t)) & (Length:C16($motPasse_t)>=$3) & ($motPasse_t=$motPasseValid_t))