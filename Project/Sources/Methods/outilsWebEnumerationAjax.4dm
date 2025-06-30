//%attributes = {"publishedWeb":true,"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/02/24, 14:03:04
// ----------------------------------------------------
// Méthode : outilsWebEnumerationAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $retour_o : Object

var $table_es : cs:C1710.TAblesSelection
var $typeTable_es : cs:C1710.TypesTablesSelection

$retour_o:=New object:C1471

outilsOrdaSearchSimple(->[TypesTables:11]; ->[TypesTables:11]TT_Libellé:4; String:C10(w_visiteur.enumerationLib); ->$typeTable_es)

If ($typeTable_es.length>0)
	$table_es:=outilsOrdaSearch($typeTable_es; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
	outilsOrdaSearchByRefStctre(->$table_es; Session:C1714.storage.intervenant.Ref_Structure)
	
	$retour_o.enumerationItem:=$table_es.toCollection("TB_Texte").extract("TB_Texte").orderBy(ck ascending:K85:9)
End if 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))