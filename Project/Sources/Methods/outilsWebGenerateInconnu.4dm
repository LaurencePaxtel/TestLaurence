//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 21/06/24, 16:22:23
// ----------------------------------------------------
// Méthode : outilsWebGenerateInconnu
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $retour_o : Object
var $vl_num : Integer

$retour_o:=New object:C1471("etat"; True:C214; "inconnu"; New object:C1471)

$vl_num:=Uut_Numerote(->$vaCPT_inconnu_t)

$retour_o.inconnu.nom:="X0"+Substring:C12(String:C10(Year of:C25(Current date:C33()); "0000"); 3; 2)+String:C10(Month of:C24(Current date:C33()); "00")+"-"+String:C10($vl_num; "00000")

$retour_o.inconnu.prenom:=Session:C1714.storage.intervenant.Ref_Structure
$retour_o.inconnu.dateNaissance:="01/01/1900"

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))