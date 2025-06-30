var $textToCopy_t : Text

$textToCopy_t:=outilsCollectionExportToCnt(Form:C1466.passageGlobal_c; New collection:C1472("cle"; "etatCivil"; "numSejour"; "dateDebut"; "dateFin"; "nbNuit"; "nbNuitReference"; "dateSortie"; "motifSortie"; "service"; "centre"))

SET TEXT TO PASTEBOARD:C523($textToCopy_t)
ALERT:C41("Le contenu du tableau a bien été copié, vous pouvez le coller dans excel ou bloc-note par exemple")