var $position_t; $nom_t; $prenom_t; $dateType_t : Text
var $nbJour_el; $i_el; $j_el; $idCentre_el : Integer
var $stop_b : Boolean
var $dateNaissance_d : Date
var $form_o : Object

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]ID:65#0) & ([HeBerge:4]HB_CléFam:47="")
			$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1"; [HeBerge:4]HB_ReferenceID:1)
			outilsOrdaSearchByRefStctre(->$hebergement_es)
			
			If ($hebergement_es.length=0)
				CONFIRM:C162("La fiche sélectionnée est-elle chef de famille ?"; "Oui"; "Non")
				
				If (OK=1)
					[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
					SAVE RECORD:C53([HeBerge:4])
				End if 
				
			End if 
			
		End if 
		
		Case of 
			: ([HeBerge:4]ID:65=0)
				StrAlerte(3; "")
			: ([HeBerge:4]HB_CléFam:47="")
				ALERT:C41("La réservation n'est possible qu'à partir d'une fiche hébergé indiqué en tant que chef de famille")
			Else 
				$position_t:="center"
				$form_o:=New object:C1471("dateDu"; String:C10(Current date:C33(*)))
				
				outilsCreateWindowsForm("DL_Reservation"; ->$position_t; $form_o; ->[DiaLogues:3])
				
				If (OK=1)
					$nbJour_el:=outilsGetNbJour(Date:C102($form_o.dateAu); Date:C102($form_o.dateDu))
					
					QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=$form_o.centre)
					MultiSoc_Filter(->[LesCentres:9])
					
					$idCentre_el:=[LesCentres:9]ID:60
					
					// Modifié par : Scanu Rémy (25/08/2022)
					// Avant de faire la réservation on va vérifier que pour le premier jour de la réservation, le centre sélectionné a ou pas de la disponibilité ET des places restantes
					QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=Uut_NumeroteLitsType(Date:C102($form_o.dateDu); "J"); *)
					QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
					
					MultiSoc_Filter(->[CentresLits:16])
					$stop_b:=(Records in selection:C76([CentresLits:16])>0) & (Sum:C1([CentresLits:16]CL_Restant:7)=0)
					
					If ($stop_b=True:C214)  // Il existe déjà une disponibilité et plus de place restante
						CONFIRM:C162("Attention, ce logement est déjà complet. Voulez-vous continuer ?"; "Oui"; "Non")
						$stop_b:=(OK=0)
					End if 
					
					If ($stop_b=False:C215)  // Les réservations ne concernent que les fiches Jour
						READ WRITE:C146([CentresLits:16])
						
						outilsProgressBar(0; "Initialisation"; True:C214)
						
						For ($i_el; 0; $nbJour_el-1)
							outilsProgressBar($i_el/($nbJour_el-1); "Génération des fiches de la réservation en cours..."; False:C215)
							
							For ($j_el; 1; Num:C11($form_o.nbPlace))
								
								If ($j_el>1)
									$heberge_es:=ds:C1482.HeBerge.query("HB_Nom = :1 AND HB_Prénom = :2 AND Ref_Structure = :3"; [HeBerge:4]HB_Nom:3; [HeBerge:4]HB_Prénom:4+" Acc"+String:C10($j_el-1); <>ref_soc_active)
									
									If ($heberge_es.length=0)
										$heberge_e:=ds:C1482.HeBerge.new()
										
										$heberge_e.HB_ReferenceID:=Uut_Numerote(->[HeBerge:4])
										
										$heberge_e.HB_Nom:=[HeBerge:4]HB_Nom:3
										$heberge_e.HB_Prénom:=[HeBerge:4]HB_Prénom:4+" Acc"+String:C10($j_el-1)
										$heberge_e.HB_DateNéLe:=!1900-01-01!
										
										$nom_t:=$heberge_e.HB_Nom
										$prenom_t:=$heberge_e.HB_Prénom
										$dateNaissance_d:=$heberge_e.HB_DateNéLe
										
										$heberge_e.HB_Clé:=Uut_HébergéClé(->$nom_t; ->$prenom_t; ->$dateNaissance_d)
										
										$heberge_e.HB_Telephone:=[HeBerge:4]HB_Telephone:66
										$heberge_e.HG_Genre:=[HeBerge:4]HG_Genre:39
										$heberge_e.HB_FicheCrééele:=Current date:C33(*)
										$heberge_e.Ref_Structure:=<>ref_soc_active
										
										$heberge_e.save()
									Else 
										$heberge_e:=$heberge_es.first()
									End if 
									
								Else 
									$heberge_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
								End if 
								
								$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date = :2"; $heberge_e.HB_ReferenceID; Add to date:C393(Date:C102($form_o.dateDu); 0; 0; $i_el))
								
								Case of 
									: ($hebergement_es.length=0)
										$hebergement_e:=ds:C1482.HeberGement.new()
										
										$hebergement_e.HG_Date:=Add to date:C393(Date:C102($form_o.dateDu); 0; 0; $i_el)
										$hebergement_e.HG_RéservationDateFin:=Date:C102($form_o.dateAu)
										
										$hebergement_e.HG_HeureAppel:=Current time:C178()
										$hebergement_e.HG_FicheNuméro:=i_HébérgementNoFiche("J"; $hebergement_e.HG_Date; Uut_Numerote115($hebergement_e.HG_Date))
										
										$hebergement_e.HG_EnAttente:=True:C214
										$hebergement_e.HG_DateDuJour:=Current date:C33()
										$hebergement_e.HG_AttenteHeur:=Current time:C178()
										
										If (<>vb_T_ModeCHRS)
											$hebergement_e.HG_Plateforme:=<>va_UserPlateforme
										End if 
										
										$hebergement_e.HG_FamGroupe:=$form_o.service
										
										$hebergement_e.HG_LC_ID:=[LesCentres:9]LC_RéférenceID:1
										$hebergement_e.HG_CentreNom:=$form_o.centre
										$hebergement_e.HG_ReferenceID:=Uut_Numerote(->[HeberGement:5])
										
										If ($nbJour_el>0)
											$hebergement_e.HG_NuitenCours:=1+$i_el
											$hebergement_e.HG_NuitTOTAL:=$nbJour_el
											$hebergement_e.HG_NuitReste:=$hebergement_e.HG_NuitTOTAL-$hebergement_e.HG_NuitenCours
										End if 
										
										If (User in group:C338(Current user:C182; "Permanencier")=True:C214)
											$hebergement_e.HG_Permanencier:=Current user:C182
										End if 
										
										$hebergement_e.HG_Coordinateur:=<>va_HG_Coordinateur
										$hebergement_e.HG_Régulateur:=<>va_HG_Régulateur
										
										$hebergement_e.HG_Nom:=$heberge_e.HB_Nom
										$hebergement_e.HG_Prénom:=$heberge_e.HB_Prénom
										$hebergement_e.HG_HB_ID:=$heberge_e.HB_ReferenceID
										$hebergement_e.HG_FamChef:=($j_el=1)
										$hebergement_e.HG_FamClé:=[HeBerge:4]HB_CléFam:47
										
										$hebergement_e.HG_EnAttente:=True:C214
										
										// Modifié par : Scanu Rémy (24/08/2022)
										// Ajout du champ pour voir si la fiche est reportée
										If ($i_el<($nbJour_el-1))
											$hebergement_e.HG_Reporté:="R"
										End if 
										
										$hebergement_e.HG_Cloturée:=True:C214
										
										$hebergement_e.HG_DateCreationFiche:=Current date:C33(*)
										$hebergement_e.HG_ModifDateHeures:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))
										$hebergement_e.HG_ReservationProvisoire:=(reservationProvisoire_at{reservationProvisoire_at}="Oui")
										$hebergement_e.HG_Réservation:=(reservationProvisoire_at{reservationProvisoire_at}="Non")
										$hebergement_e.Ref_Structure:=<>ref_soc_active
										
										$hebergement_e.save()
									: ($i_el<($nbJour_el-1))
										
										For each ($hebergement_e; $hebergement_es)
											
											If ($nbJour_el>0)
												$hebergement_e.HG_NuitenCours:=1+$i_el
												$hebergement_e.HG_NuitTOTAL:=$nbJour_el
												$hebergement_e.HG_NuitReste:=$hebergement_e.HG_NuitTOTAL-$hebergement_e.HG_NuitenCours
											End if 
											
											$hebergement_e.HG_Reporté:="R"
											$hebergement_e.HG_Cloturée:=True:C214
											
											$hebergement_e.HG_ModifDateHeures:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))
											$hebergement_e.HG_ReservationProvisoire:=(reservationProvisoire_at{reservationProvisoire_at}="Oui")
											$hebergement_e.HG_Réservation:=(reservationProvisoire_at{reservationProvisoire_at}="Non")
											
											$hebergement_e.save()
										End for each 
										
								End case 
								
							End for 
							
							$dateType_t:=Uut_NumeroteLitsType(Add to date:C393(Date:C102($form_o.dateDu); 0; 0; $i_el); "J")
							
							ALL RECORDS:C47([LesCentres:9])
							MultiSoc_Filter(->[LesCentres:9])
							
							While (Not:C34(End selection:C36([LesCentres:9])))
								QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=$dateType_t; *)
								QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
								
								MultiSoc_Filter(->[CentresLits:16])
								
								Case of 
									: (Records in selection:C76([CentresLits:16])=0)
										
										If ([LesCentres:9]LC_Fermé:53=False:C215) & ([LesCentres:9]LC_Prestation:55=False:C215)
											P_DisponibilitéCréer(0; "J"; Add to date:C393(Date:C102($form_o.dateDu); 0; 0; $i_el); 0; 0; 0; 0; 0; Choose:C955([LesCentres:9]ID:60=$idCentre_el; Num:C11($form_o.nbPlace); 0))
											
											If ([LesCentres:9]ID:60#$idCentre_el)
												QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=$dateType_t; *)
												QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
												
												If (Records in selection:C76([CentresLits:16])>0)
													[CentresLits:16]CL_Restant:7:=[LesCentres:9]LC_DispoJour:48
													SAVE RECORD:C53([CentresLits:16])
												End if 
												
											End if 
											
										End if 
										
									: ([LesCentres:9]LC_Fermé:53=False:C215) & ([LesCentres:9]ID:60=$idCentre_el)
										[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6+Num:C11($form_o.nbPlace)
										[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7-[CentresLits:16]CL_Distribué:6
										
										SAVE RECORD:C53([CentresLits:16])
								End case 
								
								NEXT RECORD:C51([LesCentres:9])
							End while 
							
						End for 
						
						READ ONLY:C145([CentresLits:16])
						
						UNLOAD RECORD:C212([LesCentres:9])
						UNLOAD RECORD:C212([CentresLits:16])
						
						outilsProgressBar(1; "arrêt")
					End if 
					
				End if 
				
		End case 
		
End case 