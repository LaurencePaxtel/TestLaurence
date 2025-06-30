//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 05/06/24, 15:44:04
// ----------------------------------------------------
// Méthode : outilsWebManageFactureAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $retour_o : Object

var $centre_e : cs:C1710.LesCentresEntity
var $location_es : cs:C1710.LocationsSelection

$retour_o:=New object:C1471

Case of 
	: (String:C10(w_visiteur.action)="getCentre")
		$retour_o.notificationError:="Aucun bien loué n'a pu être trouvé"
		$location_es:=ds:C1482.Locations.query("LOC_HB_ID = :1"; Num:C11(w_visiteur.hebergeID)).orderBy("LOC_Date desc")
		
		If ($location_es.length>0)
			$centre_e:=ds:C1482.LesCentres.get($location_es[0].LOC_Bien_ID)
			
			If ($centre_e#Null:C1517)
				$retour_o.fac_bien_nom:=$centre_e.LC_Nom
				$retour_o.fac_bien_id:=String:C10($centre_e.ID)
			End if 
			
		End if 
		
		If ($retour_o.fac_bien_id#Null:C1517)
			OB REMOVE:C1226($retour_o; "notificationError")
		End if 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))