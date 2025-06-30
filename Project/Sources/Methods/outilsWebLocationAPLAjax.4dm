//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 08/03/23, 12:12:54
// ----------------------------------------------------
// Méthode : outilsWebLocationAPLAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $i_el; $mois_el; $annee_el : Integer
var $retour_o; $data_o; $statut_o : Object
var $data_c : Collection

var $location_e : cs:C1710.LocationsEntity

var $locationAPL_e : cs:C1710.LocationsAPLEntity
var $locationAPL_es : cs:C1710.LocationsAPLSelection

$retour_o:=New object:C1471
$location_e:=ds:C1482.Locations.get(Num:C11(w_visiteur.locationID))

Case of 
	: (w_visiteur.action="chargeAPL")
		$locationAPL_es:=$location_e.locationsapls.query("year = :1"; Num:C11(w_visiteur.annee))
		
		If ($locationAPL_es.length=0)
			
			For ($i_el; 1; 12)
				$locationAPL_e:=ds:C1482.LocationsAPL.new()
				
				$locationAPL_e.locationID:=Num:C11(w_visiteur.locationID)
				$locationAPL_e.year:=Num:C11(w_visiteur.annee)
				$locationAPL_e.month:=$i_el
				$locationAPL_e.save()
			End for 
			
			$location_e.reload()
			$locationAPL_es:=$location_e.locationsapls.query("year = :1"; Num:C11(w_visiteur.annee))
		End if 
		
		$retour_o.data:=$locationAPL_es.toCollection()
	: (w_visiteur.action="saveAPL")
		$data_c:=JSON Parse:C1218(w_visiteur.data)
		
		For each ($data_o; $data_c)
			$locationAPL_es:=$location_e.locationsapls.query("year = :1 AND month = :2"; $data_o.year; $data_o.month)
			
			If ($locationAPL_es.length=1)
				$locationAPL_e:=$locationAPL_es[0]
				
				$locationAPL_e.date:=Date:C102($data_o.date)
				$locationAPL_e.pending:=Num:C11(Replace string:C233($data_o.pending; "."; ","))
				$locationAPL_e.receive:=Num:C11(Replace string:C233($data_o.receive; "."; ","))
				$locationAPL_e.pay:=Round:C94($locationAPL_e.receive-$locationAPL_e.pending; 2)
				
				$statut_o:=$locationAPL_e.save()
			End if 
			
		End for each 
		
	: (w_visiteur.action="refreshAPL")
		$mois_el:=Month of:C24(outilsPremierDuMois(Current date:C33)-1)
		$annee_el:=Year of:C25(outilsPremierDuMois(Current date:C33)-1)
		
		$locationAPL_es:=$location_e.locationsapls.query("year = :1 AND month = :2"; $annee_el; $mois_el)
		
		If ($locationAPL_es.length=1)
			$locationAPL_e:=$locationAPL_es.first()
			$solde_r:=$locationAPL_e.soldeAnneeEnCours()
			
			If ($solde_r<0)
				$locationAPL_e.sendMailAPL($solde_r)
			Else 
				$retour_o.notificationWarning:="Le solde n'étant pas inférieur à 0, aucun email n'est envoyé"
			End if 
			
		End if 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))