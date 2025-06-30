//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 22/02/24, 17:20:31
// ----------------------------------------------------
// Méthode : outilsCollectionExportToCnt
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var $1 : Collection
var $2 : Collection

var $contentExtract_c : Collection

$contentExtract_c:=$1.map("outilsCollectionValueToCntCSV"; $2)
$0:=$contentExtract_c.join(Char:C90(Retour à la ligne:K15:40); ck ignore null or empty:K85:5)