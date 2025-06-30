Class extends Entity

Function soldeAnneeEnCours()->$solde_r : Real
	var $participation_es : cs:C1710.ParticipationsSelection
	
	$participation_es:=ds:C1482.Participations.query("PAR_HB_ID = :1 AND PAR_Annee = :2 AND PAR_Mois <= :3  AND PAR_participationWebID = 0"; This:C1470.PAR_HB_ID; This:C1470.PAR_Annee; This:C1470.PAR_Mois)
	$solde_r:=$participation_es.sum("PAR_APL_Solde")
	
Function sendMailAPL($solde_r : Real)
	var $civilite_t; $messageBug_t : Text
	var $i_el : Integer
	var $transporter_o; $email_o; $statut_o : Object
	
	var $heberge_e : cs:C1710.HeBergeEntity
	var $heberge_es : cs:C1710.HeBergeSelection
	
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	var $intervenant_e : cs:C1710.INtervenantsEntity
	var $intervenant_es : cs:C1710.INtervenantsSelection
	
	ref_soc_active:=This:C1470.Ref_Structure
	SOC_Get_Config
	
	If (SO_Email#"")
		$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID = :1"; This:C1470.PAR_HB_ID)
		$transporter_o:=outilsMailGestion(1)
		
		If ($heberge_es.length>0)
			$heberge_e:=$heberge_es.first()
			$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
			
			For ($i_el; 1; 2)
				
				If ($i_el=1)  // Référent
					
					If (This:C1470.PAR_Referent#"")
						$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; This:C1470.PAR_Referent)
					Else 
						$intervenant_es:=ds:C1482.INtervenants.query("IN_NomPrénom = :1"; $hebergement_es[0].HG_Permanencier)
					End if 
					
				Else   // Coordinateur
					
					If (This:C1470.PAR_Coordinateur#"")
						$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; This:C1470.PAR_Coordinateur)
					End if 
					
				End if 
				
				If ($intervenant_es.length=1)
					$intervenant_e:=$intervenant_es.first()
					
					If (outilsRegexValidate(1; $intervenant_e.IN_Email)=True:C214)
						$civilite_t:=$heberge_e.civilite()
						$message_t:=Choose:C955($civilite_t#""; $civilite_t+" "; "")+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+" : retard d'APL cumulé de "+String:C10($solde_r; "### ##0.00 €")+" à ce jour."
						
						$email_o:=New object:C1471("emetteur"; SO_Email; \
							"destinataire"; $intervenant_e.IN_Email; \
							"cc"; SO_Email; \
							"objet"; "Retard APL Participations"; \
							"message"; MAIL_HTML_Generate("Bonjour"; $message_t))
						
						If ($transporter_o.user#"")
							$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
						End if 
						
					Else 
						$messageBug_t:="L'adresse email du "+Choose:C955($i_el=1; "référent"; "coordinateur")+" "+$intervenant_e.IN_NomPrénom+" n'est pas au bon format (l'email inscrit est le suivant : "+$intervenant_e.IN_Email+")"
					End if 
					
				Else 
					$messageBug_t:="Aucun "+Choose:C955($i_el=1; "référent"; "coordinateur")+" n'a pu être trouvé pour la participation pour la période "+\
						String:C10(This:C1470.PAR_Mois)+"/"+String:C10(This:C1470.PAR_Annee)+" pour l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+"."
				End if 
				
				If ($messageBug_t#"")
					$messageBug_t:="Structure "+ref_soc_active+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40)+$messageBug_t
					$email_o:=New object:C1471("emetteur"; SO_Email; \
						"destinataire"; "l.phanchi@paxtel.fr"; \
						"cc"; "remy@connect-io.fr"; \
						"objet"; "Bug Réactulisation retard APL"; \
						"message"; $messageBug_t)
					
					$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
				End if 
				
			End for 
			
		End if 
		
	End if 
	
	
	
Function webUpdate($salaire_r : Real; $loyer_r : Real; $apl_r : Real; $ressource_c : Collection; $charge_c : Collection; $forfaitParticipation_r : Real; $totalParticipation_r : Real)->$statut_o : Object
	var $totalRessource_r; $totalCharge_r : Real
	
	This:C1470.participationWeb.salaire:=$salaire_r
	This:C1470.participationWeb.loyer:=$loyer_r
	This:C1470.participationWeb.apl:=$apl_r
	
	This:C1470.participationWeb.ressource:=New object:C1471("detail"; $ressource_c)
	This:C1470.participationWeb.charge:=New object:C1471("detail"; $charge_c)
	
	This:C1470.PAR_Taux:=$forfaitParticipation_r
	This:C1470.PAR_Montant_Participation:=$totalParticipation_r
	
	$totalRessource_r:=This:C1470.salaire+$ressource_c.sum("value")+This:C1470.apl
	$totalCharge_r:=This:C1470.loyer+$charge_c.sum("value")
	
	This:C1470.participationWeb.resteAVivre:=$totalRessource_r-$totalCharge_r
	
	If ($totalRessource_r-This:C1470.apl>0)
		This:C1470.participationWeb.tauxEffortLoyer:=Round:C94((This:C1470.loyer*100)/($totalRessource_r-This:C1470.apl); 2)
	Else 
		This:C1470.participationWeb.tauxEffortLoyer:=0
	End if 
	
	If ($totalRessource_r>0)
		This:C1470.participationWeb.tauxEndettement:=Round:C94(($totalCharge_r*100)/$totalRessource_r; 2)
	Else 
		This:C1470.participationWeb.tauxEndettement:=0
	End if 
	
	$statut_o:=This:C1470.participationWeb.save()
	If ($statut_o.success=False:C215)
		TRACE:C157
	End if 
	
	$statut_o:=This:C1470.save()
	If ($statut_o.success=False:C215)
		TRACE:C157
	End if 