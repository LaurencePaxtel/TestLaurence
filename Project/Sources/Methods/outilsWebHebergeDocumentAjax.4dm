//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 01/06/23, 17:44:01
// ----------------------------------------------------
// Méthode : outilsWebHebergeDocumentAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $retour_o : Object

var $heberge_e : cs:C1710.HeBergeEntity
var $docwpro_es : cs:C1710.DOCWPROSelection

$retour_o:=New object:C1471

outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; Num:C11(w_visiteur.hebergeID); ->$heberge_e; "first")

Case of 
	: (w_visiteur.action="chargeDocument")
		$docwpro_es:=ds:C1482.DOCWPRO.searchWebDocument($heberge_e.Ref_Structure)
		$retour_o.data:=$docwpro_es.toCollection("ID, nom").extract("ID"; "value"; "nom"; "lib").map("outilsCollectionValueToString"; "value")
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))