//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 13/07/22, 18:31:38
// ----------------------------------------------------
// Méthode : _cioTest
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $statut_o : Object

var $hebergement_es : cs:C1710.HeberGementSelection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection


/*$fileName_t:=Sélectionner document(""; ".csv"; "Sélection du fichier CSV à ouvrir"; Utiliser fenêtre feuille)

Si ($fileName_t#"")
$file_f:=Fichier(Document; fk chemin plateforme)
$ligne_c:=Séparer chaine($file_f.getText(); Caractère(Retour chariot)+Caractère(Retour à la ligne))

$lengthMax_el:=$ligne_c.length
$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)

outilsProgressBar(0; "Initialisation"; Vrai)

Pour chaque ($ligne_t; $ligne_c) Jusque (progressBar_el=0)

Si ($i_el%$moduloProgress_el=0)
outilsProgressBar($i_el/$lengthMax_el; "Reconstruction du champ Ref_Structure dans la table [HeBerge]..."; Vrai)
Fin de si 

$collection_c:=Séparer chaine($ligne_t; ";")

Si ($collection_c.length=2)
$heberge_e:=ds.HeBerge.get(Num($collection_c[1]))

Si ($heberge_e#Null)

Au cas ou 
: ($heberge_e.Ref_Structure#$collection_c[0])
$heberge_e.Ref_Structure:=$collection_c[0]
$statut_o:=$heberge_e.save()
: ($heberge_e.Ref_Structure="ADA")
$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID

Si ($hebergement_es.length>0)
$heberge_e.Ref_Structure:=$hebergement_es[0].Ref_Structure
$statut_o:=$heberge_e.save()
Fin de si 

Fin de cas 

Fin de si 

Fin de si 

$i_el:=$i_el+1
Fin de chaque 

outilsProgressBar(1; "arrêt")
Fin de si */

outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]Ref_Structure:67; "ADA"; ->$heberge_es)

For each ($heberge_e; $heberge_es)
	$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
	
	If ($hebergement_es.length>0)
		$heberge_e.Ref_Structure:=$hebergement_es[0].Ref_Structure
		$statut_o:=$heberge_e.save()
	End if 
	
End for each 