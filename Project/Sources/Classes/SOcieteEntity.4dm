Class extends Entity

Function synchroAppMobileImportData()
	var $type_t; $url_t; $reponse_t; $refStructure_t; $typeNote_t; $message_t : Text
	var $i_el; $moduloProgress_el; $j_el; $k_el; $tsUpdate_el; $tsLastImport_el : Integer
	var $signal_b; $create_b; $stop_b : Boolean
	var $statut_o; $hebergement_o; $transporter_o; $email_o; $signal_o; $param_o : Object
	var $lines_c; $lineError_c; $lineErrorB_c; $proprieteToKeep_c; $column_c; $note_c; $date_c; $type_c : Collection
	
	var $file_f : 4D:C1709.File
	
	var ref_soc_active : Text
	
	var $heberge_e : cs:C1710.HeBergeEntity
	var $hebergement_e : cs:C1710.HeberGementEntity
	
	var $note_e : cs:C1710.NoteEntity
	var $adresse_e : cs:C1710.AdressesEntity
	
	var $centres_e : cs:C1710.LesCentresEntity
	var $centres_es : cs:C1710.LesCentresSelection
	
	ARRAY TEXT:C222($column_at; 0; 0)
	
	ref_soc_active:=This:C1470.Ref_Structure
	$transporter_o:=outilsMailGestion(1)
	
	$date_c:=New collection:C1472
	$tsLastImport_el:=This:C1470.SO_SynchroApplicationMobile.lastTimeStampImport-(60*Num:C11(This:C1470.SO_SynchroApplicationMobile.nbMinute))
	
	If ($tsLastImport_el<0)
		CLEAR VARIABLE:C89($tsLastImport_el)
	End if 
	
	For ($i_el; 1; 3)
		outilsCollectionInit(->$lines_c; ->$column_c; ->$lineError_c; ->$lineErrorB_c; ->$type_c)
		
		Case of 
			: ($i_el=1)
				$type_t:="Usagers"
			: ($i_el=2)
				$type_t:="Notes"
			: ($i_el=3)
				$type_t:="Actions"
		End case 
		
		$url_t:="https://paxtel-staging-backend.cleverapps.io/paxtel-export/generate/"+Lowercase:C14($type_t)+"?ref_structure="+This:C1470.Ref_Structure+"&startDate="+outilsDateFrVersDateIso(outilsTimeStampRead("date"; $tsLastImport_el))+"&endDate="+outilsDateFrVersDateIso(String:C10(Current date:C33))+"&token=61f9a47389fb"+\
			"1334d9736ea998e754b5a6a6750f4b50286f434f2ad665d2fc3b7efd5d120f6f3dc4dae8975be5dec966f873543f2dbfd642ca0547ea37813178df70fc7bc3a7db94f76dbf96182b7f8839ac167571b6fbe54ae62c6019abcb235b3f717b56f9003b3973e3b15"+\
			"cb33a5e38cac46828d87e232952155f6ad5cf19"
		
		outilsWebHTTPRequest("GET"; $url_t; ""; ->$reponse_t)
		
		$file_f:=Folder:C1567(fk dossier ressources:K87:11).file("TEMP/importApp.csv")
		
		If ($file_f.exists=True:C214)
			$file_f.delete()
		End if 
		
		$create_b:=$file_f.create()
		
		If ($create_b=True:C214)
			$file_f.setText($reponse_t; "UTF-8"; Document inchangé:K24:18)
			
			$param_o:=New object:C1471
			$param_o.in:=$file_f.platformPath
			$param_o.encoding:="UTF-8"
			$param_o.delimiter:=","
			
			outilsCSVManage(1; $param_o; ->$column_at)
			outilsCSVManage(2; ->$column_at; ->$lines_c)
		End if 
		
		//$lines_c:=Séparer chaine($reponse_t; Caractère(Retour à la ligne))
		
		If ($type_t="Notes")
			$proprieteToKeep_c:=New collection:C1472
			outilsManageNote(99; ->$proprieteToKeep_c; This:C1470.Ref_Structure; Current user:C182)
		End if 
		
		$moduloProgress_el:=outilsProgressBarGetModulo($lines_c.length)
		
		// Intégration des données du fichier csv avec les données du matching
		For each ($column_c; $lines_c)
			
			If ($column_c.length=1)
				$stop_b:=($column_c[0]="noData")
			End if 
			
			If ($stop_b=False:C215)
				
				If ($j_el%$moduloProgress_el=0)
					$message_t:="Import des données ("+$type_t+") le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" ("+String:C10($j_el+1)+"/"+String:C10($lines_c.length)+")"
					
					If (Process number:C372("formSynchroAppMobile_w")>0)
						$signal_o:=New signal:C1641("Import des données de l'application mobile pour structure "+This:C1470.Ref_Structure+" - "+Substring:C12(Generate UUID:C1066; 1; 5))
						
						CALL FORM:C1391(Storage:C1525.synchroAppMobileWindows.refWindows; "outilsManageSynchroAppMobile"; 99; $signal_o; This:C1470.Ref_Structure; $message_t)
						$signal_b:=$signal_o.wait(120)  // Sécurité si l'incorporation du message dans le formulaire prend plus de 2 minutes
					Else 
						MESSAGE:C88($message_t+Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40))
					End if 
					
				End if 
				
				If ($j_el>0)
					//$regex_b:=Trouver regex("/(\".*?\"|[^\",\\s]+)(?=\\s*,|\\s*$)/g"; $line_t; 1; $position_ai; $length_ai)
					//$column_c:=Séparer chaine($line_t; ",")
					
					Case of 
						: ($type_t="Usagers")
							$refStructure_t:=$column_c[2]
						: ($type_t="Notes")
							$refStructure_t:=$column_c[1]
						: ($type_t="Actions")
							$refStructure_t:=$column_c[19]
					End case 
					
					$structure_es:=ds:C1482.Structures.query("Ref_Structure = :1"; $refStructure_t)
					
					If ($structure_es.length>0)
						
						Case of 
							: ($type_t="Usagers")
								$tsUpdate_el:=outilsTimeStamp(Date:C102($column_c[20]); Time:C179(outilsHeureIsoVersHeureFr($column_c[20])))
								
								If ($tsUpdate_el>=$tsLastImport_el)
									// Création de l'enregistrement dans la table [HeBerge]
									$column_c[6]:=outilsDateIsoVersDateFr($column_c[6])
									
									$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($column_c[4]; $column_c[5]; $column_c[6]; $refStructure_t; True:C214)
									$heberge_e.reload()
									
									$heberge_e.HB_Telephone:=$column_c[10]
									$heberge_e.HB_Email:=$column_c[11]
									$heberge_e.situationBudgetaire.salaire:=Num:C11($column_c[18])
									$heberge_e.HG_Genre:=($column_c[22]="Femme")
									
									// Création de l'enregistrement dans la table [Adresses]
									$adresse_e:=ds:C1482.Adresses.searchAndCreateRecordIfDontExist($heberge_e.ID; Table:C252(->[HeBerge:4]); $refStructure_t)
									$adresse_e.reload()
									
									$adresse_e.AD_Adresse1:=$column_c[12]
									$adresse_e.AD_Code_postal:=$column_c[14]
									$adresse_e.AD_Ville:=$column_c[13]
									
									$statut_o:=$adresse_e.save()
									
									If (Date:C102(outilsDateUsVersDateFr($column_c[30]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[30])))=-1)  // Colonne history.familyStatus.date
										$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[30])))
										$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[30])); True:C214)
									End if 
									
									If (Date:C102(outilsDateUsVersDateFr($column_c[34]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[34])))=-1)  // Colonne history.resources.date
										$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[34])))
										$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[34])); True:C214)
									End if 
									
									If (Date:C102(outilsDateUsVersDateFr($column_c[38]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[38])))=-1)  // Colonne history.positionAdministrative.date
										$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[38])))
										$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[38])); True:C214)
									End if 
									
									If (Date:C102(outilsDateUsVersDateFr($column_c[42]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[42])))=-1)  // Colonne history.professionalSituation.date
										$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[42])))
										$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[42])); True:C214)
									End if 
									
								End if 
								
							: ($type_t="Notes")
								$tsUpdate_el:=outilsTimeStamp(Date:C102($column_c[13]); Time:C179(outilsHeureIsoVersHeureFr($column_c[13])))
								
								If ($tsUpdate_el>=$tsLastImport_el)
									$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($column_c[6]; $column_c[7]; $column_c[8]; $refStructure_t; True:C214)
									
									Case of 
										: ($column_c[3]="Transmissions")
											$messagerie_e:=ds:C1482.Messagerie.createEntityAppMobileImportDataNote(Date:C102($column_c[12]); $column_c[11]; $column_c[4]; $refStructure_t)
										: ($proprieteToKeep_c.query("lib = :1"; $column_c[3]).length>0)
											$typeNote_t:=$proprieteToKeep_c.query("lib = :1"; $column_c[3])[0].field
											
											$note_e:=ds:C1482.Note.searchAndCreateRecordIfDontExist($heberge_e.ID; $typeNote_t; $refStructure_t)
											$note_e.reload()
											
											$note_c:=$note_e.detail.note.query("date = :1 AND note = :2"; Date:C102($column_c[12]); String:C10($column_c[4]))
											
											If ($note_c.length=0)
												$note_e.detail.note.push(New object:C1471(\
													"date"; Date:C102($column_c[12]); \
													"heure"; String:C10(Current time:C178); \
													"typeNote"; $typeNote_t; \
													"UUID"; Generate UUID:C1066; \
													"note"; String:C10($column_c[4]); \
													"utilisateur"; String:C10($column_c[11]); \
													"importApplicationMobile"; True:C214; \
													"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
												
												$statut_o:=$note_e.save()
											End if 
											
										Else 
											$lineError_c.push(New object:C1471("ligne"; String:C10($j_el); "type"; $type_t; "libNote"; $column_c[3]))
									End case 
									
								End if 
								
							: ($type_t="Actions")
								$tsUpdate_el:=outilsTimeStamp(Date:C102($column_c[27]); Time:C179(outilsHeureIsoVersHeureFr($column_c[27])))
								
								If ($tsUpdate_el>=$tsLastImport_el)
									// Création de l'enregistrement dans la table [HeBerge]
									$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($column_c[5]; $column_c[7]; $column_c[6]; $refStructure_t; True:C214)
									$heberge_e.reload()
									
									// Création de l'enregistrement dans la table [HeberGement]
									
									If ($column_c[29]#"")  // Modification d'une fiche 4D existante sur l'application mobile
										$hebergement_e:=ds:C1482.HeberGement.get(Num:C11($column_c[29]))
									Else   // Fiche créée sur l'application mobile
										$hebergement_e:=ds:C1482.HeberGement.new()
									End if 
									
									$hebergement_e.HG_Date:=Date:C102(outilsDateIsoVersDateFr($column_c[1]))
									$hebergement_e.HG_RéservationDateFin:=F_RéservationDateFin($hebergement_e.HG_Date; $hebergement_e.HG_NuitReste)
									
									$hebergement_e.HG_HeureAppel:=Current time:C178(*)
									$hebergement_e.HG_FicheNuméro:=i_HébérgementNoFiche("N"; $hebergement_e.HG_Date; Uut_Numerote115($hebergement_e.HG_Date))
									
									$hebergement_e.HG_DateDuJour:=Current date:C33()
									$hebergement_e.HG_AttenteHeur:=Current time:C178()
									
									$hebergement_e.HG_FamGroupe:=$column_c[14]
									$hebergement_e.HG_ReferenceID:=Uut_Numerote(->[HeberGement:5])
									
									$hebergement_e.HG_Nuit:=True:C214
									$hebergement_e.HG_NuitenCours:=1
									$hebergement_e.HG_NuitTOTAL:=1
									
									$hebergement_e.HG_NuitReste:=$hebergement_e.HG_NuitTOTAL-$hebergement_e.HG_NuitenCours
									
									$hebergement_e.HG_Permanencier:=$column_c[22]
									
									$hebergement_e.HG_Nom:=$heberge_e.HB_Nom
									$hebergement_e.HG_Prénom:=$heberge_e.HB_Prénom
									$hebergement_e.HG_HB_ID:=$heberge_e.HB_ReferenceID
									
									$hebergement_e.HG_FamChef:=($hebergement_e.HG_FamClé#"")
									$hebergement_e.HG_FamClé:=$column_c[4]
									
									If ($column_c[29]="")  // Fiche créée sur l'application mobile
										$hebergement_e.HG_DateCreationFiche:=Current date:C33(*)
									End if 
									
									$hebergement_e.HG_ModifDateHeures:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))
									
									$hebergement_e.HG_Nationalité:=$column_c[8]
									$hebergement_e.HG_EtatCivil:=$column_c[9]
									$hebergement_e.HG_PiècesIdté1:=$column_c[10]
									$hebergement_e.HG_Ressources1:=$column_c[11]
									$hebergement_e.HG_SituProfess:=$column_c[12]
									$hebergement_e.HG_Commentaires:=$column_c[13]
									$hebergement_e.HG_CentreNom:=$column_c[17]
									
									$hebergement_e.HG_Signalement:=$column_c[24]
									$hebergement_e.HG_Cloturée:=True:C214
									
									$hebergement_e.Ref_Structure:=$refStructure_t
									
									// Indique qu'on provient de l'import des données de l'application mobile
									$hebergement_e.saveEntity(1)
									$hebergement_e.save()
									
									$centres_es:=ds:C1482.LesCentres.query("LC_Nom = :1"; $column_c[17])
									
									If ($centres_es.length>0)
										$centres_e:=$centres_es.first()
										
										$centres_e.LC_Categorie:=$column_c[16]
										$statut_o:=$centres_e.save()
										
										$hebergement_e.HG_LC_ID:=$centres_e.LC_RéférenceID
										$hebergement_e.save()
									End if 
									
									$hebergement_o:=$hebergement_e.toObject()
									
									For ($k_el; 1; Num:C11($column_c[15]))
										$hebergement_e:=ds:C1482.HeberGement.new()
										
										$hebergement_e.fromObject($hebergement_o)
										$statut_o:=$hebergement_e.save()
									End for 
									
								End if 
								
						End case 
						
						If ($heberge_e#Null:C1517)
							$statut_o:=$heberge_e.save()
						End if 
						
					Else 
						$lineError_c.push(New object:C1471("ligne"; String:C10($j_el); "type"; $type_t))
					End if 
					
				End if 
				
			End if 
			
			$j_el:=$j_el+1
			
			outilsCollectionInit(->$date_c)
			outilsCleanVariable(->$stop_b)
		End for each 
		
		If ($lineError_c.length>0)
			
			If ($transporter_o.user#"")
				$type_c:=$lineError_c.extract("type")
				$message_t:="Bonjour"+Char:C90(Retour à la ligne:K15:40)
				
				For each ($type_t; $type_c)
					$lineErrorB_c:=$lineError_c.query("type = :1"; $type_t)
					$message_t:=$message_t+"L'import du fichier « "+$type_t+" » de la structure « "+$refStructure_t+" » comport des erreurs"+\
						Choose:C955($type_t="Notes"; ", les intitulés des notes sont différents :"; "")+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40)
					
					For each ($lineError_o; $lineError_c)
						$message_t:=$message_t+"Pour la ligne "+String:C10($lineError_o.ligne)+" : "+Choose:C955($type_t="Notes"; "intitulé de l'application mobile « "+String:C10($lineError_o.libNote)+" »"; \
							"structure manquante dans la le logiciel Paxtel « "+$refStructure_t+" »")+Char:C90(Retour à la ligne:K15:40)
					End for each 
					
				End for each 
				
				$email_o:=New object:C1471("emetteur"; "l.phanchi@paxtel.fr"; \
					"destinataire"; "l.phanchi@paxtel.fr"; \
					"objet"; "Problème import vers Paxtel"; \
					"message"; MAIL_HTML_Generate("Bonjour"; $message_t))
				
				$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
			End if 
			
		End if 
		
		outilsCleanVariable(->$column_c; ->$lineError_c; ->$lineErrorB_c; ->$j_el; ->$data_at; ->$type_c)
	End for 
	
Function synchroAppMobileExportData()->$stopSave_b : Boolean
	var $type_t; $url_t; $email_t; $intervenant_t; $contentToExtract_t; $boundary_t; $reponse_t; $message_t : Text
	var $i_el; $lastHebergeID_el; $moduloProgress_el; $j_el; $length_el; $nbBoucle_el; $tsLastExport_el : Integer
	var $stop_b; $signal_b; $reloadRequest_b; $create_b : Boolean
	var $document_b; $body_b; $response_b : Blob
	var $heberge_o; $age_o; $note_o; $option_o; $statut_o; $response_o; $transporter_o; $email_o; $signal_o : Object
	var $contentToExtract_c; $contentToExtractB_c; $proprieteToKeep_c : Collection
	
	var $file_f : 4D:C1709.File
	
	var ref_soc_active : Text
	
	ARRAY TEXT:C222($key_at; 0)  // Nom de la variable
	ARRAY TEXT:C222($val_at; 0)  // Contenu de la variable.
	
	var $heberge_es : cs:C1710.HeBergeSelection
	
	var $note_e : cs:C1710.NoteEntity
	var $note_es : cs:C1710.NoteSelection
	
	var $intervenant_e : cs:C1710.INtervenantsEntity
	var $intervenant_es : cs:C1710.INtervenantsSelection
	
	var $hebergement_e : cs:C1710.HeberGementEntity
	var $hebergement_es; $hebergementB_es : cs:C1710.HeberGementSelection
	
	var $tablesEtatCivil_es; $tablesEtatCivilB_es; $tablesPieceIdentite_es; $tablesPieceIdentiteB_es; \
		$tablesSituationPro_es; $tablesSituationProB_es; $tablesResources_es; $tablesResourcesB_es : cs:C1710.TAblesSelection
	
	var $typesTables_es : cs:C1710.TypesTablesSelection
	
	ref_soc_active:=This:C1470.Ref_Structure
	$transporter_o:=outilsMailGestion(1)
	
	$tsLastExport_el:=Num:C11(This:C1470.SO_SynchroApplicationMobile.lastTimeStampExport)-(60*Num:C11(This:C1470.SO_SynchroApplicationMobile.nbMinute))
	
	If ($tsLastExport_el<0)
		CLEAR VARIABLE:C89($tsLastExport_el)
	End if 
	
	For ($i_el; 1; 3)
		$contentToExtract_c:=New collection:C1472
		
		Case of 
			: ($i_el=1)
				$type_t:="Usagers"
			: ($i_el=2)
				$type_t:="Notes"
			: ($i_el=3)
				$type_t:="Actions"
		End case 
		
		$url_t:="https://paxtel-staging-backend.cleverapps.io/paxtel-import/add/"+Lowercase:C14($type_t)
		
		Case of 
			: ($type_t="Usagers")
				$heberge_es:=ds:C1482.HeBerge.query("HB_TimeStamp >= :1 AND importApplicationMobile = :2 AND Ref_Structure = :3"; $tsLastExport_el; False:C215; This:C1470.Ref_Structure)
				$contentToExtract_c:=$heberge_es.toCollection("HB_Clé, HB_Nom, HB_Prénom, HB_DateNéLe, HG_Genre, HB_Telephone, HB_Email,"+\
					" Ref_Structure").extract("HB_Clé"; "cle"; "HB_Nom"; "lastname"; "HB_Prénom"; "firstname"; \
					"HB_DateNéLe"; "birthDate"; "HG_Genre"; "sexe"; "HB_Telephone"; "phone"; "HB_Email"; "email"; "Ref_Structure"; "ref_structure")
				
				$tablesEtatCivil_es:=ds:C1482.TAbles.newSelection()
				$tablesPieceIdentite_es:=ds:C1482.TAbles.newSelection()
				$tablesSituationPro_es:=ds:C1482.TAbles.newSelection()
				$tablesResources_es:=ds:C1482.TAbles.newSelection()
				
				$typesTables_es:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Etat civil")
				
				If ($typesTables_es.length>0)
					$tablesEtatCivil_es:=ds:C1482.TAbles.query("TB_TT_ID = :1 AND Ref_Structure = :2"; $typesTables_es[0].TT_RéférenceID; This:C1470.Ref_Structure).orderBy("TB_Code asc")
				End if 
				
				$typesTables_es:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Pièces d'identité")
				
				If ($typesTables_es.length>0)
					$tablesPieceIdentite_es:=ds:C1482.TAbles.query("TB_TT_ID = :1 AND Ref_Structure = :2"; $typesTables_es[0].TT_RéférenceID; This:C1470.Ref_Structure).orderBy("TB_Code asc")
				End if 
				
				$typesTables_es:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Situation professionnelle")
				
				If ($typesTables_es.length>0)
					$tablesSituationPro_es:=ds:C1482.TAbles.query("TB_TT_ID = :1 AND Ref_Structure = :2"; $typesTables_es[0].TT_RéférenceID; This:C1470.Ref_Structure).orderBy("TB_Code asc")
				End if 
				
				$typesTables_es:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Ressources actuelles")
				
				If ($typesTables_es.length>0)
					$tablesResources_es:=ds:C1482.TAbles.query("TB_TT_ID = :1 AND Ref_Structure = :2"; $typesTables_es[0].TT_RéférenceID; This:C1470.Ref_Structure).orderBy("TB_Code asc")
				End if 
				
				For each ($heberge_o; $contentToExtract_c)
					$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($heberge_o.lastname; $heberge_o.firstname; String:C10($heberge_o.birthDate); $heberge_o.ref_structure; False:C215)
					$adresse_e:=ds:C1482.Adresses.searchAndCreateRecordIfDontExist($heberge_e.ID; Table:C252(->[HeBerge:4]); $heberge_o.ref_structure)
					
					$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
					
					$age_o:=outilsGetAge(Current date:C33; $heberge_o.birthDate)
					
					If ($heberge_o.birthDate=!00-00-00!)
						$heberge_o.birthDate:=""
						$heberge_o.age:=99
					Else 
						$heberge_o.birthDate:=outilsDateFrVersDateIso(String:C10($heberge_o.birthDate))
						$heberge_o.age:=$age_o.years
					End if 
					
					If (Bool:C1537($heberge_o.sexe)=True:C214)
						$heberge_o.sexe:="Féminin"
					Else 
						$heberge_o.sexe:="Masculin"
					End if 
					
					$heberge_o.lastname:=Uppercase:C13($heberge_o.lastname)
					$heberge_o["paxtel.usagerID"]:=$heberge_o.cle
					
					$hebergementB_es:=$hebergement_es.query("HG_FamClé # :1"; "").orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$heberge_o.familyID:=$hebergementB_es[0].HG_FamClé
					End if 
					
					$hebergementB_es:=$hebergement_es.orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$heberge_o.chief:=Choose:C955($hebergementB_es[0].HG_FamChef; 1; 0)
					End if 
					
					$hebergementB_es:=$hebergement_es.query("HG_Nationalité # :1"; "").orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$heberge_o.nationality:=$hebergementB_es[0].HG_Nationalité
					End if 
					
					$hebergementB_es:=$hebergement_es.query("HG_EtatCivil # :1"; "").orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$tablesEtatCivilB_es:=$tablesEtatCivil_es.query("TB_Libellé = :1"; $hebergementB_es[0].HG_EtatCivil)
						
						If ($tablesEtatCivilB_es.length>0)
							
							If ($tablesEtatCivilB_es[0].MyASquadInfo#Null:C1517)
								
								If (Num:C11($tablesEtatCivilB_es[0].MyASquadInfo.id)>0)
									$heberge_o["history.familyStatus.value"]:=String:C10($tablesEtatCivilB_es[0].MyASquadInfo.id)
								End if 
								
							End if 
							
						End if 
						
					End if 
					
					$hebergementB_es:=$hebergement_es.query("HG_PiècesIdté1 # :1"; "").orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$tablesPieceIdentiteB_es:=$tablesPieceIdentite_es.query("TB_Libellé = :1"; $hebergementB_es[0].HG_PiècesIdté1)
						
						If ($tablesPieceIdentiteB_es.length>0)
							
							If ($tablesPieceIdentiteB_es[0].MyASquadInfo#Null:C1517)
								
								If (Num:C11($tablesPieceIdentiteB_es[0].MyASquadInfo.id)>0)
									$heberge_o["history.positionAdministrative.value"]:=String:C10($tablesPieceIdentiteB_es[0].MyASquadInfo.id)
								End if 
								
							End if 
							
						End if 
						
					End if 
					
					$hebergementB_es:=$hebergement_es.query("HG_SituProfess # :1"; "").orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$tablesSituationProB_es:=$tablesSituationPro_es.query("TB_Libellé = :1"; $hebergementB_es[0].HG_SituProfess)
						
						If ($tablesSituationProB_es.length>0)
							
							If ($tablesSituationProB_es[0].MyASquadInfo#Null:C1517)
								
								If (Num:C11($tablesSituationProB_es[0].MyASquadInfo.id)>0)
									$heberge_o["history.professionalSituation.value"]:=String:C10($tablesSituationProB_es[0].MyASquadInfo.id)
								End if 
								
							End if 
							
						End if 
						
					End if 
					
					$hebergementB_es:=$hebergement_es.query("HG_Ressources1 # :1"; "").orderBy("HG_Date desc")
					
					If ($hebergementB_es.length>0)
						$tablesResourcesB_es:=$tablesResources_es.query("TB_Libellé = :1"; $hebergementB_es[0].HG_Ressources1)
						
						If ($tablesResourcesB_es.length>0)
							
							If ($tablesResourcesB_es[0].MyASquadInfo#Null:C1517)
								
								If (Num:C11($tablesResourcesB_es[0].MyASquadInfo.id)>0)
									$heberge_o["history.resources.value"]:=String:C10($tablesResourcesB_es[0].MyASquadInfo.id)
								End if 
								
							End if 
							
						End if 
						
					End if 
					
					If ($adresse_e.AD_Adresse1#"")
						$heberge_o.addressLine:=$adresse_e.AD_Adresse1
					End if 
					
					If ($adresse_e.AD_Ville#"")
						$heberge_o.addressCity:=$adresse_e.AD_Ville
					End if 
					
					If ($adresse_e.AD_Code_postal#"")
						$heberge_o.addressZipcode:=$adresse_e.AD_Code_postal
					End if 
					
					If ($adresse_e.AD_Pays#"")
						$heberge_o.addressCountry:=$adresse_e.AD_Pays
					End if 
					
					OB REMOVE:C1226($heberge_o; "cle")
				End for each 
				
			: ($type_t="Notes")
				$note_es:=ds:C1482.Note.query("detail.note[].ts >= :1 AND detail.note[].importApplicationMobile = :2 AND Ref_Structure = :3"; Num:C11(This:C1470.SO_SynchroApplicationMobile.lastTimeStampExport); False:C215; This:C1470.Ref_Structure)
				
				$proprieteToKeep_c:=New collection:C1472
				outilsManageNote(99; ->$proprieteToKeep_c; This:C1470.Ref_Structure; Current user:C182)
				
				$note_es:=$note_es.orderBy("hebergeID asc, type asc")
				
				For each ($note_e; $note_es)
					
					If ($note_e.type#"")
						
						For each ($note_o; $note_e.detail.note)
							$contentToExtract_c.push(New object:C1471(\
								"notetype"; $proprieteToKeep_c.query("field = :1"; $note_e.type)[0].lib; \
								"description"; String:C10($note_o.note)))
							
							$email_t:="E-mail vide"
							
							If (String:C10($note_o.utilisateur)#"")
								$intervenant_t:="@"+String:C10($note_o.utilisateur)+"@"
								$intervenant_es:=ds:C1482.INtervenants.query("IN_NomPrénom = :1"; $intervenant_t)
								
								If ($intervenant_es.length>0)
									$intervenant_e:=$intervenant_es.first()
									
									If (outilsRegexValidate(1; $intervenant_e.IN_Email)=True:C214)
										$email_t:=$intervenant_e.IN_Email
									End if 
									
								End if 
								
							End if 
							
							$contentToExtract_c[$contentToExtract_c.length-1]["usager.paxtel.usagerID"]:=$note_e.OneHeberge.HB_Clé
							$contentToExtract_c[$contentToExtract_c.length-1]["author.email"]:=$email_t
							$contentToExtract_c[$contentToExtract_c.length-1]["paxtel.id"]:=$note_o.UUID
							
							If ($contentToExtract_c[$contentToExtract_c.length-1]["description"]="")
								$contentToExtract_c[$contentToExtract_c.length-1]["description"]:="Note vide"
							End if 
							
							$contentToExtract_c[$contentToExtract_c.length-1]["ref_structure"]:=This:C1470.Ref_Structure
						End for each 
						
					End if 
					
				End for each 
				
			: ($type_t="Actions")
				$hebergement_es:=ds:C1482.HeberGement.query("HG_Nuit = :1 AND HG_TimeStamp >= :2 AND importApplicationMobile = :3 AND HG_Cloturée = :1 AND Ref_Structure = :4"; True:C214; Num:C11(This:C1470.SO_SynchroApplicationMobile.lastTimeStampExport); \
					False:C215; This:C1470.Ref_Structure).orderBy("HG_HB_ID asc, HG_Date desc")
				
				For each ($hebergement_e; $hebergement_es)
					
					If ($lastHebergeID_el#$hebergement_e.HG_HB_ID)
						CLEAR VARIABLE:C89($email_t)
						
						$email_t:="NR"
						
						$lastHebergeID_el:=$hebergement_e.HG_HB_ID
						$intervenant_es:=ds:C1482.INtervenants.query("IN_NomPrénom = :1"; $hebergement_e.HG_Permanencier)
						
						If ($intervenant_es.length>0)
							$intervenant_e:=$intervenant_es.first()
							
							If (outilsRegexValidate(1; $intervenant_e.IN_Email)=True:C214)
								$email_t:=$intervenant_e.IN_Email
							End if 
							
						End if 
						
					End if 
					
					$contentToExtract_c.push(New object:C1471)
					
					$contentToExtract_c[$contentToExtract_c.length-1]["actionType.name"]:=$hebergement_e.HG_CentreNom
					$contentToExtract_c[$contentToExtract_c.length-1]["usager.paxtel.usagerID"]:=$hebergement_e.HG_HB_ID_1_HB_ReferenceID.HB_Clé
					$contentToExtract_c[$contentToExtract_c.length-1]["signalementDescription"]:=Choose:C955($hebergement_e.HG_SignalCentre#""; $hebergement_e.HG_SignalCentre; "NR")
					$contentToExtract_c[$contentToExtract_c.length-1]["author.email"]:=$email_t
					$contentToExtract_c[$contentToExtract_c.length-1]["orientationMadeBy.name"]:=Choose:C955($hebergement_e.HG_Signalement#""; $hebergement_e.HG_Signalement; "NR")
					$contentToExtract_c[$contentToExtract_c.length-1]["service"]:=$hebergement_e.HG_FamGroupe
					$contentToExtract_c[$contentToExtract_c.length-1]["actionDate"]:=String:C10($hebergement_e.HG_Date)
					$contentToExtract_c[$contentToExtract_c.length-1]["comment"]:=$hebergement_e.HG_Commentaires
					$contentToExtract_c[$contentToExtract_c.length-1]["author.name"]:=$hebergement_e.HG_Permanencier
					$contentToExtract_c[$contentToExtract_c.length-1]["paxtel.id"]:=$hebergement_e.ID
					$contentToExtract_c[$contentToExtract_c.length-1]["ref_structure"]:=$hebergement_e.Ref_Structure
				End for each 
				
		End case 
		
		If ($contentToExtract_c.length>0)
			$length_el:=$contentToExtract_c.length
			$moduloProgress_el:=outilsProgressBarGetModulo($contentToExtract_c.length)
			
			If ($moduloProgress_el<200)
				$moduloProgress_el:=200
			End if 
			
			Repeat 
				$message_t:="Export des données ("+$type_t+") le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" ("+String:C10($j_el)+"/"+String:C10($length_el)+")"
				
				If (Process number:C372("formSynchroAppMobile_w")>0)
					$signal_o:=New signal:C1641("Export des données pour structure "+This:C1470.Ref_Structure+" - "+Substring:C12(Generate UUID:C1066; 1; 5))
					
					CALL FORM:C1391(Storage:C1525.synchroAppMobileWindows.refWindows; "outilsManageSynchroAppMobile"; 99; $signal_o; This:C1470.Ref_Structure; $message_t)
					$signal_b:=$signal_o.wait(120)  // Sécurité si l'incorporation du message dans le formulaire prend plus de 2 minutes
				Else 
					MESSAGE:C88($message_t+Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40))
				End if 
				
				$contentToExtractB_c:=$contentToExtract_c.slice(0; $moduloProgress_el)
				
				$contentToExtract_t:=JSON Stringify:C1217($contentToExtractB_c; *)
				TEXT TO BLOB:C554($contentToExtract_t; $document_b; UTF8 texte sans longueur:K22:17)
				
				// Création de la variable du document
				outilsCleanVariable(->$key_at; ->$val_at; ->$body_b; ->$boundary_t; ->$body_t)
				
				APPEND TO ARRAY:C911($key_at; "file.import\"; filename=\"exportToMobileApp.json\"")
				APPEND TO ARRAY:C911($val_at; "{{RAW_JFIF_DATA}}")
				
				$boundary_t:=outilsWebSetFormVariable(->$key_at; ->$val_at; ->$body_b; ->$document_b)
				$stop_b:=($boundary_t="Error@")  // Check for error after setting form variables
				
				If ($stop_b=False:C215)
					outilsCleanVariable(->$nbBoucle_el; ->$reloadRequest_b)
					
					Repeat 
						$option_o:=New object:C1471
						
						$option_o.URL:=$url_t
						$option_o.POST:=1
						$option_o.TIMEOUT:=10
						$option_o.CONNECTTIMEOUT:=10
						$option_o.CAINFO:=Folder:C1567(fk dossier ressources:K87:11).file("cacert.pem").platformPath
						$option_o.HTTPHEADER:=New collection:C1472("Authorization: Bearer af924be4ff53e7b2cf0bd53fb376898964ab16f168f"+\
							"1f19e9fd60816a0815da853ecc06b77a3415235db2c0280c6ffcbb23c565359db347cc95e306802d1882a8bfacbbc24b741dc51c"+\
							"4f46d9c3f1b05d34e2132299ed6bc82383c72e37511f4b63239e969661de6f175233a1a8f9f901b57cf25f1ed4389b5ffdb6dd3d"+\
							"18302"; "Content-Type: multipart/form-data; boundary="+$boundary_t)
						
						$statut_o:=cURL($option_o; $body_b; $response_b; "outilsCurlProgress")
						$stop_b:=($statut_o=Null:C1517)
						
						If ($stop_b=False:C215)
							
							If ($statut_o.headerInfo#"")
								$stop_b:=($statut_o.headerInfo#"@200@")
								
								If ($stop_b=False:C215)
									$reponse_t:=BLOB to text:C555($response_b; UTF8 chaîne en C:K22:15)
									
									If ($reponse_t#"") & ($reponse_t="{@}")
										$response_o:=JSON Parse:C1218($reponse_t)
										
										If ($response_o.data#Null:C1517)
											//$reloadRequest_b:=(Num($response_o.data.status)=500)
										End if 
										
									End if 
									
								Else 
									$reloadRequest_b:=True:C214
									$response_o:=New object:C1471("erreurDetail"; String:C10($statut_o.headerInfo))
								End if 
								
							End if 
							
						Else 
							$response_o:=New object:C1471("erreurDetail"; "Connexion avec le serveur de l'application mobile impossible")
						End if 
						
						If ($reloadRequest_b=True:C214)
							$nbBoucle_el:=$nbBoucle_el+1
							$message_t:="Retentative d'envoi de \""+$type_t+"\" ("+String:C10($nbBoucle_el)+"/5)"
							
							If (Process number:C372("formSynchroAppMobile_w")>0)
								$signal_o:=New signal:C1641("Export des données pour structure "+This:C1470.Ref_Structure+" - "+Substring:C12(Generate UUID:C1066; 1; 5))
								
								CALL FORM:C1391(Storage:C1525.synchroAppMobileWindows.refWindows; "outilsManageSynchroAppMobile"; 99; $signal_o; This:C1470.Ref_Structure; $message_t)
								$signal_b:=$signal_o.wait(120)  // Sécurité si l'incorporation du message dans le formulaire prend plus de 2 minutes
							Else 
								MESSAGE:C88($message_t+Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40))
							End if 
							
							$reloadRequest_b:=($nbBoucle_el<=5)
						End if 
						
					Until ($reloadRequest_b=False:C215)
					
					Case of 
						: ($stop_b=False:C215)
							$contentToExtract_c:=$contentToExtract_c.remove(0; $moduloProgress_el)
						: ($transporter_o.user#"")
							$i_el:=3  // Fin de boucle
							
							$message_t:="Un problème a été constaté pendant l'import des données de l'application mobile pour la partie "+$type_t+", merci de contacter le service informatique."+Char:C90(Retour à la ligne:K15:40)
							$message_t:=$message_t+"Détail de l'erreur : "+Char:C90(Retour à la ligne:K15:40)
							$message_t:=$message_t+JSON Stringify:C1217($response_o; *)
							
							$email_o:=New object:C1471("emetteur"; "l.phanchi@paxtel.fr"; \
								"destinataire"; "l.phanchi@paxtel.fr"; \
								"objet"; "Problème export vers application mobile"; \
								"message"; MAIL_HTML_Generate("Bonjour"; $message_t))
							
							$file_f:=Folder:C1567(fk dossier ressources:K87:11).file("TEMP/import-"+Lowercase:C14($type_t)+".json")
							
							If ($file_f.exists=True:C214)
								$file_f.delete()
							End if 
							
							$create_b:=$file_f.create()
							
							If ($create_b=True:C214)
								$file_f.setText($contentToExtract_t; "UTF-8"; Document inchangé:K24:18)
								$email_o.pieceJointe:=New collection:C1472(MAIL New attachment:C1644($file_f.platformPath))
							End if 
							
							$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
					End case 
					
				End if 
				
				$j_el:=$j_el+$moduloProgress_el
			Until ($contentToExtract_c.length=0) | ($stop_b=True:C214)
			
			$stopSave_b:=$stop_b
			CLEAR VARIABLE:C89($j_el)
		End if 
		
	End for 