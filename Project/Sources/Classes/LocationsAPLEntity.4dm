Class extends Entity

Function soldeAnneeEnCours()->$solde_r : Real
	var $locationAPL_es : cs:C1710.LocationsAPLSelection
	
	$locationAPL_es:=ds:C1482.LocationsAPL.query("locationID = :1 AND year = :2 AND month <= :3"; This:C1470.locationID; This:C1470.year; This:C1470.month)
	$solde_r:=$locationAPL_es.sum("pay")
	
Function sendMailAPL($solde_r : Real)
	var $civilite_t; $messageBug_t : Text
	var $i_el : Integer
	var $transporter_o; $email_o; $statut_o : Object
	
	var $heberge_e : cs:C1710.HeBergeEntity
	var $heberge_es : cs:C1710.HeBergeSelection
	
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	var $intervenant_e : cs:C1710.INtervenantsEntity
	var $intervenant_es : cs:C1710.INtervenantsSelection
	
	ref_soc_active:=This:C1470.location.Ref_Structure
	SOC_Get_Config
	
	If (SO_Email#"")
		$heberge_es:=ds:C1482.HeBerge.query("ID = :1"; This:C1470.location.LOC_HB_ID)
		$transporter_o:=outilsMailGestion(1)
		
		If ($heberge_es.length>0)
			$heberge_e:=$heberge_es.first()
			$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
			
			For ($i_el; 1; 2)
				
				If ($i_el=1)  // Référent
					
					If (This:C1470.location.LOC_Referent#"")
						$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; This:C1470.location.LOC_Referent)
					Else 
						$intervenant_es:=ds:C1482.INtervenants.query("IN_NomPrénom = :1"; $hebergement_es[0].HG_Permanencier)
					End if 
					
				Else   // Coordinateur
					
					If (This:C1470.location.LOC_Coordinateur#"")
						$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; This:C1470.location.LOC_Coordinateur)
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
							"objet"; "Retard APL location bien "+This:C1470.location.LOC_Bien_Nom; \
							"message"; MAIL_HTML_Generate("Bonjour"; $message_t))
						
						If ($transporter_o.user#"")
							$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
						End if 
						
					Else 
						$messageBug_t:="L'adresse email du "+Choose:C955($i_el=1; "référent"; "coordinateur")+" "+$intervenant_e.IN_NomPrénom+" n'est pas au bon format ("+Choose:C955($intervenant_e.IN_Email#""; "l'email inscrit est le suivant : "+$intervenant_e.IN_Email; "email vide")+")"
					End if 
					
				Else 
					$messageBug_t:="Aucun "+Choose:C955($i_el=1; "référent"; "coordinateur")+" n'a pu être trouvé pour la location du bien "+This:C1470.location.LOC_Bien_Nom+" pour la période "+\
						String:C10(This:C1470.month)+"/"+String:C10(This:C1470.year)+" pour l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+"."
				End if 
				
				If ($messageBug_t#"")
					$messageBug_t:="Structure "+ref_soc_active+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40)+$messageBug_t
					$email_o:=New object:C1471("emetteur"; SO_Email; \
						"destinataire"; "l.phanchi@paxtel.fr"; \
						"cc"; "remy@connect-io.fr"; \
						"objet"; "Bug Réactulisation retard APL (location)"; \
						"message"; $messageBug_t)
					
					$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
				End if 
				
			End for 
			
		End if 
		
	End if 