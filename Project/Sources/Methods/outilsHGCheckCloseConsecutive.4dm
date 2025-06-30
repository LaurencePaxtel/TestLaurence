//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 16/05/22, 16:48:48
// ----------------------------------------------------
// Méthode : outilsHGCheckCloseConsecutive
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Object
var $1 : Integer  // ID Hébergé
var $2 : Integer  // Nb de jours consécutifs début
var $3 : Integer  // Nb de jours consécutifs fin
var $4 : Date  // Date début
var $5 : Date  // Date fin

var $nbJourConsecutif_el : Integer
var $stop_b : Boolean

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es; $hebergementB_es : cs:C1710.HeberGementSelection

$nbJourConsecutif_el:=1

$0:=ds:C1482.HeberGement.newSelection()
$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID is :1"; $1)

If ($4#!00-00-00!)
	$hebergement_es:=$hebergement_es.query("HG_Date >= :1"; $4)
End if 

If ($5#!00-00-00!)
	$hebergement_es:=$hebergement_es.query("HG_Date <= :1"; $5)
End if 

$hebergement_es:=$hebergement_es.orderBy("HG_Date asc")
$stop_b:=($2<=1) & ($hebergement_es.query("HG_Cloturée = :1"; True:C214).length=0)  // Pas de fiches cloturées

For each ($hebergement_e; $hebergement_es) Until ($stop_b=True:C214)
	$hebergementB_es:=outilsHGGetRecordCloseCncutive($hebergement_e)
	
	If ($hebergementB_es.length>=$2) & ($hebergementB_es.length<=$3)
		$0:=$0.or($hebergementB_es)
	End if 
	
End for each 