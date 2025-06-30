var $entitySelection_es : cs:C1710.GroupeHebergesSelection

$entitySelection_es:=ds:C1482.GroupeHeberges.query("GH_GP_Référence = :1"; [GrouPe:36]GP_ReferenceID:1)
outilsOrdaSearchByRefStctre(->$entitySelection_es)

ve_NbGPGH:=$entitySelection_es.length