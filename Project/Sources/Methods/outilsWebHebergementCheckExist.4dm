//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 07/06/23, 17:28:32
// ----------------------------------------------------
// Méthode : outilsWebHebergementCheckExist
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $retour_o : Object

var $hebergement_es : cs:C1710.HeberGementSelection

$retour_o:=New object:C1471

If (String:C10(w_visiteur.ficheType)="J")
	$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date = :2 AND HG_Nuit = :3"; Num:C11(w_visiteur.hebergeID); Date:C102(w_visiteur.ficheDate); False:C215)
	
	If ($hebergement_es.length>0)
		$retour_o.notificationError:="Une fiche hébergement « Jour » existe déjà pour cet hébergé à la date du "+w_visiteur.ficheDate+", la création de la fiche est impossible !"
	End if 
	
End if 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))