//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/05/22, 16:02:11
// ----------------------------------------------------
// Méthode : outilsHGGetRecordCloseC(o)n(se)cutive
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : cs:C1710.HeberGementSelection
var $1 : cs:C1710.HeberGementEntity

var $stop_b : Boolean
var $date_d : Date

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

$0:=ds:C1482.HeberGement.newSelection()
$0.add($1)

$date_d:=$1.HG_Date
$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date >= :2"; $1.HG_HB_ID; $1.HG_Date)

For each ($hebergement_e; $hebergement_es) Until ($stop_b)
	$date_d:=Add to date:C393($date_d; 0; 0; 1)
	
	If ($hebergement_e.indexOf($hebergement_es)>0)
		$stop_b:=($hebergement_e.HG_Date#$date_d) | ($hebergement_e.HG_Cloturée=False:C215)
		
		If ($stop_b=False:C215)
			$0.add($hebergement_e)
		End if 
		
	End if 
	
End for each 