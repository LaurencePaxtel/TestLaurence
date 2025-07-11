//%attributes = {}

var $statParam_o : Object
var $return_o : Object
$statParam_o:={}
$start:=Milliseconds:C459
$statParam_o.affichageNom:="état civil"  // Nom personnalisé statistique
$statParam_o.filtreRecherche:={}
$statParam_o.filtreRecherche.HG_DateMin:=!2025-01-01!
$statParam_o.filtreRecherche.HG_DateMax:=!2025-05-31!
$statParam_o.filtreRecherche.HG_Cloturée:=True:C214
$statParam_o.filtreRecherche.HG_Nuit:=True:C214
//$statParam_o.filtreRecherche.HG_CentreNom:=["13LGV-HUDA-Accompagnement extérieur"; "13LGV-HUDA-Concertation Partenaire"]
$statParam_o.filtreRecherche.HG_EtatCivil:=["Femme seule (FS)"; "Femme avec 1 enfant (FE)"]  // Item de l'énumération en propriété
$statParam_o.typeGraph:="Bar"  // "Bar" ou "Pie"
$statParam_o.statistiqueFicheUnique:=True:C214
$return_o:=ds:C1482.HeberGement.listeUsager($statParam_o)
$end:=Milliseconds:C459-$start

//test

/*
//[HeberGement]HG_HB_ID
$hebergementB_es:=ds.HeberGement.query("HG_Date >= :1 AND HG_Cloturée = :2 AND Ref_Structure = 'ALL'"; !01/09/2024!; Vrai)

// On recherche tous les états civiles
$tableFusion_es:=ds.TableFusions.query("TF_RéférenceTable = :1 AND TF_Diviseur > :2"; "EtaCv"; 0)
// Filtre par structure
outilsOrdaSearchByRefStctre(->$tableFusion_es)

$tableFusion_c:=$tableFusion_es.toCollection()  // Collection de tous les états civiles
$tableFusionUnique_c:=$tableFusion_c.distinct("TF_Libellé")  // Collection de tous les états civiles fusionnés

Pour chaque ($tableFusionUnique_t; $tableFusionUnique_c)

$tableFusion_es:=ds.TableFusions.query("TF_RéférenceTable = :1 AND TF_Diviseur > :2 AND TF_Libellé = :3"; "EtaCv"; 0; $tableFusionUnique_t)
outilsOrdaSearchByRefStctre(->$tableFusion_es)

$etatCivil_c:=$tableFusion_es.toCollection("TF_LibelléOrigine").extract("TF_LibelléOrigine")
$hebergement_es:=$hebergementB_es.query("HG_EtatCivil in :1"; $etatCivil_c)
$hebergementFiche_i:=$hebergement_es.length
$hebergementPersonne_i:=$hebergement_es.distinct("HG_HB_ID").length

Fin de chaque 
*/


// <>ref_soc_active devient Session.storage.intervenant.Ref_Structure
var $Ref_Structure_t : Text
If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

$1->:=$1->query("Ref_Structure = :1"; $Ref_Structure_t)

