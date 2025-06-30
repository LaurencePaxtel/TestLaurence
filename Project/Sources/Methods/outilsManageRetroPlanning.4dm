//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 05/09/22, 17:47:13
// ----------------------------------------------------
// Méthode : outilsManageRetroPlanning
// Description
// 
//
// Paramètres
// ----------------------------------------------------

//Todo: GF
// "publishedWeb": false le 14/10/24 par GF

var $0 : Text

var $plateforme_t; $alerteAvantEcheance_t; $property_t : Text
var $i_el; $index_el; $id_el : Integer
var $stop_b; $useGlobalParam_b : Boolean
var $retour_o; $keyValue_o; $hebergement_o; $transporter_o; $email_o : Object
var $keyValue_c; $index_c : Collection

var $centre_e : cs:C1710.LesCentresEntity
var $centre_es : cs:C1710.LesCentresSelection

var $hebergeAlerte_e : cs:C1710.HebergeAlerteEntity
var $hebergeAlerte_es; $hebergeAlerteB_es : cs:C1710.HebergeAlerteSelection

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

var $event_e : cs:C1710.EventsEntity
var $event_es : cs:C1710.EventsSelection

var $eventDetail_e : cs:C1710.Events_DetailsEntity

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

var $heberge_e : cs:C1710.HeBergeEntity

ARRAY TEXT:C222($values_at; 0)

$retour_o:=New object:C1471

Case of 
	: (w_visiteur.action="getService")
		$retour_o.service:=New collection:C1472
		
		$centre_es:=ds:C1482.LesCentres.query("LC_AlerteWeb = :1"; True:C214)
		outilsOrdaSearchByRefStctre(->$centre_es; w_visiteur.Ref_Structure)
		
		$values_c:=UTL_Web_Get_Enumeration_Values("FM Groupe")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $values_at)
		End if 
		
		
		For each ($centre_e; $centre_es)
			
			For ($i_el; 1; Size of array:C274($values_at))
				
				If (Position:C15($centre_e.LC_Plateforme; $values_at{$i_el})>0)
					
					If ($retour_o.service.indexOf($values_at{$i_el})=-1)
						$retour_o.service.push($values_at{$i_el})
						$i_el:=Size of array:C274($values_at)
					Else 
						$i_el:=Size of array:C274($values_at)
					End if 
					
				End if 
				
			End for 
			
		End for each 
		
	: (w_visiteur.action="getAlertByService")
		$retour_o.rows:=New collection:C1472
		
		$values_c:=UTL_Web_Get_Enumeration_Values("FM Groupe")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $values_at)
		End if 
		
		$pos_el:=Find in array:C230($values_at; w_visiteur.service)
		
		$plateforme_t:=Substring:C12($values_at{$pos_el}; 1; 2)
		$centre_es:=ds:C1482.LesCentres.query("LC_AlerteWeb = :1 AND LC_Plateforme = :2"; True:C214; $plateforme_t)
		
		For each ($centre_e; $centre_es)
			$hebergeAlerte_es:=$centre_e.AllHebergeAlerte.query("hebergeReferenceID = :1"; Num:C11(w_visiteur.hebergeReferenceID))
			$useGlobalParam_b:=($hebergeAlerte_es.length=0)
			
			If ($useGlobalParam_b=True:C214)
				$keyValue_c:=OB Entries:C1720($centre_e.LC_AlerteRappelAvantEcheance)
				$alerteAvantEcheance_t:="<div class=\"rowB g-mx-0\">"
				
				For each ($keyValue_o; $keyValue_c)
					$alerteAvantEcheance_t:=$alerteAvantEcheance_t+"<div class=\"col\"><input id=\"checkbox"+String:C10($keyValue_c.indexOf($keyValue_o))+"_"+String:C10($centre_e.ID)+"\" type=\"checkbox\""+Choose:C955(Bool:C1537($keyValue_o.value)=True:C214; " checked"; "")+" /></div>"
				End for each 
				
				$alerteAvantEcheance_t:=$alerteAvantEcheance_t+"</div>"
				
				$retour_o.rows.push(New object:C1471(\
					"id"; String:C10($centre_e.ID); \
					"lc_dateReference"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_dateReference_"+String:C10($centre_e.ID)+"\" class=\"g-width-150\" type=\"date\" value=\""+outilsGetDateInput(Current date:C33(*))+"\" /></div></div>"; \
					"lc_alerteNom"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><p>"+$centre_e.LC_AlerteNom+"</p><input type=\"hidden\" name=\"centreID\" value=\""+String:C10($centre_e.ID)+"\" /></div></div>"; \
					"lc_alerteDelai"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_alerteDelai_"+String:C10($centre_e.ID)+"\" class=\"g-width-75\" type=\"number\" value=\""+String:C10($centre_e.LC_AlerteDelai)+"\" /></div></div>"; \
					"lc_alerteAvantEcheance"; $alerteAvantEcheance_t; \
					"lc_alerteApresEcheance"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_alerteApresEcheance_"+String:C10($centre_e.ID)+"\" type=\"checkbox\""+Choose:C955($centre_e.LC_AlerteRappelApresEcheance=True:C214; " checked"; "")+" /></div></div>"; \
					"lc_alerteStop"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_alerteStop_"+String:C10($centre_e.ID)+"\" type=\"checkbox\" /></div></div>"))
			Else 
				$hebergeAlerte_e:=$hebergeAlerte_es.first()
				
				$keyValue_c:=OB Entries:C1720($hebergeAlerte_e.alerteRappelAvantEcheance)
				$alerteAvantEcheance_t:="<div class=\"rowB g-mx-0\">"
				
				For each ($keyValue_o; $keyValue_c)
					$alerteAvantEcheance_t:=$alerteAvantEcheance_t+"<div class=\"col\"><input id=\"checkbox"+String:C10($keyValue_c.indexOf($keyValue_o))+"_"+String:C10($centre_e.ID)+"\" type=\"checkbox\""+Choose:C955(Bool:C1537($keyValue_o.value)=True:C214; " checked"; "")+" /></div>"
				End for each 
				
				$alerteAvantEcheance_t:=$alerteAvantEcheance_t+"</div>"
				
				$retour_o.rows.push(New object:C1471(\
					"id"; String:C10($centre_e.ID); \
					"lc_dateReference"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_dateReference_"+String:C10($centre_e.ID)+"\" class=\"g-width-150\" type=\"date\" value=\""+outilsGetDateInput($hebergeAlerte_e.alerteDateReference)+"\" /></div></div>"; \
					"lc_alerteNom"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><p>"+$centre_e.LC_AlerteNom+"</p><input type=\"hidden\" name=\"centreID\" value=\""+String:C10($centre_e.ID)+"\" /></div></div>"; \
					"lc_alerteDelai"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_alerteDelai_"+String:C10($centre_e.ID)+"\" class=\"g-width-75\" type=\"number\" value=\""+String:C10($hebergeAlerte_e.alerteDelai)+"\" /></div></div>"; \
					"lc_alerteAvantEcheance"; $alerteAvantEcheance_t; \
					"lc_alerteApresEcheance"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_alerteApresEcheance_"+String:C10($centre_e.ID)+"\" type=\"checkbox\""+Choose:C955($hebergeAlerte_e.alerteRappelApresEcheance=True:C214; " checked"; "")+" /></div></div>"; \
					"lc_alerteStop"; "<div class=\"rowB g-mx-0\"><div class=\"col-12\"><input id=\"lc_alerteStop_"+String:C10($centre_e.ID)+"\" type=\"checkbox\""+Choose:C955($hebergeAlerte_e.alerteStop=True:C214; " checked disabled"; "")+" /></div></div>"))
			End if 
			
			CLEAR VARIABLE:C89($alerteAvantEcheance_t)
		End for each 
		
	: (w_visiteur.action="saveAlertParam")
		$verif_o:=outilsObjectCheckIfPropExist(w_visiteur; New collection:C1472("dataAlertParam@"); -1)
		
		If (Bool:C1537($verif_o["dataAlertParam@"].exist)=True:C214)
			$index_c:=New collection:C1472
			
			For each ($property_t; $verif_o["dataAlertParam@"].propriete)
				$index_el:=Num:C11(Substring:C12($property_t; 16; 1))
				
				If ($index_c.indexOf($index_el)=-1)
					$hebergeAlerte_es:=ds:C1482.HebergeAlerte.query("hebergeReferenceID = :1 AND centreID = :2"; Num:C11(w_visiteur.hebergeReferenceID); Num:C11(w_visiteur["dataAlertParam["+String:C10($index_el)+"][centreID]"]))
					
					If ($hebergeAlerte_es.length=0)
						$hebergeAlerte_e:=ds:C1482.HebergeAlerte.new()
						
						$hebergeAlerte_e.hebergeReferenceID:=Num:C11(w_visiteur.hebergeReferenceID)
						$hebergeAlerte_e.centreID:=Num:C11(w_visiteur["dataAlertParam["+String:C10($index_el)+"][centreID]"])
					Else 
						$hebergeAlerte_e:=$hebergeAlerte_es.first()
					End if 
					
					$hebergeAlerte_e.alerteDateReference:=Date:C102(outilsDateIsoVersDateFr(w_visiteur["dataAlertParam["+String:C10($index_el)+"][dateReference]"]))
					$hebergeAlerte_e.alerteDelai:=Num:C11(w_visiteur["dataAlertParam["+String:C10($index_el)+"][delaiAlerte]"])
					$hebergeAlerte_e.alerteRappelAvantEcheance:=New object:C1471(\
						"15j"; Choose:C955(w_visiteur["dataAlertParam["+String:C10($index_el)+"][rappelAvantEcheance][15j]"]="true"; True:C214; False:C215); \
						"7j"; Choose:C955(w_visiteur["dataAlertParam["+String:C10($index_el)+"][rappelAvantEcheance][7j]"]="true"; True:C214; False:C215); \
						"5j"; Choose:C955(w_visiteur["dataAlertParam["+String:C10($index_el)+"][rappelAvantEcheance][5j]"]="true"; True:C214; False:C215); \
						"2j"; Choose:C955(w_visiteur["dataAlertParam["+String:C10($index_el)+"][rappelAvantEcheance][2j]"]="true"; True:C214; False:C215); \
						"1j"; Choose:C955(w_visiteur["dataAlertParam["+String:C10($index_el)+"][rappelAvantEcheance][1j]"]="true"; True:C214; False:C215))
					$hebergeAlerte_e.alerteRappelApresEcheance:=Choose:C955(w_visiteur["dataAlertParam["+String:C10($index_el)+"][rappelApresEcheance]"]="true"; True:C214; False:C215)
					$hebergeAlerte_e.save()
					
					$index_c.push($index_el)
				End if 
				
			End for each 
			
		End if 
		
	: (w_visiteur.action="activateAlert")
		$values_c:=UTL_Web_Get_Enumeration_Values("FM Groupe")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $values_at)
		End if 
		
		$pos_el:=Find in array:C230($values_at; w_visiteur.service)
		
		$plateforme_t:=Substring:C12($values_at{$pos_el}; 1; 2)
		$centre_es:=ds:C1482.LesCentres.query("LC_AlerteWeb = :1 AND LC_Plateforme = :2"; True:C214; $plateforme_t)
		
		$hebergeAlerte_es:=ds:C1482.HebergeAlerte.query("hebergeReferenceID = :1"; Num:C11(w_visiteur.hebergeReferenceID))
		$hebergeAlerte_es:=$centre_es.AllHebergeAlerte.and($hebergeAlerte_es)
		
		If (Num:C11(w_visiteur.intervenantID)<=0)
			w_visiteur.intervenantID:=w_userUID
		End if 
		
		$hebergement_es:=$hebergeAlerte_es[0].OneHeberge.HB_ReferenceID_1_HG_HB_ID
		
		If ($hebergement_es.length=0)
			$retour_o.notificationError:="Attention, cet usager n'a pas de fiche, vous ne pouvez pas mettre en place les alertes."
		Else 
			SOC_Get_Config
			
			For each ($hebergeAlerte_e; $hebergeAlerte_es) Until ($retour_o.notificationError#Null:C1517)
				$date_d:=$hebergeAlerte_e.alerteDateReference+$hebergeAlerte_e.alerteDelai
				$event_es:=ds:C1482.Events.query("EVE_User_ID = :1 AND EVE_HB_ID = :2 AND EVE_Date_Du = :3 AND EVE_Date_Au = :3 AND EVE_Heure_Du = :4 AND EVE_Heure_Au = :5"; Num:C11(w_visiteur.intervenantID); $hebergeAlerte_e.hebergeReferenceID; $date_d; ?10:00:00?; ?11:30:00?)
				
				If ($event_es.length=0)
					$event_e:=ds:C1482.Events.new()
					
					$event_e.Ref_Structure:=w_visiteur.Ref_Structure
					$event_e.EVE_HB_ID:=$hebergeAlerte_e.hebergeReferenceID
					$event_e.EVE_HB_NomPrenom:=$hebergeAlerte_e.OneHeberge.HB_Nom+" "+$hebergeAlerte_e.OneHeberge.HB_Prénom
					$event_e.EVE_User_ID:=Num:C11(w_visiteur.intervenantID)
					
					$intervenant_e:=ds:C1482.INtervenants.get($event_e.EVE_User_ID)
					
					If ($intervenant_e#Null:C1517)
						$event_e.EVE_User_NomPrenom:=$intervenant_e.IN_NomPrénom
					End if 
					
					$event_e.EVE_Date_Du:=$date_d
					$event_e.EVE_Date_Au:=$date_d
					
					$event_e.EVE_Heure_Du:=?10:00:00?
					$event_e.EVE_Heure_Au:=?11:30:00?
					
					$event_e.EVE_Type:="Démarche usager"
					$event_e.EVE_Titre:=$hebergeAlerte_e.OneCentre.LC_AlerteNom
					
					$keyValue_c:=OB Entries:C1720($hebergeAlerte_e.alerteRappelAvantEcheance)
					
					For each ($keyValue_o; $keyValue_c)
						
						If ($keyValue_o.value=True:C214)
							
							If ($event_e.EVE_Rappel="")
								$event_e.EVE_Rappel:=$keyValue_o.key
							Else 
								$event_e.EVE_Rappel:=$event_e.EVE_Rappel+";"+$keyValue_o.key
							End if 
							
						End if 
						
					End for each 
					
					If ($intervenant_e#Null:C1517)
						
						Case of 
							: (SO_Email#"") & (outilsRegexValidate(1; $intervenant_e.IN_Email)=True:C214)
								$eventDetail_e:=ds:C1482.Events_Details.new()
								
								$eventDetail_e.EVD_Event_ID:=$event_e.ID
								$eventDetail_e.EVD_User_ID:=$intervenant_e.ID
								$eventDetail_e.Ref_Structure:=w_visiteur.Ref_Structure
								
								$eventDetail_e.save()
							: (SO_Email="")
								$retour_o.notificationError:="Il y a un problème dans les données de la structure, veuillez vous rapprocher de Paxtel pour plus d'informations."
							: (outilsRegexValidate(1; $intervenant_e.IN_Email)=False:C215)
								$retour_o.notificationError:="Il y a un problème dans l'email en lien avec votre identifiant, veuillez vous rapprocher de Paxtel pour plus d'informations."
						End case 
						
					Else 
						$retour_o.notificationError:="L'intervenant connecté n'a pas pu être trouvé dans la base de données, veuillez vous rapprocher du service informatique."
					End if 
					
					If ($retour_o.notificationError=Null:C1517)
						$event_e.save()
					End if 
					
				End if 
				
				CLEAR VARIABLE:C89($keyValue_c)
			End for each 
			
			$transporter_o:=outilsMailGestion(1)
			
			Case of 
				: (SO_Email#"") & (outilsRegexValidate(1; $intervenant_e.IN_Email)=True:C214)
					$email_o:=New object:C1471("emetteur"; SO_Email; \
						"destinataire"; $intervenant_e.IN_Email; \
						"objet"; "Alerte active"; \
						"message"; "Les alertes sont bien activées pour l'hébergé "+$hebergeAlerte_es[0].OneHeberge.HB_Nom+" "+$hebergeAlerte_es[0].OneHeberge.HB_Prénom+".")
				: (outilsRegexValidate(1; $intervenant_e.IN_Email)=False:C215)
					$email_o:=New object:C1471("emetteur"; SO_Email; \
						"destinataire"; "l.phanchi@paxtel.fr"; \
						"cc"; "remy@connect-io.fr"; \
						"objet"; "Bug alerte"; \
						"message"; "Problème pour activer les alertes car l'identifiant "+$intervenant_e.IN_NomPrénom+" n'a pas d'adresse email indiqué.")
			End case 
			
			If ($email_o#Null:C1517)
				$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
			End if 
			
		End if 
		
	: (w_visiteur.action="checkParamAlert")
		$values_c:=UTL_Web_Get_Enumeration_Values("FM Groupe")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $values_at)
		End if 
		
		$pos_el:=Find in array:C230($values_at; w_visiteur.service)
		
		$plateforme_t:=Substring:C12($values_at{$pos_el}; 1; 2)
		$centre_es:=ds:C1482.LesCentres.query("LC_AlerteWeb = :1 AND LC_Plateforme = :2"; True:C214; $plateforme_t)
		
		$hebergeAlerte_es:=ds:C1482.HebergeAlerte.query("hebergeReferenceID = :1"; Num:C11(w_visiteur.hebergeReferenceID))
		$hebergeAlerte_es:=$centre_es.AllHebergeAlerte.and($hebergeAlerte_es)
		
		For each ($centre_e; $centre_es) Until ($stop_b=True:C214)
			$hebergeAlerteB_es:=ds:C1482.HebergeAlerte.query("hebergeReferenceID = :1 AND centreID = :2"; Num:C11(w_visiteur.hebergeReferenceID); $centre_e.ID)
			$stop_b:=($hebergeAlerteB_es.length=0)
		End for each 
		
		If ($stop_b=True:C214)
			$retour_o.notificationError:="Veuillez enregistrer les paramètres « Alerte », avant de pouvoir continuer"
		End if 
		
	: (w_visiteur.action="closeAlert")
		$hebergeAlerte_es:=ds:C1482.HebergeAlerte.query("hebergeReferenceID = :1 AND centreID = :2"; Num:C11(w_visiteur.hebergeReferenceID); Num:C11(w_visiteur.centreID))
		
		If ($hebergeAlerte_es.length=0)
			$retour_o.notificationError:="Veuillez enregistrer les paramètres « Alerte », avant de pouvoir continuer"
		Else 
			$hebergeAlerte_e:=$hebergeAlerte_es.first()
			$heberge_e:=$hebergeAlerte_e.OneHeberge
			
			$hebergement_e:=ds:C1482.HeberGement.new()
			$id_el:=$hebergement_e.ID
			
			$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID.orderBy("HG_Date desc")
			
			If ($hebergement_es.length>0)
				$hebergement_o:=$hebergement_es.first().toObject()
				
				$hebergement_e.fromObject($hebergement_o)
				$hebergement_e.ID:=$id_el
			End if 
			
			$hebergement_e.HG_Date:=Date:C102(outilsDateIsoVersDateFr(w_visiteur.closeAlertDate))
			$hebergement_e.HG_RéservationDateFin:=$hebergement_e.HG_Date
			
			$hebergement_e.HG_HeureAppel:=Current time:C178
			$hebergement_e.HG_FicheNuméro:=i_HébérgementNoFiche("N"; $hebergement_e.HG_Date; Uut_Numerote115($hebergement_e.HG_Date))
			
			$hebergement_e.HG_EnAttente:=True:C214
			$hebergement_e.HG_DateDuJour:=Current date:C33
			$hebergement_e.HG_AttenteHeur:=Current time:C178
			
			If (<>vb_T_ModeCHRS)
				$hebergement_e.HG_Plateforme:=<>va_UserPlateforme
			End if 
			
			$hebergement_e.HG_LC_ID:=$hebergeAlerte_e.OneCentre.LC_RéférenceID
			$hebergement_e.HG_CentreNom:=$hebergeAlerte_e.OneCentre.LC_Nom
			$hebergement_e.HG_ReferenceID:=Uut_Numerote(->[HeberGement:5])
			
			$hebergement_e.HG_NuitenCours:=1
			$hebergement_e.HG_NuitTOTAL:=1
			
			$hebergement_e.HG_NuitReste:=$hebergement_e.HG_NuitTOTAL-$hebergement_e.HG_NuitenCours
			
			If (User in group:C338(Current user:C182; "Permanencier")=True:C214)
				$hebergement_e.HG_Permanencier:=Current user:C182
			End if 
			
			If (Num:C11(w_visiteur.intervenantID)<=0)
				w_visiteur.intervenantID:=w_userUID
			End if 
			
			$intervenant_es:=ds:C1482.INtervenants.query("ID = :1"; Num:C11(w_visiteur.intervenantID))
			
			If ($intervenant_es.length=1)
				
				If (User in group:C338($intervenant_es[0].IN_NomPrénom; "Permanencier")=True:C214)
					$hebergement_e.HG_Permanencier:=$intervenant_es[0].IN_NomPrénom
				End if 
				
			End if 
			
			$hebergement_e.HG_Coordinateur:=<>va_HG_Coordinateur
			$hebergement_e.HG_Régulateur:=<>va_HG_Régulateur
			
			$hebergement_e.HG_Nom:=$heberge_e.HB_Nom
			$hebergement_e.HG_Prénom:=$heberge_e.HB_Prénom
			$hebergement_e.HG_HB_ID:=$heberge_e.HB_ReferenceID
			
			// Modifié par : Scanu Rémy (20/09/2022)
			//$hebergement_e.HG_FamChef:=Vrai
			//$hebergement_e.HG_FamClé:=$heberge_e.HB_CléFam
			
			$hebergement_e.HG_EnAttente:=True:C214
			$hebergement_e.HG_Cloturée:=True:C214
			
			$hebergement_e.HG_DateCreationFiche:=Current date:C33(*)
			$hebergement_e.HG_ModifDateHeures:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))
			$hebergement_e.HG_Réservation:=True:C214
			$hebergement_e.Ref_Structure:=w_visiteur.Ref_Structure
			
			$hebergement_e.HG_Nuit:=True:C214
			$hebergement_e.HG_FamGroupe:=w_visiteur.service
			$hebergement_e.HG_Plateforme:=Substring:C12($hebergement_e.HG_FamGroupe; 1; 2)
			
			$hebergement_e.save()
			
			$hebergeAlerte_e.alerteStop:=True:C214
			$hebergeAlerte_e.save()
		End if 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))