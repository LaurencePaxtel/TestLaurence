//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 08/06/22, 19:02:57
// ----------------------------------------------------
// Méthode : outilsWebSearchFamCle
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $reponse_t : Text
var $tableExport_c : Collection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

$tableExport_c:=New collection:C1472

If (String:C10(w_visiteur.cleLienFamilial)#"")
	$heberge_es:=ds:C1482.HeBerge.query("HB_CléFam = :1"; w_visiteur.cleLienFamilial)
Else 
	$heberge_es:=ds:C1482.HeberGement.query("HG_FamChef = :1 AND HG_FamClé # :2"; True:C214; "").HG_HB_ID_1_HB_ReferenceID
End if 

outilsOrdaSearchByRefStctre(->$heberge_es; w_visiteur.Ref_Structure)
$heberge_es:=$heberge_es.orderBy("HB_Clé asc")

For each ($heberge_e; $heberge_es)
	
	outilsWebPushTableExptListeAjax(->$tableExport_c; \
		String:C10($heberge_e.ID); \
		$heberge_e.HB_Clé; \
		String:C10($heberge_e.HB_CléFam))
	
End for each 

$reponse_t:=JSON Stringify:C1217(New object:C1471("data"; $tableExport_c); *)
WEB SEND TEXT:C677($reponse_t)