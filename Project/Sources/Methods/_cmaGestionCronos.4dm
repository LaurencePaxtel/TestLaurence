//%attributes = {"shared":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Rémy Scanu
// Date et heure : 17/09/21, 16:50:05
// ----------------------------------------------------
// Méthode : _cmaGestionCronos
// Description
// Permet d'intérargir avec le formulaire cronos du
// composant cioMarketingAuto
// Paramètres
// ----------------------------------------------------
var $1 : Integer

var $civilite_t; $refSocActive_t; $message_t; $messageBug_t : Text
var $process_el : Integer
var $solde_r : Real
var $sendEmail_b : Boolean
var $transporter_o; $email_o : Object

var $event_e : cs:C1710.EventsEntity
var $event_es : cs:C1710.EventsSelection

var $hebergeAlerte_e : cs:C1710.HebergeAlerteEntity
var $hebergeAlerte_es : cs:C1710.HebergeAlerteSelection

var $heberge_e : cs:C1710.HeBergeEntity

var $eventDetail_es : cs:C1710.Events_DetailsSelection

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

var $participation_e : cs:C1710.ParticipationsEntity
var $participation_es : cs:C1710.ParticipationsSelection

var $locationAPL_e : cs:C1710.LocationsAPLEntity
var $locationAPL_es : cs:C1710.LocationsAPLSelection

Case of 
	: ($1=1)  // Gestion des process journaliers
		
		If (Value type:C1509(ref_soc_active)#Est une variable indéfinie:K8:13) && (ref_soc_active#"")
			$refSocActive_t:=ref_soc_active
		End if 
		
		$transporter_o:=outilsMailGestion(1)
		$event_es:=ds:C1482.Events.query("EVE_Date_Du > :1 OR EVE_Date_Au < :1 AND EVE_HB_ID in :2"; Current date:C33; ds:C1482.HebergeAlerte.all().toCollection("hebergeReferenceID").extract("hebergeReferenceID"))
		
		For each ($event_e; $event_es)
			ref_soc_active:=$event_e.Ref_Structure
			SOC_Get_Config
			
			If (SO_Email#"")
				$hebergeAlerte_es:=ds:C1482.HebergeAlerte.query("hebergeReferenceID = :1"; $event_e.EVE_HB_ID)
				
				For each ($hebergeAlerte_e; $hebergeAlerte_es)
					
					If ($event_e.EVE_Date_Du>Current date:C33)
						
						For each ($propriete_t; $hebergeAlerte_e.alerteRappelAvantEcheance) Until ($sendEmail_b=True:C214)
							
							If ($hebergeAlerte_e.alerteRappelAvantEcheance[$propriete_t]=True:C214)
								$sendEmail_b:=(Current date:C33=($event_e.EVE_Date_Du-Num:C11($propriete_t)))
							End if 
							
						End for each 
						
					End if 
					
					If ($event_e.EVE_Date_Au<Current date:C33)
						$sendEmail_b:=($hebergeAlerte_e.alerteStop=False:C215) & ($hebergeAlerte_e.alerteRappelApresEcheance=True:C214)
					End if 
					
					$heberge_e:=$hebergeAlerte_e.OneHeberge
					
					If ($sendEmail_b=True:C214)
						
						If ($heberge_e#Null:C1517)
							$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
							$eventDetail_es:=$event_e.AllEventsDetails
							
							If ($eventDetail_es.length>0)
								$intervenant_es:=ds:C1482.INtervenants.query("ID = :1"; $eventDetail_es.first().EVD_User_ID)
							Else 
								$intervenant_es:=ds:C1482.INtervenants.query("IN_NomPrénom = :1"; $hebergement_es[0].HG_Permanencier)
							End if 
							
							If ($intervenant_es.length=1)
								$intervenant_e:=$intervenant_es.first()
								
								If (outilsRegexValidate(1; $intervenant_e.IN_Email)=True:C214)
									
									If ($hebergement_es.length>0)
										$civilite_t:=Choose:C955($hebergement_es[0].HG_EtatCivil="@Homme@"; "Monsieur"; "Madame")
									End if 
									
									$message_t:="Rappel : « "+$hebergeAlerte_e.OneCentre.LC_AlerteNom+" » doit être effectué pour "+Choose:C955($civilite_t#""; $civilite_t+" "; "")+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+" avant le "+Choose:C955($event_e.EVE_Date_Du<Current date:C33; String:C10($event_e.EVE_Date_Du); String:C10($event_e.EVE_Date_Au))+\
										" soit dans "+Choose:C955($event_e.EVE_Date_Du>Current date:C33; String:C10(outilsGetNbJour($event_e.EVE_Date_Du; Current date:C33)); "- "+String:C10(outilsGetNbJour($event_e.EVE_Date_Au; Current date:C33)))+" jour(s)"
									
									$email_o:=New object:C1471("emetteur"; SO_Email; \
										"destinataire"; $intervenant_e.IN_Email; \
										"cc"; SO_Email; \
										"objet"; "Rappel alerte"; \
										"message"; MAIL_HTML_Generate("Bonjour"; $message_t))
									
									If ($transporter_o.user="")
										$transporter_o:=outilsMailGestion(1)
									End if 
									
									If ($transporter_o.user#"")
										$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
									End if 
									
								Else 
									$messageBug_t:="L'adresse email de l'intervenant "+$intervenant_e.IN_NomPrénom+" n'est pas au bon format (l'email inscrit est le suivant : "+$intervenant_e.IN_Email+")"
								End if 
								
							Else 
								$messageBug_t:="Aucun(e) intervenant(e) n'a pu être trouvé(e) pour le rendez-vous du "+String:C10($event_e.EVE_Date_Du)+" au "+String:C10($event_e.EVE_Date_Au)+" pour l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+"."
							End if 
							
						End if 
						
					End if 
					
					If ($messageBug_t#"")
						$messageBug_t:="Structure "+<>ref_soc_active+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40)+$messageBug_t
						
						$email_o:=New object:C1471("emetteur"; SO_Email; \
							"destinataire"; "l.phanchi@paxtel.fr"; \
							"cc"; "remy@connect-io.fr"; \
							"objet"; "Bug Rappel alerte"; \
							"message"; $messageBug_t)
						
						$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
					End if 
					
					outilsCleanVariable(->$civilite_t; ->$messageBug_t; ->$sendEmail_b)
				End for each 
				
			End if 
			
		End for each 
		
		// Modifié par : Scanu Rémy (30/12/2022)
		If (Current date:C33=outilsDernierDuMois(Current date:C33))  // Si on est le dernier du mois en cours
			// On recherche toutes les participations du mois
			$participation_es:=ds:C1482.Participations.query("PAR_Annee = :1 AND PAR_Mois = :2  AND PAR_participationWebID = 0"; Year of:C25(Current date:C33); Month of:C24(Current date:C33))
			
			For each ($participation_e; $participation_es)
				$solde_r:=$participation_e.soldeAnneeEnCours()
				
				If ($solde_r<0)
					$participation_e.sendMailAPL($solde_r)
				End if 
				
			End for each 
			
			// Modifié par : Scanu Rémy (08/03/2023)
			// On recherche toutes les locations du mois
			$locationAPL_es:=ds:C1482.LocationsAPL.query("year = :1 AND month = :2"; Year of:C25(Current date:C33); Month of:C24(Current date:C33))
			
			For each ($locationAPL_e; $locationAPL_es)
				$solde_r:=$locationAPL_e.soldeAnneeEnCours()
				
				If ($solde_r<0)
					$locationAPL_e.sendMailAPL($solde_r)
				End if 
				
			End for each 
			
		End if 
		
		If ($refSocActive_t#"")
			ref_soc_active:=$refSocActive_t
		End if 
		
		// Modifié par : Scanu Rémy (27/10/2023)
		$process_el:=Execute on server:C373("outilsManageSynchroAppMobile"; 0; "synchronisationApplicationMobile"; 1; *)
		
		// Modifié par : Scanu Rémy (08/03/2024)
		$process_el:=Execute on server:C373("outilsCronosPaxtel"; 0; "cronosPaxtel"; 1; *)
End case 