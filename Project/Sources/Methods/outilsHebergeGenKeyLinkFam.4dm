//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 06/06/23, 15:55:08
// ----------------------------------------------------
// Méthode : outilsHebergeGen(erate)LinkFam(ily)
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Real
var $1 : Boolean
var $2 : Boolean
var $3 : Integer

var $refStructure_t : Text
var $keyFamLast_r : Real
var $keyFam_c : Collection

var $heberge_es : cs:C1710.HeBergeSelection

$heberge_es:=ds:C1482.HeBerge.all()

If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$refStructure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$refStructure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

outilsOrdaSearchByRefStctre(->$heberge_es; $refStructure_t)

If ($heberge_es.length>0) & ($1=False:C215)
	$keyFam_c:=New collection:C1472
	$keyFam_c:=$heberge_es.toCollection("HB_CléFam").extract("HB_CléFam").distinct()
	
	$keyFam_c:=$keyFam_c.map("outilsCollectionValueToNum").orderBy(ck descending:K85:8)
	$keyFamLast_r:=$keyFam_c[0]
End if 

If ($2=True:C214)
	$0:=$keyFamLast_r+1+$3
Else 
	$0:=$keyFamLast_r+1
End if 