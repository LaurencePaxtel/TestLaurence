//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 08/12/23, 16:53:50
// ----------------------------------------------------
// Méthode : outilsWebHebergementExit
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $autreSolution_t : Text
var $modif_b : Boolean
var $retour_o; $statut_o : Object

var $hebergement_e; $hebergementB_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

$retour_o:=New object:C1471

outilsOrdaSearchSimple(->[HeberGement:5]; ->[HeberGement:5]ID:168; Num:C11(w_visiteur.id); ->$hebergement_e; "first")

If ($hebergement_e=Null:C1517)
	$retour_o.notificationError:="La fiche hébergement dont vous souhaitez effectuer la « Sortie » n'a pas pu être trouvée dans la base de donnée, la page va se recharger."
Else 
	$hebergement_e.HG_NuitReste:=0
	$hebergement_e.HG_RéservationDateFin:=F_RéservationDateFin($hebergement_e.HG_Date; $hebergement_e.HG_NuitReste)
	
	$autreSolution_t:=$hebergement_e.HG_AutreSolutio
	$statut_o:=$hebergement_e.save()
	
	// Modifié par : Scanu Rémy (25/04/2023)
	$modif_b:=ds:C1482.HeberGement.reportMotifSortie($hebergement_e.ID; $autreSolution_t; $hebergement_e.HG_DateSortie)
	
	If ($modif_b=False:C215)
		$retour_o.notificationError:="Le motif de sortie "+$autreSolution_t+" n'a pas pu être reporté à la fiche de la veille"
	End if 
	
	If ($retour_o.notificationError=Null:C1517)
		
		If (String:C10(w_visiteur.sortieTousMembresFamille)="true")
			$hebergement_es:=ds:C1482.HeberGement.query("HG_Date = :1 AND HG_FamClé = :2 AND HG_HB_ID # :3"; $hebergement_e.HG_Date; $hebergement_e.HG_FamClé; $hebergement_e.HG_HB_ID)
			
			If ($hebergement_es.length>0)
				
				For each ($hebergementB_e; $hebergement_es)
					$hebergementB_e.HG_DateSortie:=$hebergement_e.HG_DateSortie
					$hebergementB_e.HG_AutreSolutio:=$autreSolution_t
					
					$hebergementB_e.HG_Réservation:=False:C215
					$hebergementB_e.HG_Cloturée:=$hebergement_e.HG_Cloturée
					
					If (String:C10(w_visiteur.societeCHRS)="true")
						
						If ($hebergement_e.HG_Nuit=False:C215)
							
							If ($hebergement_e.HG_NuitenCours>0)
								$hebergementB_e.HG_NuitTOTAL:=$hebergement_e.HG_NuitenCours
							Else 
								$hebergementB_e.HG_NuitTOTAL:=1
							End if 
							
							$hebergementB_e.HG_NuitReste:=0
							$hebergementB_e.HG_RéservationDateFin:=F_RéservationDateFin($hebergement_e.HG_Date; $hebergement_e.HG_NuitReste)
						End if 
						
					End if 
					
					$statut_o:=$hebergementB_e.save()
					
					// Modifié par : Scanu Rémy (25/04/2023)
					$modif_b:=ds:C1482.HeberGement.reportMotifSortie($hebergementB_e.ID; $hebergementB_e.HG_AutreSolutio; $hebergement_e.HG_DateSortie)
					
					If ($modif_b=True:C214)
						$hebergementB_e.reload()
						
						$hebergementB_e.HG_AutreSolutio:=""
						$statut_o:=$hebergementB_e.save()
					End if 
					
				End for each 
				
			End if 
			
		End if 
		
	End if 
	
End if 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))