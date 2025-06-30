var $position_t; $reponse_t; $url_t; $typeNote_t; $refStructure_t; $action_t; $body_t; \
$contentToExtract_t; $email_t; $intervenant_t : Text
var $lengthMax_el; $moduloProgress_el; $i_el; $lastHebergeID_el : Integer
var $import_b; $export_b; $create_b; $stop_b : Boolean
var $body_b; $document_b; $response_b : Blob
var $statut_o; $hebergement_o; $heberge_o; $age_o; $response_o; $option_o; $statut_o; $note_o; $param_o : Object
var $lines_c; $column_c; $proprieteToKeep_c; $lineError_c; $contentToExtract_c; $contentToExtractB_c; $date_c : Collection

var $file_f : 4D:C1709.File

ARRAY TEXT:C222($key_at; 0)  // Nom de la variable
ARRAY TEXT:C222($val_at; 0)  // Contenu de la variable.

ARRAY TEXT:C222($column_at; 0; 0)

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

var $adresse_e : cs:C1710.AdressesEntity

var $note_e : cs:C1710.NoteEntity
var $note_es : cs:C1710.NoteSelection

var $centres_e : cs:C1710.LesCentresEntity
var $centres_es : cs:C1710.LesCentresSelection

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

var $structure_es : cs:C1710.StructuresSelection

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

READ WRITE:C146([HeberGement:5])

$position_t:="center"
outilsCreateWindowsForm("FormConfirm3Choix"; ->$position_t; \
New object:C1471("message"; "Voulez-vous importer les données de l'application mobile ?"; \
"boutonAccept"; New object:C1471("label"; "Importer"); \
"boutonCancel"; New object:C1471("label"; "Exporter"); \
"boutonThird"; New object:C1471("label"; "Annuler")))

If (selectValue_t="") | (selectValue_t="Autre")
	return 
End if 

//CONFIRMER("Voulez-vous importer les données de l'application mobile ?"; "Importer"; "Exporter")
//$import_b:=(OK=1)

$import_b:=(selectValue_t="Accepter")
$export_b:=Not:C34($import_b)

$date_c:=New collection:C1472
$lineError_c:=New collection:C1472

$position_t:="center"
outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("type"; "Usagers"); New object:C1471("type"; "Notes"); New object:C1471("type"; "Actions")); \
"property"; "type"; "selectSubTitle"; "Choix du type de données à "+Choose:C955($import_b; "importer"; "exporter"); "title"; "Choix du type de données :"))

If (selectValue_t#"")
	
	Case of 
		: ($import_b)
			$url_t:="https://paxtel-staging-backend.cleverapps.io/paxtel-export/generate/"+Lowercase:C14(selectValue_t)+"?ref_structure="+<>ref_soc_active+"&startDate=2023-01-01&endDate="+outilsDateFrVersDateIso(String:C10(Current date:C33))+"&token=61f9a47389fb"+\
				"1334d9736ea998e754b5a6a6750f4b50286f434f2ad665d2fc3b7efd5d120f6f3dc4dae8975be5dec966f873543f2dbfd642ca0547ea37813178df70fc7bc3a7db94f76dbf96182b7f8839ac167571b6fbe54ae62c6019abcb235b3f717b56f9003b3973e3b15"+\
				"cb33a5e38cac46828d87e232952155f6ad5cf19"
			
			outilsWebHTTPRequest("GET"; $url_t; ""; ->$reponse_t)
			//$lines_c:=Séparer chaine($reponse_t; Caractère(Retour à la ligne))
			
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
			
			If (selectValue_t="Notes")
				$proprieteToKeep_c:=New collection:C1472
				outilsManageNote(99; ->$proprieteToKeep_c; <>ref_soc_active; Current user:C182)
			End if 
			
			// Intégration des données du fichier csv avec les données du matching
			$lengthMax_el:=$lines_c.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($column_c; $lines_c)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lines_c.length; "Récupération des données en cours ("+String:C10($i_el)+"/"+String:C10($lines_c.length)+")..."; True:C214)
				End if 
				
				If ($i_el>0)
					//$column_c:=Séparer chaine($line_t; ",")
					
					Case of 
						: (selectValue_t="Usagers")
							$refStructure_t:=$column_c[2]
						: (selectValue_t="Notes")
							$refStructure_t:=$column_c[1]
						: (selectValue_t="Actions")
							$refStructure_t:=$column_c[19]
					End case 
					
					outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]Ref_Structure:3; $refStructure_t; ->$structure_es)
					
					If ($structure_es.length>0)
						
						Case of 
							: (selectValue_t="Usagers")
								// Création de l'enregistrement dans la table [HeBerge]
								$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($column_c[4]; $column_c[5]; $column_c[6]; $refStructure_t)
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
									$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[30])); False:C215)
								End if 
								
								If (Date:C102(outilsDateUsVersDateFr($column_c[34]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[34])))=-1)  // Colonne history.resources.date
									$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[34])))
									$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[34])); False:C215)
								End if 
								
								If (Date:C102(outilsDateUsVersDateFr($column_c[38]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[38])))=-1)  // Colonne history.positionAdministrative.date
									$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[38])))
									$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[38])); False:C215)
								End if 
								
								If (Date:C102(outilsDateUsVersDateFr($column_c[42]))#!00-00-00!) & ($date_c.indexOf(Date:C102(outilsDateUsVersDateFr($column_c[42])))=-1)  // Colonne history.professionalSituation.date
									$date_c.push(Date:C102(outilsDateUsVersDateFr($column_c[42])))
									$hebergement_e:=ds:C1482.HeberGement.createEntityAppMobileImportDataHeberge($column_c; $heberge_e; $refStructure_t; Date:C102(outilsDateUsVersDateFr($column_c[42])); False:C215)
								End if 
								
							: (selectValue_t="Notes")
								$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($column_c[6]; $column_c[7]; $column_c[8]; $refStructure_t)
								
								If ($proprieteToKeep_c.query("lib = :1"; $column_c[3]).length>0)
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
											"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
										
										$statut_o:=$note_e.save()
									End if 
									
								Else 
									$lineError_c.push($i_el)
								End if 
								
							: (selectValue_t="Actions")
								// Création de l'enregistrement dans la table [HeBerge]
								$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($column_c[5]; $column_c[7]; $column_c[6]; $refStructure_t)
								$heberge_e.reload()
								
								// Création de l'enregistrement dans la table [HeberGement]
								$hebergement_e:=ds:C1482.HeberGement.new()
								
								$hebergement_e.HG_Date:=Date:C102($column_c[1])
								//$hebergement_e.HG_RéservationDateFin:=Date($column_c[1])
								
								$hebergement_e.HG_HeureAppel:=Current time:C178()
								$hebergement_e.HG_FicheNuméro:=i_HébérgementNoFiche("J"; $hebergement_e.HG_Date; Uut_Numerote115($hebergement_e.HG_Date))
								
								//$hebergement_e.HG_EnAttente:=Vrai
								$hebergement_e.HG_DateDuJour:=Current date:C33
								$hebergement_e.HG_AttenteHeur:=Current time:C178()
								
								If (<>vb_T_ModeCHRS)
									$hebergement_e.HG_Plateforme:=<>va_UserPlateforme
								End if 
								
								$hebergement_e.HG_FamGroupe:=$column_c[14]
								
								//$hebergement_e.HG_LC_ID:=[LesCentres]LC_RéférenceID
								//$hebergement_e.HG_CentreNom:=$form_o.centre
								$hebergement_e.HG_ReferenceID:=Uut_Numerote(->[HeberGement:5])
								
								//Si ($nbJour_el>0)
/*
$hebergement_e.HG_NuitenCours:=1+$i_el
$hebergement_e.HG_NuitTOTAL:=$nbJour_el
$hebergement_e.HG_NuitReste:=$hebergement_e.HG_NuitTOTAL-$hebergement_e.HG_NuitenCours
*/
								//Fin de si 
								
								$hebergement_e.HG_Permanencier:=$column_c[22]
								
								$hebergement_e.HG_Coordinateur:=<>va_HG_Coordinateur
								$hebergement_e.HG_Régulateur:=<>va_HG_Régulateur
								
								$hebergement_e.HG_Nom:=$heberge_e.HB_Nom
								$hebergement_e.HG_Prénom:=$heberge_e.HB_Prénom
								$hebergement_e.HG_HB_ID:=$heberge_e.HB_ReferenceID
								
								$hebergement_e.HG_FamChef:=($hebergement_e.HG_FamClé#"")
								$hebergement_e.HG_FamClé:=$column_c[4]
								
								//$hebergement_e.HG_EnAttente:=Vrai
								
								//$hebergement_e.HG_Cloturée:=Vrai
								
								$hebergement_e.HG_DateCreationFiche:=Current date:C33(*)
								$hebergement_e.HG_ModifDateHeures:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))
								//$hebergement_e.HG_ReservationProvisoire:=(reservationProvisoire_at{reservationProvisoire_at}="Oui")
								//$hebergement_e.HG_Réservation:=(reservationProvisoire_at{reservationProvisoire_at}="Non")
								
								$hebergement_e.HG_Nationalité:=$column_c[8]
								$hebergement_e.HG_EtatCivil:=$column_c[9]
								$hebergement_e.HG_PiècesIdté1:=$column_c[10]
								$hebergement_e.HG_Ressources1:=$column_c[11]
								$hebergement_e.HG_SituProfess:=$column_c[12]
								$hebergement_e.HG_Commentaires:=$column_c[13]
								
								$hebergement_e.HG_Signalement:=$column_c[24]
								
								$hebergement_e.Ref_Structure:=<>ref_soc_active
								
								$hebergement_e.save()
								$hebergement_o:=$hebergement_e.toObject()
								
								$centres_es:=ds:C1482.LesCentres.query("LC_Nom = :1"; $column_c[17])
								
								If ($centres_es.length>0)
									$centres_e:=$centres_es.first()
									
									$centres_e.LC_Categorie:=$column_c[16]
									$statut_o:=$centres_e.save()
								End if 
								
								For ($i_el; 1; Num:C11($column_c[15]))
									$hebergement_e:=ds:C1482.HeberGement.new()
									
									$hebergement_e.fromObject($hebergement_o)
									$statut_o:=$hebergement_e.save()
								End for 
								
						End case 
						
						$statut_o:=$heberge_e.save()
					Else 
						$lineError_c.push($i_el)
					End if 
					
				End if 
				
				$i_el:=$i_el+1
				outilsCollectionInit(->$date_c)
			End for each 
			
			outilsProgressBar(1; "arrêt")
			
			If ($lineError_c.length>0)
				ALERT:C41(String:C10($lineError_c.length)+" ligne(s) n'ont pas pu être récupérées, merci de contacter le service informatique.")
			End if 
			
		: ($export_b)
			$action_t:=selectValue_t
			$url_t:="https://paxtel-staging-backend.cleverapps.io/paxtel-import/add/"+Lowercase:C14($action_t)
			
			outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("depuis"; "Le début"); New object:C1471("depuis"; "1 an"); New object:C1471("depuis"; "1 mois")); \
				"property"; "depuis"; "selectSubTitle"; "Délai de recherche"; "title"; "Choix du délai de recherche :"))
			
			Case of 
				: ($action_t="Usagers")
					
					Case of 
						: (selectValue_t="Le début")
							$heberge_es:=ds:C1482.HeBerge.all()
						: (selectValue_t="1 an")
							$heberge_es:=ds:C1482.HeBerge.query("HB_TimeStamp >= :1"; outilsTimeStamp(Add to date:C393(Current date:C33; -1; 0; 0); Current time:C178))
						: (selectValue_t="1 mois")
							$heberge_es:=ds:C1482.HeBerge.query("HB_TimeStamp >= :1"; outilsTimeStamp(Add to date:C393(Current date:C33; 0; -1; 0); Current time:C178))
					End case 
					
					$contentToExtract_c:=New collection:C1472
					
					If (selectValue_t#"")
						outilsOrdaSearchByRefStctre(->$heberge_es)
						$contentToExtract_c:=$heberge_es.toCollection("HB_Clé, HB_Nom, HB_Prénom, HB_DateNéLe, Ref_Structure").extract("HB_Clé"; "cle"; "HB_Nom"; "lastname"; "HB_Prénom"; "firstname"; "HB_DateNéLe"; "birthDate"; "Ref_Structure"; "ref_structure")
						
						$lengthMax_el:=$contentToExtract_c.length
						$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
						
						outilsProgressBar(0; "Initialisation"; True:C214)
						
						For each ($heberge_o; $contentToExtract_c)
							
							If ($i_el%$moduloProgress_el=0)
								outilsProgressBar($contentToExtract_c.indexOf($heberge_o)/$lengthMax_el; "Extraction des données en cours ("+String:C10($contentToExtract_c.indexOf($heberge_o))+"/"+String:C10($lengthMax_el)+")..."; True:C214)
							End if 
							
							$age_o:=outilsGetAge(Current date:C33; $heberge_o.birthDate)
							
							If ($heberge_o.birthDate=!00-00-00!)
								$heberge_o.birthDate:=""
								$heberge_o.age:=99
							Else 
								$heberge_o.birthDate:=outilsDateFrVersDateIso(String:C10($heberge_o.birthDate))
								$heberge_o.age:=$age_o.years
							End if 
							
							$heberge_o["paxtel.usagerID"]:=$heberge_o.cle
							
							$i_el:=$i_el+1
							OB REMOVE:C1226($heberge_o; "cle")
						End for each 
						
						outilsProgressBar(1; "arrêt")
					End if 
					
				: ($action_t="Notes")
					
					Case of 
						: (selectValue_t="Le début")
							$note_es:=ds:C1482.Note.all()
						: (selectValue_t="1 an")
							$note_es:=ds:C1482.Note.query("detail.note[].ts >= :1"; outilsTimeStamp(Add to date:C393(Current date:C33; -1; 0; 0); Current time:C178))
						: (selectValue_t="1 mois")
							$note_es:=ds:C1482.HeBerge.query("detail.note[].ts >= :1"; outilsTimeStamp(Add to date:C393(Current date:C33; 0; -1; 0); Current time:C178))
					End case 
					
					outilsOrdaSearchByRefStctre(->$note_es)
					$contentToExtract_c:=New collection:C1472
					
					$proprieteToKeep_c:=New collection:C1472
					outilsManageNote(99; ->$proprieteToKeep_c; <>ref_soc_active; Current user:C182)
					
					$note_es:=$note_es.orderBy("hebergeID asc, type asc")
					
					$lengthMax_el:=$note_es.length
					$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
					
					outilsProgressBar(0; "Initialisation"; True:C214)
					
					For each ($note_e; $note_es)
						
						If ($i_el%$moduloProgress_el=0)
							outilsProgressBar($note_e.indexOf($note_es)/$lengthMax_el; "Extraction des données en cours ("+String:C10($note_e.indexOf($note_es))+"/"+String:C10($lengthMax_el)+")..."; True:C214)
						End if 
						
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
							
							If ($contentToExtract_c[$contentToExtract_c.length-1]["author.email"]="")
								$contentToExtract_c[$contentToExtract_c.length-1]["author.email"]:=$email_t
							End if 
							
							If ($contentToExtract_c[$contentToExtract_c.length-1]["description"]="")
								$contentToExtract_c[$contentToExtract_c.length-1]["description"]:="Note vide"
							End if 
							
						End for each 
						
						$i_el:=$i_el+1
					End for each 
					
					outilsProgressBar(1; "arrêt")
				: ($action_t="Actions")
					
					Case of 
						: (selectValue_t="Le début")
							$hebergement_es:=ds:C1482.HeberGement.query("HG_Nuit = :1"; True:C214)
						: (selectValue_t="1 an")
							$hebergement_es:=ds:C1482.HeberGement.query("HG_Nuit = :1 AND HG_TimeStamp >= :2"; True:C214; outilsTimeStamp(Add to date:C393(Current date:C33; -1; 0; 0); Current time:C178))
						: (selectValue_t="1 mois")
							$hebergement_es:=ds:C1482.HeberGement.query("HG_Nuit = :1 AND HG_TimeStamp >= :2"; True:C214; outilsTimeStamp(Add to date:C393(Current date:C33; 0; -1; 0); Current time:C178))
					End case 
					
					outilsOrdaSearchByRefStctre(->$hebergement_es)
					$contentToExtract_c:=New collection:C1472
					
					$hebergement_es:=$hebergement_es.orderBy("HG_HB_ID asc, HG_Date desc")
					
					$lengthMax_el:=$hebergement_es.length
					$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
					
					outilsProgressBar(0; "Initialisation"; True:C214)
					
					For each ($hebergement_e; $hebergement_es)
						
						If ($i_el%$moduloProgress_el=0)
							outilsProgressBar($hebergement_e.indexOf($hebergement_es)/$lengthMax_el; "Extraction des données en cours ("+String:C10($hebergement_e.indexOf($hebergement_es))+"/"+String:C10($lengthMax_el)+")..."; True:C214)
						End if 
						
						If ($lastHebergeID_el#$hebergement_e.HG_HB_ID)
							CLEAR VARIABLE:C89($email_t)
							
							$email_t:="E-mail vide"
							
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
						$contentToExtract_c[$contentToExtract_c.length-1]["signalementDescription"]:=$hebergement_e.HG_SignalCentre
						$contentToExtract_c[$contentToExtract_c.length-1]["author.email"]:=$email_t
						$contentToExtract_c[$contentToExtract_c.length-1]["orientationMadeBy.name"]:=$hebergement_e.HG_Signalement
						$contentToExtract_c[$contentToExtract_c.length-1]["service"]:=$hebergement_e.HG_FamGroupe
						$contentToExtract_c[$contentToExtract_c.length-1]["paxtel.id"]:=$hebergement_e.ID
						$contentToExtract_c[$contentToExtract_c.length-1]["ref_structure"]:=$hebergement_e.Ref_Structure
						
						$i_el:=$i_el+1
					End for each 
					
					outilsProgressBar(1; "arrêt")
			End case 
			
			If ($contentToExtract_c.length>0)
				outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("typeFichier"; "JSON"); New object:C1471("typeFichier"; "CSV")); \
					"property"; "typeFichier"; "selectSubTitle"; "Type de fichier d'export"; "title"; "Choix du type de fichier :"))
				
				If (selectValue_t#"")
					CLEAR VARIABLE:C89($i_el)
					
					$lengthMax_el:=$contentToExtract_c.length
					$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
					
					If ($moduloProgress_el<200)
						$moduloProgress_el:=200
					End if 
					
					outilsProgressBar(0; "Initialisation"; True:C214)
					
					Repeat 
						
						If ($i_el%$moduloProgress_el=0)
							outilsProgressBar($i_el/$lengthMax_el; "Export des données vers l'application mobile en cours ("+String:C10($i_el)+"/"+String:C10($lengthMax_el)+")..."; True:C214)
						End if 
						
/*
$file_f:=Dossier(fk dossier ressources).folder("TEMP").file("exportToMobileApp."+Minusc(selectValue_t))
						
Si ($file_f.exists=Vrai)
$file_f.delete()
Fin de si 
						
$create_b:=$file_f.create()
*/
						
						//Si ($create_b=Vrai)
						$contentToExtractB_c:=$contentToExtract_c.slice(0; $moduloProgress_el)
						
						If (selectValue_t="JSON")
							$contentToExtract_t:=JSON Stringify:C1217($contentToExtractB_c; *)
							TEXT TO BLOB:C554($contentToExtract_t; $document_b; UTF8 texte sans longueur:K22:17)
							
/*
$file_f.setText($contentToExtract_t; "UTF-8"; Document avec LF)
*/
						Else 
							$contentToExtractB_c:=$contentToExtractB_c.map("outilsCollectionValueToCntCSV"; New collection:C1472("paxtel.usagerID"; "lastname"; "firstname"; "birthDate"; "age"; "ref_structure"))
							$file_f.setText($contentToExtractB_c.join(Char:C90(Retour à la ligne:K15:40); ck ignore null or empty:K85:5); Document avec LF:K24:22)
						End if 
						
/*
//$document_b:=$file_f.getContent()
$document_t:=$file_f.getText("UTF-8"; Document inchangé)
TEXTE VERS BLOB($document_t; $document_b; UTF8 texte sans longueur)
*/
						
						// Création de la variable du document
						outilsCleanVariable(->$key_at; ->$val_at; ->$body_b; ->$boundary_t; ->$body_t)
						
						APPEND TO ARRAY:C911($key_at; "file.import\"; filename=\"exportToMobileApp.json\"")
						APPEND TO ARRAY:C911($val_at; "{{RAW_JFIF_DATA}}")
						
						$boundary_t:=outilsWebSetFormVariable(->$key_at; ->$val_at; ->$body_b; ->$document_b)
						//$body_t:=BLOB vers texte($body_b; UTF8 chaîne en C)
						
						$stop_b:=($boundary_t="Error@")  // Check for error after setting form variables
						
						If ($stop_b=False:C215)
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
							
							//outilsWebHTTPRequest("POST"; $url_t; $body_b; ->$response_o; Créer collection("Authorization"; "Content-Type"); Créer collection("Bearer af924be4ff53e7b2cf0bd53fb376898964ab16f168f"+\
																																																																								"1f19e9fd60816a0815da853ecc06b77a3415235db2c0280c6ffcbb23c565359db347cc95e306802d1882a8bfacbbc24b741dc51c"+\
																																																																								"4f46d9c3f1b05d34e2132299ed6bc82383c72e37511f4b63239e969661de6f175233a1a8f9f901b57cf25f1ed4389b5ffdb6dd3d"+\
																																																																								"18302"; "multipart/form-data; boundary="+$boundary_t))
							
							$stop_b:=($statut_o.headerInfo#"@200@")
							//$stop_b:=(Num($response_o.data.status)#200)
							
							$reponse_t:=BLOB to text:C555($response_b; UTF8 chaîne en C:K22:15)
							$response_o:=JSON Parse:C1218($reponse_t)
							
							If ($stop_b=False:C215)
								$contentToExtract_c:=$contentToExtract_c.remove(0; $moduloProgress_el)
							Else 
								ALERT:C41(JSON Stringify:C1217($response_o; *))
							End if 
							
						End if 
						
						//Sinon 
						//ALERTE("Le fichier temporaire en vu de l'export vers l'application mobile n'a pas pu se créé, impossible de continuer")
						//Fin de si 
						
						$i_el:=$i_el+$moduloProgress_el
					Until ($contentToExtract_c.length=0) | ($stop_b=True:C214)  //| ($create_b=Faux)
					
					outilsProgressBar(1; "arrêt")
				End if 
				
			End if 
			
	End case 
	
End if 