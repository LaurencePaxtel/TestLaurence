Class extends DataClass

Function searchAndCreateRecordIfDontExist($hebergeReferenceID_el : Integer; $annee_el : Integer; $mois_el : Integer; $refStructure_t : Text)->$participation_e : cs:C1710.ParticipationsEntity
	var $statut_o : Object
	
	var $participation_es : cs:C1710.ParticipationsSelection
	
	$participation_es:=ds:C1482.Participations.query("PAR_HB_ID = :1 AND PAR_Annee = :2 AND PAR_Mois = :3 AND PAR_participationWebID = 0"; $hebergeReferenceID_el; $annee_el; $mois_el; $refStructure_t)
	
	Case of 
		: ($participation_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($participation_es.length=1)
			$participation_e:=$participation_es[0]
		Else   // Création de la fiche [Participations]
			$participation_e:=ds:C1482.Participations.new()
			
			$participation_e.PAR_Annee:=$annee_el
			$participation_e.PAR_Mois:=$mois_el
			$participation_e.PAR_HB_ID:=$hebergeReferenceID_el
			$participation_e.PAR_Extra:=New object:C1471
			$participation_e.Ref_Structure:=$refStructure_t
			$participation_e.PAR_Menage:="1"
			
			$statut_o:=$participation_e.save()
	End case 
	
	
Function searchAndCreateRecordIfDontExistWeb($hebergeID_el : Integer; $annee_el : Integer; $mois_el : Integer; $salaire_r : Real; $loyer_r : Real; $apl_r : Real; $ressource_c : Collection; $charge_c : Collection; $commentaire_t : Text; $nbPersonneMenage_el : Integer; $refStructure_t : Text)->$Participations_e : cs:C1710.ParticipationsEntity
	var $totalRessource_r; $totalCharge_r : Real
	var $participations_es : cs:C1710.ParticipationsSelection
	
	$participations_es:=ds:C1482.Participations.query("PAR_HB_ID = :1 AND PAR_Annee = :2 AND PAR_Mois = :3 AND PAR_participationWebID # 0"; ds:C1482.HeBerge.get($hebergeID_el).HB_ReferenceID; $annee_el; $mois_el)
	
	Case of 
		: ($participations_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
			
		: ($participations_es.length=1)
			$Participations_e:=$participations_es.first()
			
		Else   // Création de la fiche [ParticipationsWebBudget]
			$ParticipationWeb_e:=ds:C1482.ParticipationWeb.new()
			$ParticipationWeb_e.salaire:=$salaire_r
			$ParticipationWeb_e.loyer:=$loyer_r
			$ParticipationWeb_e.apl:=$apl_r
			$ParticipationWeb_e.charge:=New object:C1471("detail"; $charge_c)
			$ParticipationWeb_e.ressource:=New object:C1471("detail"; $ressource_c)
			
			$totalRessource_r:=$salaire_r+$charge_c.sum("value")+$apl_r
			$totalCharge_r:=$loyer_r+$ressource_c.sum("value")
			$ParticipationWeb_e.resteAVivre:=$totalRessource_r-$totalCharge_r
			
			If ($totalRessource_r-$apl_r>0)
				$ParticipationWeb_e.tauxEffortLoyer:=Round:C94(($loyer_r*100)/($totalRessource_r-$apl_r); 2)
			End if 
			
			If ($totalRessource_r>0)
				$ParticipationWeb_e.tauxEndettement:=Round:C94(($totalCharge_r*100)/$totalRessource_r; 2)
			End if 
			
			$ParticipationWeb_e.commentaire:=$commentaire_t
			$ParticipationWeb_e.nbPersonneMenage:=($nbPersonneMenage_el=0) ? 1 : $nbPersonneMenage_el
			$state_o:=$ParticipationWeb_e.save()
			If ($state_o.success=False:C215)
				TRACE:C157
			End if 
			
			$Participations_e:=ds:C1482.Participations.new()
			$Participations_e.PAR_HB_ID:=ds:C1482.HeBerge.get($hebergeID_el).HB_ReferenceID
			$Participations_e.PAR_Annee:=$annee_el
			$Participations_e.PAR_Mois:=$mois_el
			//$Participations_e.PAR_Taux:=$ParticipationsWebBudget_e.forfaitParticipation
			//$Participations_e.PAR_Montant_Participation:=$ParticipationsWebBudget_e.totalParticipation
			$Participations_e.Ref_Structure:=$refStructure_t
			$Participations_e.PAR_participationWebID:=$ParticipationWeb_e.ID
			$state_o:=$Participations_e.save()
			If ($state_o.success=False:C215)
				TRACE:C157
			End if 
	End case 