//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 01/09/22, 17:58:33
// ----------------------------------------------------
// Méthode : outilsManageReservation
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $dateDebut_d : Date
var $statut_o : Object

var $hebergement_e; $hebergementB_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

var $centreLits_e : cs:C1710.CentresLitsEntity
var $centreLits_es : cs:C1710.CentresLitsSelection

$hebergement_e:=ds:C1482.HeberGement.get(Num:C11(w_visiteur.hebergementID))

If ($hebergement_e#Null:C1517)
	$dateDebut_d:=$hebergement_e.HG_Date-($hebergement_e.HG_NuitenCours-1)
	
	$hebergement_es:=ds:C1482.HeberGement.query("HG_FamClé = :1 AND HG_RéservationDateFin = :2"; $hebergement_e.HG_FamClé; $hebergement_e.HG_RéservationDateFin)
	outilsOrdaSearchByRefStctre(->$hebergement_es; w_visiteur.Ref_Structure)
	
	For each ($hebergementB_e; $hebergement_es)
		
		If ($hebergementB_e.HG_Date-($hebergementB_e.HG_NuitenCours-1)=$dateDebut_d)
			$centreLits_es:=$hebergementB_e.HG_LC_ID_4_LC_RéférenceID.LC_RéférenceID_8_CL_LC_ID.query("CL_Date = :1"; $hebergementB_e.HG_Date)  // Tous les enregistrements [CentresLits] pour le centre de l'hébergement à la date de l'hébergement
			
			For each ($centreLits_e; $centreLits_es)
				
				If ($centreLits_e.CL_Restant#0)
					$centreLits_e.CL_Restant:=0
					$statut_o:=$centreLits_e.save()
				End if 
				
			End for each 
			
		End if 
		
	End for each 
	
	
End if 

WEB SEND TEXT:C677("Vrai")