//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 21/02/22, 14:25:47
// ----------------------------------------------------
// Méthode : outilsPaxtelRetroactif
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Object  // Entity [HeBerge] optionnel
var $3 : Boolean

var $propriete_t; $note_t; $datePotentielB_t; $fileName_t; $content_t; $query_t; $noteTransformText_t; $nom_t; $prenom_t; $login_t; $methodeDemarrage_t; $motDePasse_t : Text
var $lengthMax_el; $moduloProgress_el; $i_el; $j_el; $position_el; $nbUtilisation_el : Integer
var $noteExtract_b; $displayProgressBar_b : Boolean
var $dateNeLe_d; $date_d; $derniereUtilisation_d : Date
var $table_o; $enregistrement_o; $statut_o; $note_o; $erreurDetail_o; $querySettings_o : Object
var $propriete_c; $proprieteToKeep_c; $note_c; $noteNotExtract_c; $noteError_c; $noteExist_c : Collection

var $export_f : 4D:C1709.File

var $adresse_es : cs:C1710.AdressesSelection

var $facture_e : cs:C1710.FacturesEntity
var $facture_es : cs:C1710.FacturesSelection

var $hebergement_es : cs:C1710.HeberGementSelection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

var $note_e : cs:C1710.NoteEntity
var $note_es : cs:C1710.NoteSelection

var $tableFusion_es; $tableFusionB_es : cs:C1710.TableFusionsSelection

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

var $privilege_e : cs:C1710.PrivilegeEntity
var $privilege_es; $privilegeNotDrop_es : cs:C1710.PrivilegeSelection

var $intervenantPrivilege_e : cs:C1710.IntervenantsPrivilegeEntity

var $structure_e : cs:C1710.StructuresEntity

var $structureUser_e : cs:C1710.Structure_UserEntity
var $structureUser_es : cs:C1710.Structure_UserSelection

var $participationWebBudget_e : cs:C1710.ParticipationsWebBudgetEntity
var $participationWebDette_e : cs:C1710.ParticipationsWebDetteEntity

var $messagerie_e : cs:C1710.MessagerieEntity
var $messagerie_es : cs:C1710.MessagerieSelection

ARRAY TEXT:C222($privilege_at; 0)
ARRAY TEXT:C222($utilisateur_at; 0)

ARRAY LONGINT:C221($privilegeID_ai; 0)
ARRAY LONGINT:C221($utilisateur_ai; 0)
ARRAY LONGINT:C221($userGroupe_ai; 0)

$displayProgressBar_b:=True:C214

If (Count parameters:C259=3)
	$displayProgressBar_b:=$3
End if 

Case of 
	: ($1=1)  // Recalcul des âges
		
		// Modifié par : Scanu rémy (02/05/2023)
		// Possibilité d'appliquer l'effet rétro-actif à une ou plusieurs personnes
		If (Count parameters:C259=2)
			$table_o:=$2.HB_ReferenceID_1_HG_HB_ID
		Else 
			$table_o:=ds:C1482.HeberGement.all()
		End if 
		
		outilsOrdaSearchByRefStctre(->$table_o)
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			outilsProgressBar(($enregistrement_o.indexOf($table_o)+1)/$table_o.length; "Recalcul des âges en cours..."; True:C214)
			
			$dateNeLe_d:=$enregistrement_o.HG_DateNéLe
			$date_d:=$enregistrement_o.HG_Date
			
			$enregistrement_o.HG_Age:=Uut_HébergéAgePlus(->$dateNeLe_d; ->$date_d)
			$statut_o:=$enregistrement_o.save()
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=2)  // Transformation des notes pour extraire la date, l'heure et le contenu des notes
		CONFIRM:C162("Souhaitez-vous prendre la sélection ?"; "Oui"; "Non")
		
		If (OK=1)
			outilsHebergeLoadRecord
			$table_o:=ds:C1482.HeBerge.query("ID = :1"; [HeBerge:4]ID:65)
		Else 
			$table_o:=ds:C1482.HeBerge.query("HB_NoteExtract = :1"; False:C215)
		End if 
		
		outilsOrdaSearchByRefStctre(->$table_o)
		
		If ($table_o.length>0)
			$propriete_c:=OB Keys:C1719($table_o.first())
			$proprieteToKeep_c:=New collection:C1472
			$noteNotExtract_c:=New collection:C1472
			
			For each ($propriete_t; $propriete_c)
				
				If (($propriete_t="@Note@") & ($propriete_t#"AllNote") & ($propriete_t#"HB_NoteExtract")) | ($propriete_t="@HB_Maraude") | ($propriete_t="@HB_Maraude2")
					$proprieteToKeep_c.push($propriete_t)
				End if 
				
			End for each 
			
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
				
				If (($enregistrement_o.indexOf($table_o)%100)=0)
					outilsProgressBar(($enregistrement_o.indexOf($table_o)+1)/$table_o.length; "Transformation des notes..."; True:C214)
				End if 
				
				$noteExtract_b:=True:C214
				
				For each ($propriete_t; $proprieteToKeep_c)
					
					If ($enregistrement_o[$propriete_t]#"")
						$note_t:=$enregistrement_o[$propriete_t]
						
						If ($note_t="@<span@")
							$note_t:=Replace string:C233($note_t; "<br/>"; "")
							$note_t:=Replace string:C233($note_t; "<br />"; "")
							$note_t:=Replace string:C233($note_t; "<br>"; "")
							
							$note_t:=Replace string:C233($note_t; "<span>"; "")
							$note_t:=Replace string:C233($note_t; "</span>"; "")
						End if 
						
						If ($note_t#"@<span@")
							$note_es:=$enregistrement_o.AllNote.query("type = :1"; $propriete_t)
							
							If ($note_es.length=0)
								$note_e:=ds:C1482.Note.new()
								
								$note_e.detail:=New object:C1471
								$note_e.detail.note:=New collection:C1472
								
								$note_e.Ref_Structure:=<>ref_soc_active
								$note_e.hebergeID:=$enregistrement_o.ID
								$note_e.type:=$propriete_t
								
								$statut_o:=$note_e.save()
							Else 
								$note_e:=$note_es.first()
							End if 
							
							$note_c:=New collection:C1472
							
							// On nettoie la note de la mise en forme éventuelle appliquée
							$note_t:=Replace string:C233($note_t; Char:C90(Retour à la ligne:K15:40); "")
							$note_t:=Replace string:C233($note_t; Char:C90(Retour chariot:K15:38); "")
							$note_t:=Replace string:C233($note_t; Char:C90(Tabulation:K15:37); "")
							$note_t:=Replace string:C233($note_t; "*"; " ")
							
							While ($note_t="@  @")
								$note_t:=Replace string:C233($note_t; "  "; " ")
							End while 
							
							While (Substring:C12($note_t; 1; 1)=" ")
								$note_t:=Substring:C12($note_t; 2)
							End while 
							
							$datePotentielB_t:=Substring:C12($note_t; 1; 8)  // La date est sous ce format JJ/MM/AA
							
							If (Date:C102($datePotentielB_t)=!00-00-00!)  // Si la note ne commence par une date, on en met une par défaut pour pouvoir la retrouver par la suite
								$note_t:=Insert string:C231($note_t; "01/01/1900 - 12:00:00 - "; 0)
							End if 
							
							outilsManageNote(2; $note_t; $propriete_t; ->$note_c)
							$noteError_c:=$note_c.query("heure = :1"; "23:59:59")
							
							Case of 
								: ($noteError_c.length>0)  // Des erreurs d'extraction ont été constaté pour ce type de note
									CLEAR VARIABLE:C89($noteExtract_b)
									
									$note_e.drop()
									$noteNotExtract_c.push(New object:C1471("id"; $enregistrement_o.ID; "type"; $propriete_t; "prenom"; $enregistrement_o.HB_Prénom; "nom"; \
										$enregistrement_o.HB_Nom; "erreurDetail"; $noteError_c.copy()))
								: ($note_e.detail.note.length=0)  // Aucune note n'a encore été ajouté pour ce type de note
									$note_e.detail.note:=$note_e.detail.note.combine($note_c)
									$statut_o:=$note_e.save()
								Else   // Des notes ont déjà été ajoutés à cet hébergé pour ce type de note, ajout postérieur à la transformation des anciennes en nouvelles notes
									
									For each ($note_o; $note_c)
										$noteExist_c:=$note_e.detail.note.query("date = :1 AND heure = :2"; $note_o.date; $note_o.heure)
										
										If ($noteExist_c.length=0)
											$note_e.detail.note.push($note_o)
										End if 
										
									End for each 
									
									$statut_o:=$note_e.save()
							End case 
							
						Else 
							CLEAR VARIABLE:C89($noteExtract_b)
							$noteNotExtract_c.push(New object:C1471("id"; $enregistrement_o.ID; "type"; $propriete_t; "prenom"; $enregistrement_o.HB_Prénom; "nom"; \
								$enregistrement_o.HB_Nom; "erreurDetail"; New collection:C1472(New object:C1471("date"; !1900-01-01!; "heure"; ?00:00:01?; "note"; "présence de code HTML : "+$note_t))))
						End if 
						
					End if 
					
				End for each 
				
				If (($noteExtract_b=True:C214) & ($enregistrement_o.AllNote.length>0)) | (($noteExtract_b=True:C214) & ($enregistrement_o.AllNote.length=0))  // S'il y avait des notes présentes et qu'elles ont toutes pu être extraites OU aucune note de présente
					$enregistrement_o.HB_NoteExtract:=True:C214
					$enregistrement_o.save()
				End if 
				
			End for each 
			
			outilsProgressBar(1; "arrêt")
			
			If ($noteNotExtract_c.length>0)
				$noteNotExtract_c:=$noteNotExtract_c.orderBy("nom asc, type asc")
				ALERT:C41("Des notes n'ont pas pu être traitées car elles comportaient certaines erreurs (présence de code HTML et/ou formatage des notes incorrectes, veuillez choisir le lieu du fichier d'export de celles-ci")
				
				$fileName_t:=Select document:C905(System folder:C487(Bureau:K41:16)+"exportNoteNonTraite.csv"; "csv"; "Nom de du fichier d'export pour les notes non traitées :"; Saisie nom de fichier:K24:17)
				
				If (OK=1)
					$export_f:=File:C1566(Document; fk chemin plateforme:K87:2)
					outilsProgressBar(0; "Initialisation"; True:C214)
					
					$content_t:=$content_t+"Nom"+Char:C90(Tabulation:K15:37)+"Prénom"+Char:C90(Tabulation:K15:37)+"Type de note"+Char:C90(Tabulation:K15:37)+"Erreur date"+Char:C90(Tabulation:K15:37)+"Erreur heure"+Char:C90(Tabulation:K15:37)+\
						"Erreur détail"+Char:C90(Retour à la ligne:K15:40)
					
					For each ($note_o; $noteNotExtract_c)
						
						If (($noteNotExtract_c.indexOf($note_o)%10)=0)
							outilsProgressBar(($noteNotExtract_c.indexOf($note_o)+1)/$noteNotExtract_c.length; "Export des notes non traitées en cours..."; False:C215)
						End if 
						
						For each ($erreurDetail_o; $note_o.erreurDetail)
							$content_t:=$content_t+String:C10($note_o.nom)+Char:C90(Tabulation:K15:37)+String:C10($note_o.prenom)+Char:C90(Tabulation:K15:37)+String:C10($note_o.type)+Char:C90(Tabulation:K15:37)+\
								String:C10($erreurDetail_o.date)+Char:C90(Tabulation:K15:37)+String:C10($erreurDetail_o.heure)+Char:C90(Tabulation:K15:37)+String:C10($erreurDetail_o.note)+Char:C90(Retour à la ligne:K15:40)
						End for each 
						
					End for each 
					
					outilsProgressBar(1; "arrêt")
					
					$export_f.setText($content_t)
					ALERT:C41("L'export des notes non traitées a bien été réalisé.")
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Aucune hébergé n'a pu être trouvé pour la transformation vers les « Nouvelles Notes »")
		End if 
		
	: ($1=3)  // Reformatage au sein des nouvelles notes de note qui contiennent du code HTML
		$querySettings_o:=New object:C1471("parameters"; New object:C1471; "context"; "liste")
		
		$querySettings_o.parameters.noteHTML:="@span@"
		$query_t:=$query_t+"detail.note[].note = :noteHTML"
		
		$querySettings_o.parameters.refStructure:=<>ref_soc_active
		$query_t:=$query_t+" AND Ref_Structure = :refStructure"
		
		$note_es:=ds:C1482.Note.query($query_t; $querySettings_o)
		
		$lengthMax_el:=$note_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($note_e; $note_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Transformation des notes HTML en note au format Texte..."; False:C215)
			End if 
			
			$note_c:=$note_e.detail.note.query("note = :1"; "@span@")
			
			For each ($note_o; $note_c)
				$noteTransformText_t:=outilsCleanTagText($note_o.note; "\\&lt;.*?\\&gt;"; "")
				$note_o.note:=$noteTransformText_t
			End for each 
			
			$statut_o:=$note_e.save()
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=4)  // Calcul de la première date de contact
		
		// Modifié par : Scanu rémy (02/05/2023)
		// Possibilité d'appliquer l'effet rétro-actif à une ou plusieurs personnes
		If (Count parameters:C259=2)
			$table_o:=$2.HB_ReferenceID_1_HG_HB_ID
		Else 
			$table_o:=ds:C1482.HeberGement.all()
		End if 
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Calcul de la date de premier contact..."; True:C214)
			End if 
			
			$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Nuit = :2"; $enregistrement_o.HG_HB_ID; $enregistrement_o.HG_Nuit).orderBy("HG_Date asc")
			$enregistrement_o.reload()
			
			If ($hebergement_es.length=1) & ($enregistrement_o.HG_DatePremierContact#!00-00-00!)
				
				If ($enregistrement_o.HG_DatePremierContact#$hebergement_es[0].HG_Date)
					$enregistrement_o.HG_DatePremierContact:=$hebergement_es[0].HG_Date
					$statut_o:=$enregistrement_o.save()
				End if 
				
			Else 
				$enregistrement_o.HG_DatePremierContact:=$hebergement_es[0].HG_Date
				$statut_o:=$enregistrement_o.save()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=5)  // Regénération du mois et de l'année pour les factures
		$table_o:=ds:C1482.Factures.query("FAC_Mois = :1 AND FAC_Annee = :1 AND FAC_Mois_Annee # :2"; 0; "")
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Génération date et année des factures..."; True:C214)
			End if 
			
			$enregistrement_o.FAC_Mois:=Num:C11(Substring:C12($enregistrement_o.FAC_Mois_Annee; 1; Position:C15("/"; $enregistrement_o.FAC_Mois_Annee)-1))
			$enregistrement_o.FAC_Annee:=Num:C11(Substring:C12($enregistrement_o.FAC_Mois_Annee; Position:C15("/"; $enregistrement_o.FAC_Mois_Annee)+1))
			
			$statut_o:=$enregistrement_o.save()
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=6)  // Report Autre solution
		
		// Modifié par : Scanu rémy (02/05/2023)
		// Possibilité d'appliquer l'effet rétro-actif à une ou plusieurs personnes
		If (Count parameters:C259=2)
			$table_o:=$2.HB_ReferenceID_1_HG_HB_ID
		Else 
			$table_o:=ds:C1482.HeberGement.all()
		End if 
		
		$table_o:=$table_o.query("HG_Cloturée = :1 AND HG_AutreSolutio # :2"; False:C215; "")
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Report autre solution..."; True:C214)
			End if 
			
			$modif_b:=ds:C1482.HeberGement.reportMotifSortie($enregistrement_o.ID; $enregistrement_o.HG_AutreSolutio)
			
			If ($modif_b=True:C214)
				$enregistrement_o.HG_AutreSolutio:=""
				$statut_o:=$enregistrement_o.save()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
		
	: ($1=7)  // TimeStamp pour fiche hébergement
		$table_o:=ds:C1482.HeberGement.all()
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Génération du timeStamp..."; True:C214)
			End if 
			
			If ($enregistrement_o.HG_TimeStamp=0)
				$enregistrement_o.getTsModif()
				$statut_o:=$enregistrement_o.save()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=8)  // Initialisation de la situation budgetaire
		$table_o:=ds:C1482.HeBerge.all()
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Génération de la situation budgetaire..."; True:C214)
			End if 
			
			If ($enregistrement_o.situationBudgetaire=Null:C1517)
				$enregistrement_o.initSituationBudget()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=9)  // Mise en place de la date d'origine de la fiche
		
		If (Count parameters:C259=2)
			$table_o:=$2.HB_ReferenceID_1_HG_HB_ID
		Else 
			$table_o:=ds:C1482.HeberGement.all()
		End if 
		
		outilsOrdaSearchByRefStctre(->$table_o)
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Mise en place de la date d'origine dans les fiches..."; False:C215)
			End if 
			
			$enregistrement_o.HG_DateOrigine:=$enregistrement_o.HG_Date
			$statut_o:=$enregistrement_o.save()
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=10)  // Mise en place de l'état civil fusionné
		
		If (Count parameters:C259=2)
			$table_o:=$2.HB_ReferenceID_1_HG_HB_ID
		Else 
			$table_o:=ds:C1482.HeberGement.all()
		End if 
		
		outilsOrdaSearchByRefStctre(->$table_o)
		
		If ($displayProgressBar_b=True:C214)
			$lengthMax_el:=$table_o.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsProgressBar(0; "Initialisation"; True:C214)
		End if 
		
		$tableFusion_es:=ds:C1482.TableFusions.query("TF_RéférenceTable = :1 AND TF_Diviseur > :2"; "EtaCv"; 0)
		outilsOrdaSearchByRefStctre(->$tableFusion_es)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($displayProgressBar_b=True:C214)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lengthMax_el; "Mise à jour de l'état civil fusionné..."; False:C215)
				End if 
				
			End if 
			
			
			If ($tableFusionB_es.length=1)
				$enregistrement_o.HG_EtatCivilFusion:=$tableFusionB_es[0].TF_Libellé
				$statut_o:=$enregistrement_o.save()
			End if 
			
			If ($displayProgressBar_b=True:C214)
				$i_el:=$i_el+1
			End if 
			
		End for each 
		
		If ($displayProgressBar_b=True:C214)
			outilsProgressBar(1; "arrêt")
		End if 
		
	: ($1=11)  // [HeBerge]HB_Clé date de naissance sous 4 chiffres pour tout le monde
		$table_o:=ds:C1482.HeBerge.all()
		outilsOrdaSearchByRefStctre(->$table_o)
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Reformatage du champ [HeBerge]HB_Clé..."; True:C214)
			End if 
			
			$nom_t:=$enregistrement_o.HB_Nom
			$prenom_t:=$enregistrement_o.HB_Prénom
			$dateNeLe_d:=$enregistrement_o.HB_DateNéLe
			
			$enregistrement_o.HB_Clé:=Uut_HébergéClé(->$nom_t; ->$prenom_t; ->$dateNeLe_d)
			$statut_o:=$enregistrement_o.save()
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=12)  // Génération propriété importApplicationMobile dans toutes les notes
		$note_es:=ds:C1482.Note.query("Ref_Structure = :1"; <>ref_soc_active)
		
		$lengthMax_el:=$note_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($note_e; $note_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Création de la propriété \"importApplicationMobile\"..."; False:C215)
			End if 
			
			$note_c:=$note_e.detail.note
			
			For each ($note_o; $note_c)
				
				If ($note_o.importApplicationMobile=Null:C1517)
					$note_o.importApplicationMobile:=False:C215
				End if 
				
			End for each 
			
			$statut_o:=$note_e.save()
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=13)  // Transfert gestion groupe 4D vers champ [Structure_User]groupe
		GET GROUP LIST:C610($privilege_at; $privilegeID_ai)
		SORT ARRAY:C229($privilege_at; >)
		
		$privilege_es:=ds:C1482.Privilege.all()
		$privilegeNotDrop_es:=$privilege_es.drop()
		
		// Génération de tous les privilèges
		For ($j_el; 1; Size of array:C274($privilege_at))
			$privilege_e:=ds:C1482.Privilege.searchAndCreateRecordIfDontExist($privilege_at{$j_el})
		End for 
		
		$intervenant_es:=ds:C1482.INtervenants.query("Ref_Structure = :1"; <>ref_soc_active)
		
		$lengthMax_el:=$intervenant_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($intervenant_e; $intervenant_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Externalisation dans une table de la gestion des privilèges pour les intervenants..."; False:C215)
			End if 
			
			If ($intervenant_e.IN_RéfUser>0)
				Web_User_Get_privileges($intervenant_e.ID)
				SORT ARRAY:C229(<>tb_profils_user_groupes; >)
				
				For ($j_el; 1; Size of array:C274(<>tb_profils_user_groupes))
					
					If (<>tb_profils_user_groupes{$j_el}#"???")
						$privilege_e:=ds:C1482.Privilege.searchAndCreateRecordIfDontExist(<>tb_profils_user_groupes{$j_el})
						$intervenantPrivilege_e:=ds:C1482.IntervenantsPrivilege.searchAndCreateRecordIfDontExist($intervenant_e.ID; $privilege_e.UUID)
					End if 
					
				End for 
				
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=14)  // Correction champ [Structure_User]Ref_Structure
		$structureUser_es:=ds:C1482.Structure_User.all()
		
		$lengthMax_el:=$structureUser_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($structureUser_e; $structureUser_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Correction champ [Structure_User]Ref_Structure..."; False:C215)
			End if 
			
			outilsOrdaSearchSimple(->[Structures:79]; ->[Structures:79]UID:1; $structureUser_e.UID_Structure; ->$structure_e; "first")
			
			If ($structure_e#Null:C1517)
				$structureUser_e.Ref_Structure:=$structure_e.Ref_Structure
				$statut_o:=$structureUser_e.save()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=15)  // Dé-doublonnage table [Adresses]
		$table_o:=ds:C1482.HeBerge.all()
		outilsOrdaSearchByRefStctre(->$table_o)
		
		$lengthMax_el:=$table_o.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until (progressBar_el=0)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Dé-doublonnage de la table [Adresses]..."; True:C214)
			End if 
			
			$adresse_es:=ds:C1482.Adresses.query("AD_ID_Origine = :1 AND AD_ID_Table_Origine = :2 AND Ref_Structure = :3"; $enregistrement_o.ID; Table:C252(->[HeBerge:4]); $enregistrement_o.Ref_Structure)
			
			If ($adresse_es.length>1)
				$adresse_es:=$adresse_es.query("ID # :1"; $adresse_es.first().ID)
				$adresse_es.drop()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=16)  // Transfert mot de passe 4D vers champ [INtervenants]IN_HashPassword
		GET USER LIST:C609($utilisateur_at; $utilisateur_ai)
		$intervenant_es:=ds:C1482.INtervenants.query("Ref_Structure = :1"; <>ref_soc_active)
		
		$lengthMax_el:=$intervenant_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($intervenant_e; $intervenant_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Externalisation dans une table de la gestion des mots de passe pour les intervenants..."; False:C215)
			End if 
			
			$position_el:=Find in array:C230($utilisateur_ai; $intervenant_e.IN_RéfUser)
			
			If ($position_el#-1)  // Utilisateur bien présent dans la base de données 4D
				GET USER PROPERTIES:C611($intervenant_e.IN_RéfUser; $login_t; $methodeDemarrage_t; $motDePasse_t; $nbUtilisation_el; $derniereUtilisation_d; $userGroupe_ai)
				$position_el:=Set user properties:C612($intervenant_e.IN_RéfUser; $login_t; $methodeDemarrage_t; ""; 0; Current date:C33; $userGroupe_ai)  // Reset du mot de passe 4D
				
				// Passage du mot de passe 4D au mot de passe hash sur la table [INtervenants]
				$intervenant_e.IN_HashPassword:=Generate password hash:C1533($motDePasse_t)
				$statut_o:=$intervenant_e.save()
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=17)  // Affectaction [Factures]FAC_Categorie = "location" à toutes les factures de location
		$facture_es:=ds:C1482.Factures.query("FAC_Type_Piece = :1 OR FAC_Type_Piece = :2"; "location"; "mixte")
		
		$lengthMax_el:=$facture_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($facture_e; $facture_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Affectation catégorie \"location\" au facture de location en cours..."; False:C215)
			End if 
			
			$facture_e.FAC_Categorie:="Location"
			$statut_o:=$facture_e.save()
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=18)  // Transfert champ [HeBerge]situationBudgetaire en table [ParticipationsWebBudget] et [ParticipationsWebDette]
		$heberge_es:=ds:C1482.HeBerge.all()
		
		$lengthMax_el:=$heberge_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($heberge_e; $heberge_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Externalisation vers table [ParticipationsWebBudget] et [ParticipationsWebDette] du champ [HeBerge]situationBudgetaire..."; False:C215)
			End if 
			
			If ($heberge_e.situationBudgetaire#Null:C1517)
				$participationWebBudget_e:=ds:C1482.ParticipationsWebBudget.searchAndCreateRecordIfDontExist($heberge_e.ID; 2024; 1; $heberge_e.situationBudgetaire.budget.salaire; $heberge_e.situationBudgetaire.budget.loyer; $heberge_e.situationBudgetaire.budget.apl; $heberge_e.situationBudgetaire.budget.ressource; $heberge_e.situationBudgetaire.budget.charge; $heberge_e.situationBudgetaire.commentaire; $heberge_e.situationBudgetaire.nbPersonneMenage; $heberge_e.Ref_Structure)
				$participationWebDette_e:=ds:C1482.ParticipationsWebDette.searchAndCreateRecordIfDontExist($heberge_e.ID; $heberge_e.situationBudgetaire.dateSitBudget; $heberge_e.situationBudgetaire.commentaire; $heberge_e.situationBudgetaire.dette.detail; $heberge_e.situationBudgetaire.nbPersonneMenage; $heberge_e.Ref_Structure)
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=19)  // Transformation champ [Messagerie]MS_User
		$messagerie_es:=ds:C1482.Messagerie.all()
		
		$lengthMax_el:=$messagerie_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($messagerie_e; $messagerie_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Transformation champ [Messagerie]MS_User..."; False:C215)
			End if 
			
			If ($messagerie_e.MS_User#-1)
				outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_RéférenceID:1; $messagerie_e.MS_User; ->$intervenant_e; "first")
				
				If ($intervenant_e#Null:C1517)
					$messagerie_e.intervenantID:=$intervenant_e.ID
					$statut_o:=$messagerie_e.save()
				End if 
				
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
	: ($1=20)  // Maintenance participation Web
		_MaintenanceParticipationWeb
	: ($1=21)  // Maintenance dette initiale
		_maintenanceDetteInitiale
		
	: ($1=22)  // Maraude3_2 -> Date de sortie
		
		$hebergement_es:=ds:C1482.HeberGement.query("HG_DateEntree = :1 AND (HG_Maraude3_2 #'' OR HG_Maraude1_2 #'')"; !00-00-00!)
		
		$hebergement_el:=$hebergement_es.length
		$moduloHebergement_el:=outilsProgressBarGetModulo($hebergement_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($hebergement_e; $hebergement_es)
			
			If ($i_el%$moduloHebergement_el=0)
				outilsProgressBar($i_el/$hebergement_el; "Transformation champ HG_Maraude3_2 et 1_2..."; False:C215)
			End if 
			
			$hebergement_e.HG_DateSortie:=Date:C102($hebergement_e.HG_Maraude3_2)
			$hebergement_e.HG_DateEntree:=Date:C102($hebergement_e.HG_Maraude1_2)
			
			$statut_o:=$hebergement_e.save()
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
		
		
		
End case 