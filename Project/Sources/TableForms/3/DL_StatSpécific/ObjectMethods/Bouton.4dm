var $textToCopy_t : Text
var $hebergement_c : Collection

var $hebergement_es : cs:C1710.HeberGementSelection

$heberge_c:=New collection:C1472

USE SET:C118("E_encours")

$hebergement_es:=Create entity selection:C1512([HeberGement:5])
$hebergement_es:=$hebergement_es.orderBy("HG_HB_ID asc, HG_Date desc")

$hebergement_c:=$hebergement_es.toCollection("HG_HB_ID, HG_Date, HG_FicheNuméro")
$hebergement_c:=$hebergement_c.map("outilsCollectionGetHBCle")

$textToCopy_t:=outilsCollectionExportToCnt($hebergement_c; New collection:C1472("HG_Date"; "HB_Cle"; "HG_FicheNuméro"))

SET TEXT TO PASTEBOARD:C523($textToCopy_t)
ALERT:C41("Le nom, prénom et date de naissance de chaque fiche a bien été copié, vous pouvez coller le contenu dans excel ou bloc-note par exemple")