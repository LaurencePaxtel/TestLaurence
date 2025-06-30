//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy - remy@connectt-io.fr
// Date et heure : 11/07/22, 16:44:18
// ----------------------------------------------------
// Méthode : outilsManageNote
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Variant
var $3 : Variant
var $4 : Variant
var $5 : Variant
var $6 : Variant
var $7 : Variant

var $name_t; $content_t; $line_t; $datePotentiel_t; $datePotentielB_t; $heurePotentiel_t; $note_t; $nom_t; $prenom_t; $error_t; $separateur_t; $propriete_t : Text
var $i_el; $j_el; $depart_el; $offset_el; $lengthMax_el; $moduloProgress_el; $i_el : Integer
var $separateur_b; $stop_b; $forcePassage_b; $noteEdit_b; $noteEditB_b : Boolean
var $dateNaissance_d : Date
var $content_b : Blob
var $content_o; $statut_o; $configuration_o; $note_o : Object
var $note_c; $collection_c; $lines_c; $columns_c; $autreCollection_c; $noteOld_c : Collection
var $file_f : 4D:C1709.File

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

var $note_e : cs:C1710.NoteEntity
var $note_es : cs:C1710.NoteSelection

var $societe_e : cs:C1710.SOcieteEntity

var $intervenant_e : cs:C1710.INtervenantsEntity

var $form_cs : cs:C1710.FormManage


Case of 
	: ($1=1)  // Import note d'un fichier excel (archive)
		$name_t:=Select document:C905(""; ".xlsx;.xls;.csv"; "Sélection d'un fichier excel"; 0)
		
		If ($name_t#"")
			$file_f:=File:C1566(Document; fk chemin plateforme:K87:2)
/*$content_b:=$file_f.getContent()
			
$content_t:=BLOB vers texte($content_b; UTF8 chaîne en C)*/
			
			Case of 
				: ($file_f.extension=".xlsx")  // Traitement d'un fichier .xlsx
					$content_t:=XLSX TO JSON(Document; XLSXIOREAD_SKIP_EMPTY_ROWS; $error_t)
					$content_o:=JSON Parse:C1218($content_t)
					
					$position_t:="center"
					outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $content_o.sheets.extract("name"; "name"); \
						"property"; "name"; "selectSubTitle"; "Merci de sélectionner le classeur"; "title"; "Choix du classeur :"))
					
					If (selectValue_t#"")
						$classeur_c:=$content_o.sheets.query("name = :1"; selectValue_t)  // Sélection du classeur à importer
						
						If ($classeur_c.length=1)
							outilsProgressBar(0; "Initialisation"; True:C214)
							
							For each ($line_o; $classeur_c[0].rows) Until (progressBar_el=0)
								
								If (($classeur_c[0].rows.indexOf($line_o)%100)=0)
									outilsProgressBar($classeur_c[0].rows.indexOf($line_o)/$classeur_c[0].rows.length; "Importation du fichier "+$name_t+" en cours "+"("+String:C10($classeur_c[0].rows.indexOf($line_o))+"/"+String:C10($classeur_c[0].rows.length)+")..."; True:C214)
								End if 
								
								If ($line_o.values.length>0)  // Il y a des colonnes de renseigner pour cette ligne
									
									If ($line_o.values[3]#"@Column@")
										outilsManageNote(10; True:C214; $line_o.values[0]; $line_o.values[1]; $line_o.values[2]; $line_o.values[3]; $line_o.values[4])
									End if 
									
								End if 
								
							End for each 
							
							outilsProgressBar(1; "arrêt")
						End if 
						
					End if 
					
				: ($file_f.extension=".csv")  // Traitement d'un fichier .csv: ($file_f.extension=".csv")  // Traitement d'un fichier .csv
					$content_b:=$file_f.getContent()
					$content_t:=BLOB to text:C555($content_b; UTF8 chaîne en C:K22:15; $offset_el)
					
					If ($content_t="")
						CLEAR VARIABLE:C89($offset_el)
						$content_t:=BLOB to text:C555($content_b; Mac chaîne en C:K22:7; $offset_el)
					End if 
					
					If ($content_t#"")
						$lines_c:=Split string:C1554($content_t; Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40))
						
						$position_t:="center"
						outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("separateur"; "Tabulation"); New object:C1471("separateur"; "Point-virgule")); \
							"property"; "separateur"; "selectSubTitle"; "Merci de sélectionner le séparateur"; "title"; "Choix du séparateur :"))
						
						Case of 
							: (selectValue_t="Tabulation")
								$separateur_t:=Char:C90(Tabulation:K15:37)
							: (selectValue_t="Point-virgule")
								$separateur_t:=";"
						End case 
						
						outilsProgressBar(0; "Initialisation"; True:C214)
						
						For each ($line_t; $lines_c) Until (progressBar_el=0)
							
							If (($lines_c.indexOf($line_t)%10)=0)
								outilsProgressBar($lines_c.indexOf($line_t)/$lines_c.length; "Importation du fichier "+$name_t+" en cours "+"("+String:C10($lines_c.indexOf($line_t))+"/"+String:C10($lines_c.length)+")..."; True:C214)
							End if 
							
							$columns_c:=Split string:C1554($line_t; $separateur_t)
							
							If ($columns_c.length=5)
								
								If ($columns_c[3]#"@Column@")
									outilsManageNote(10; $2; $columns_c[0]; $columns_c[1]; $columns_c[2]; $columns_c[3]; $columns_c[4])
								End if 
								
							End if 
							
							outilsCleanVariable(->$columns_c)
						End for each 
						
						outilsProgressBar(1; "arrêt")
					Else 
						ALERT:C41("Impossible d'extraire le contenu du fichier "+$file_f.fullName)
					End if 
					
			End case 
			
		End if 
		
	: ($1=2)  // Extraction de toutes les notes d'un texte
		
		For ($i_el; 1; Length:C16($2))
			$datePotentiel_t:=Substring:C12($2; $i_el; 10)  // La date est sous ce format JJ/MM/AAAA
			$datePotentielB_t:=Substring:C12($2; $i_el; 8)  // La date est sous ce format JJ/MM/AA
			
			While (Date:C102($datePotentiel_t)=!00-00-00!) & ($stop_b=False:C215)
				$i_el:=$i_el+1
				$stop_b:=($i_el>Length:C16($2))
				
				$datePotentiel_t:=Substring:C12($2; $i_el; 10)  // La date est sous ce format JJ/MM/AAAA
				$datePotentielB_t:=Substring:C12($2; $i_el; 8)  // La date est sous ce format JJ/MM/AA
			End while 
			
			If ((Date:C102($datePotentiel_t)#!00-00-00!) | (Date:C102($datePotentielB_t)#!00-00-00!)) & ($stop_b=False:C215)
				
				If (Date:C102($datePotentielB_t)#!00-00-00!) & (outilsCheckCharacterIsNumber(Substring:C12($datePotentiel_t; 9; 1))=False:C215) & (outilsCheckCharacterIsNumber(Substring:C12($datePotentiel_t; 10; 1))=False:C215)
					$datePotentiel_t:=$datePotentielB_t
				End if 
				
				$heurePotentiel_t:=Substring:C12($2; $i_el+Length:C16($datePotentiel_t)+3; 8)
				
				If ($4->query("date = :1 AND heure = :2"; Date:C102($datePotentiel_t); $heurePotentiel_t).length>0)  // Pas normal de se retrouver dans ce cas
					$i_el:=Length:C16($2)+1
				Else 
					$4->push(New object:C1471(\
						"date"; Date:C102($datePotentiel_t); \
						"heure"; Choose:C955(Time:C179($heurePotentiel_t)#?00:00:00?; $heurePotentiel_t; "23:59:59"); \
						"typeNote"; $3; \
						"UUID"; Generate UUID:C1066; \
						"ts"; outilsTimeStamp(Date:C102($datePotentiel_t); Time:C179($heurePotentiel_t))))
					
					$depart_el:=$i_el+Length:C16($datePotentiel_t)+3+Choose:C955(Time:C179($heurePotentiel_t)#?00:00:00?; Length:C16($heurePotentiel_t); 0)
					$separateur_b:=(Substring:C12($2; $depart_el; 3)=" - ")
					
					If ($separateur_b=True:C214)  // S'il y a la précense d'un séparateur " - ", juste après l'heure, on ne la prend pas en compte
						$depart_el:=$depart_el+3
					End if 
					
					For ($j_el; $depart_el; Length:C16($2))
						$datePotentiel_t:=Substring:C12($2; $j_el; 10)  // La date est sous ce format JJ/MM/AAAA
						$datePotentielB_t:=Substring:C12($2; $j_el; 8)  // La date est sous ce format JJ/MM/AA
						
						If (Date:C102($datePotentiel_t)#!00-00-00!) & (Date:C102($datePotentielB_t)#!00-00-00!) & (outilsCheckCharacterIsNumber(Char:C90(Character code:C91($2[[$j_el]])))=True:C214)
							$forcePassage_b:=(Position:C15(" "; $datePotentiel_t)>0)
							
							If ($forcePassage_b=False:C215)
								$collection_c:=Split string:C1554($datePotentiel_t; "/")
								$forcePassage_b:=($collection_c.length<=2)
								
								If ($forcePassage_b=False:C215)
									$forcePassage_b:=($collection_c.indexOf("")>=0)
								End if 
								
							End if 
							
						End if 
						
						If (Date:C102($datePotentiel_t)#!00-00-00!) & (Date:C102($datePotentielB_t)#!00-00-00!) & ($forcePassage_b=False:C215) & (Position:C15(" "; $datePotentiel_t)<=0) & (Position:C15("-"; Substring:C12($2; $j_el+10; 10))<=0)  // Si la date qu'on détecte est inclus dans la note et que ce n'est pas le début d'une nouvelle note, on force le passage et on la prend en compte dans la note actuelle
							$forcePassage_b:=(Substring:C12($2; $j_el-4; 10)#"@.@")
						End if 
						
						Case of 
							: (Date:C102($datePotentiel_t)=!00-00-00!) | (Date:C102($datePotentielB_t)=!00-00-00!) | ($forcePassage_b=True:C214)  // Aucune date de détecter
								$note_t:=$note_t+Char:C90(Character code:C91($2[[$j_el]]))
								
								If ($j_el=Length:C16($2))
									$i_el:=Length:C16($2)+1
									
									If (Substring:C12($note_t; Length:C16($note_t))=" ")  // Si la note se termine par un espace, on le supprime
										$note_t:=Substring:C12($note_t; 1; Length:C16($note_t)-1)
									End if 
									
									$4->[$4->length-1].note:=$note_t
								End if 
								
							: (outilsCheckCharacterIsNumber(Char:C90(Character code:C91($2[[$j_el]])))=False:C215)  // La phrase se termine par un caractère
								$note_t:=$note_t+Char:C90(Character code:C91($2[[$j_el]]))
							Else 
								
								If (Substring:C12($note_t; Length:C16($note_t))=" ")  // Si la note se termine par un espace, on le supprime
									$note_t:=Substring:C12($note_t; 1; Length:C16($note_t)-1)
								End if 
								
								$4->[$4->length-1].note:=$note_t
								
								$i_el:=$j_el-1  // Je recommence le prochain passage à la position où la note se finie - 1 car on va avancer d'un pas juste après et se retrouver à cette position
								$j_el:=Length:C16($2)+1  // On sort de la boucle
						End case 
						
					End for 
					
				End if 
				
				outilsCleanVariable(->$note_t; ->$collection_c; ->$forcePassage_b)
			End if 
			
			CLEAR VARIABLE:C89($stop_b)
		End for 
		
	: ($1=3)  // Import d'un fichier excel (application mobile / structure)
		$name_t:=Select document:C905(""; ".xlsx;.xls;.csv"; "Sélection d'un fichier excel"; 0)
		
		If ($name_t#"")
			$file_f:=File:C1566(Document; fk chemin plateforme:K87:2)
			
			Case of 
				: ($file_f.extension=".csv")  // Traitement d'un fichier .csv: ($file_f.extension=".csv")  // Traitement d'un fichier .csv
					$content_b:=$file_f.getContent()
					$content_t:=BLOB to text:C555($content_b; UTF8 chaîne en C:K22:15; $offset_el)
					
					If ($content_t="")
						CLEAR VARIABLE:C89($offset_el)
						$content_t:=BLOB to text:C555($content_b; Mac chaîne en C:K22:7; $offset_el)
					End if 
					
					If ($content_t#"")
						$lines_c:=Split string:C1554($content_t; Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40))
						
						$position_t:="center"
						outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("separateur"; "Tabulation"); New object:C1471("separateur"; "Point-virgule")); \
							"property"; "separateur"; "selectSubTitle"; "Merci de sélectionner le séparateur"; "title"; "Choix du séparateur :"))
						
						Case of 
							: (selectValue_t="Tabulation")
								$separateur_t:=Char:C90(Tabulation:K15:37)
							: (selectValue_t="Point-virgule")
								$separateur_t:=";"
						End case 
						
						If ($separateur_t#"")
							// Extraction de tous les ID "ID type de Note" différent du fichier csv
							$autreCollection_c:=New collection:C1472
							outilsProgressBar(0; "Initialisation"; True:C214)
							
							For each ($line_t; $lines_c) Until (progressBar_el=0)
								
								If ($i_el%$moduloProgress_el=0)
									outilsProgressBar($lines_c.indexOf($line_t)/$lines_c.length; "Extraction des différents type de note en cours "+"("+String:C10($lines_c.indexOf($line_t))+"/"+String:C10($lines_c.length)+")..."; True:C214)
								End if 
								
								$columns_c:=Split string:C1554($line_t; $separateur_t)
								
								If ($columns_c.length=14)
									
									If (outilsCheckStringIsNumber($columns_c[2])=True:C214)
										$autreCollection_c.push($columns_c[2])
									End if 
									
								End if 
								
								$i_el:=$i_el+1
								outilsCleanVariable(->$columns_c)
							End for each 
							
							outilsProgressBar(1; "arrêt")
							$autreCollection_c:=$autreCollection_c.distinct()
							
							// Matching entre les ID extraits et les types de note de la structure connectée
							$form_cs:=cs:C1710.FormManage.new()
							$configuration_o:=$form_cs.matchElementWithColumn($2.extract("lib"); $autreCollection_c)
							
							// Intégration des données du fichier csv avec les données du matching
							$lengthMax_el:=$lines_c.length
							$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
							
							CLEAR VARIABLE:C89($i_el)
							outilsProgressBar(0; "Initialisation"; True:C214)
							
							For each ($line_t; $lines_c) Until (progressBar_el=0)
								
								If ($i_el%$moduloProgress_el=0)
									outilsProgressBar($lines_c.indexOf($line_t)/$lines_c.length; "Importation du fichier "+$name_t+" en cours "+"("+String:C10($lines_c.indexOf($line_t))+"/"+String:C10($lines_c.length)+")..."; True:C214)
								End if 
								
								If ($i_el>0)  // Si ce n'est pas la ligne des entêtes
									$columns_c:=Split string:C1554($line_t; $separateur_t)
									
									If ($columns_c.length=14)
										
										For each ($matchElement_o; $configuration_o.data)
											
											For each ($property_t; $matchElement_o)
												
												If (Bool:C1537($matchElement_o[$property_t])=True:C214) & (Value type:C1509($matchElement_o[$property_t])=Est un booléen:K8:9)
													
													If ($columns_c[2]=$matchElement_o.field)
														$collection_c:=$2.query("lib = :1"; $matchElement_o[$property_t+"PropertyOrigin"])
														
														If ($collection_c.length=1)
															outilsManageNote(13; $columns_c; $collection_c[0].field)
														End if 
														
													End if 
													
												End if 
												
											End for each 
											
										End for each 
										
									End if 
									
								End if 
								
								$i_el:=$i_el+1
								outilsCleanVariable(->$columns_c)
							End for each 
							
							outilsProgressBar(1; "arrêt")
						End if 
						
					End if 
					
			End case 
			
		End if 
		
	: ($1=4)  // Recherche des notes (4D et web)
		$noteOld_c:=New collection:C1472
		
		If ($6=-9999)  // Apaxtel
			$noteEdit_b:=True:C214
		Else 
			outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]ID:16; $6; ->$intervenant_e; "first")
			
			// Modifié par : Scanu Rémy (26/08/2024)
			If ((outilsManagePrivilege(1; "NotesNote"; $intervenant_e.ID)=True:C214) & (outilsManagePrivilege(1; "Notes modife"; $intervenant_e.ID)=True:C214)) | \
				((outilsManagePrivilege(1; "Notes FVV"; $intervenant_e.ID)=True:C214) & (outilsManagePrivilege(1; "Notes FVV modife"; $intervenant_e.ID)=True:C214)) | \
				((outilsManagePrivilege(1; "MARAUDE"; $intervenant_e.ID)=True:C214) & (outilsManagePrivilege(1; "Notes MAR modife"; $intervenant_e.ID)=True:C214)) | \
				((outilsManagePrivilege(1; "NotesSP"; $intervenant_e.ID)=True:C214) & (outilsManagePrivilege(1; "Notes SP modife"; $intervenant_e.ID)=True:C214))
				$noteEdit_b:=True:C214
			End if 
			
		End if 
		
		outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]SO_Site:8; $7; ->$societe_e; "first")
		$noteEditB_b:=$noteEdit_b
		
		If ($2.length>0)  // On indique le type de note et si la note est modifiable
			
			If (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
				$lengthMax_el:=$2.length
				$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
				
				outilsProgressBar(0; "Initialisation"; True:C214)
			End if 
			
			For each ($note_e; $2)
				
				If (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
					
					If ($i_el%$moduloProgress_el=0)
						outilsProgressBar($i_el/$lengthMax_el; "Extraction des notes en cours..."; False:C215)
					End if 
					
				End if 
				
				For each ($note_o; $note_e.detail.note)
					$note_o.typeNote:=$3.query("field = :1"; $note_e.type)[0].lib
					
					// Modifié par : Scanu Rémy (26/08/2024)
					Case of 
						: ($noteEdit_b=False:C215)  // Si l'utilisateur n'a pas de privilège de modification, il doit quand même pouvoir modifier ses propres notes
							$noteEditB_b:=(String:C10($note_o.utilisateur)=String:C10($intervenant_e.IN_Login))
						: ($noteEdit_b=True:C214) && ($6#-9999)  // L'utilisateur peut potentiellement modifier des notes, reste à savoir s'il peut modifier celle sur laquelle on est en train de boucler
							
							If (outilsManagePrivilege(1; "Notes modife"; $intervenant_e.ID)=False:C215) & ($noteEditB_b=True:C214)  // L'utilisateur n'a pas le privilège de modifier les notes général
								
								If ($note_o.typeNote=$societe_e.SO_OngletNote_6) | ($note_o.typeNote=$societe_e.SO_OngletNote_3) | \
									($note_o.typeNote=$societe_e.SO_OngletNote_7) | ($note_o.typeNote=$societe_e.SO_OngletNote_4) | \
									($note_o.typeNote=$societe_e.SO_OngletNote_5)
									CLEAR VARIABLE:C89($noteEditB_b)
								End if 
								
							End if 
							
							If (outilsManagePrivilege(1; "Notes MAR modife"; $intervenant_e.ID)=False:C215) & ($noteEditB_b=True:C214)  // L'utilisateur n'a pas le privilège de modifier les notes MARAUDE
								
								If ($note_o.typeNote=$societe_e.SO_OngletNote_8) | ($note_o.typeNote=$societe_e.SO_OngletNote_9)
									CLEAR VARIABLE:C89($noteEditB_b)
								End if 
								
							End if 
							
							If (outilsManagePrivilege(1; "Notes FVV modife"; $intervenant_e.ID)=False:C215) & ($noteEditB_b=True:C214)  // L'utilisateur n'a pas le privilège de modifier les notes FVV
								
								If ($note_o.typeNote=$societe_e.SO_OngletNote_10)
									CLEAR VARIABLE:C89($noteEditB_b)
								End if 
								
							End if 
							
							If (outilsManagePrivilege(1; "Notes SP modife"; $intervenant_e.ID)=False:C215) & ($noteEditB_b=True:C214)  // L'utilisateur n'a pas le privilège de modifier les notes FVV
								
								If ($note_o.typeNote=$heberge_e.HB_CasLib1) | ($note_o.typeNote=$heberge_e.HB_CasLib2) | ($note_o.typeNote=$heberge_e.HB_CasLib3) | ($note_o.typeNote=$heberge_e.HB_CasLib4) | ($note_o.typeNote=$heberge_e.HB_CasLib5) | ($note_o.typeNote=$heberge_e.HB_CasLib6) | ($note_o.typeNote=$heberge_e.HB_CasLib7) | ($note_o.typeNote=$heberge_e.HB_CasLib8) | ($note_o.typeNote=$heberge_e.HB_CasLib9) | ($note_o.typeNote=$heberge_e.HB_CasLib10)
									CLEAR VARIABLE:C89($noteEditB_b)
								End if 
								
							End if 
							
					End case 
					
					$note_o.edit:=$noteEditB_b
				End for each 
				
				$i_el:=$i_el+1
				$4->:=$4->combine($note_e.detail.note)
			End for each 
			
			If (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
				outilsProgressBar(1; "arrêt")
			End if 
			
			$4->:=$4->orderBy("typeNote asc, date desc, heure desc")
		End if 
		
		If (Date:C102($5.dateDu)#!00-00-00!)
			$noteOld_c:=$4->query("date < :1"; !1900-01-01!)
			$4->:=$4->query("date >= :1"; Date:C102($5.dateDu))
			
			If ($noteOld_c.length>0)
				$4->:=$4->combine($noteOld_c)
			End if 
			
		End if 
		
		If (Date:C102($5.dateAu)#!00-00-00!)
			$4->:=$4->query("date <= :1"; Date:C102($5.dateAu))
		End if 
		
		If (String:C10($5.typeNote)#"Tous") & (String:C10($5.typeNote)#"Type de note") & (String:C10($5.typeNote)#"Sélection d'un élément") & (String:C10($5.typeNote)#"")
			$4->:=$4->query("typeNote = :1"; String:C10($5.typeNote))
		End if 
		
		If (String:C10($5.keyword)#"")
			$4->:=$4->query("note = :1"; "@"+String:C10($5.keyword)+"@")
		End if 
		
		$4->:=$4->orderBy("date desc, heure desc")
	: ($1=10)  // Traitement d'une ligne (archive)
		$heberge_es:=ds:C1482.HeBerge.query("HB_Nom = :1 AND HB_Prénom = :2"; $4; $5)
		outilsOrdaSearchByRefStctre(->$heberge_es)
		
		Case of 
			: ($heberge_es.length>1)  // Pas normal de se retrouver dans ce cas
				TRACE:C157
			: ($heberge_es.length=1)
				$heberge_e:=$heberge_es[0]
			Else   // Création de la fiche [HeBerge] 
				$heberge_e:=ds:C1482.HeBerge.new()
				
				$heberge_e.HB_ReferenceID:=Uut_Numerote(->[HeBerge:4])
				$heberge_e.HB_Nom:=$4
				$heberge_e.HB_Prénom:=$5
				
				If (Position:C15(" "; $3)>0)
					$heberge_e.HB_DateNéLe:=Date:C102(Substring:C12($3; 1; Position:C15(" "; $3)-1))
				Else 
					$heberge_e.HB_DateNéLe:=Date:C102($3)
				End if 
				
				$nom_t:=$heberge_e.HB_Nom
				$prenom_t:=$heberge_e.HB_Prénom
				$dateNaissance_d:=$heberge_e.HB_DateNéLe
				
				$heberge_e.HB_Clé:=Uut_HébergéClé(->$nom_t; ->$prenom_t; ->$dateNaissance_d)
				$heberge_e.Ref_Structure:=<>ref_soc_active
				
				$statut_o:=$heberge_e.save()
				
				If ($statut_o.success=False:C215)
					TRACE:C157
				End if 
				
		End case 
		
		If ($2=True:C214)
			
			If ($6#"")  // Note 1
				$note_es:=$heberge_e.AllNote.query("type = :1"; "NotesArchive")
				
				If ($note_es.length=0)
					$note_e:=ds:C1482.Note.new()
					
					$note_e.detail:=New object:C1471
					$note_e.detail.note:=New collection:C1472
					
					$note_e.Ref_Structure:=<>ref_soc_active
					$note_e.hebergeID:=$heberge_e.ID
					$note_e.type:="NotesArchive"
					
					$statut_o:=$note_e.save()
				Else 
					$note_e:=$note_es.first()
				End if 
				
				$note_c:=New collection:C1472
				$note_t:=$6
				
				// On nettoie la note de la mise en forme éventuelle appliquée
				$note_t:=Replace string:C233($note_t; Char:C90(Retour à la ligne:K15:40); "")
				$note_t:=Replace string:C233($note_t; Char:C90(Retour chariot:K15:38); "")
				
				While ($note_t="@  @")
					$note_t:=Replace string:C233($note_t; "  "; " ")
				End while 
				
				outilsManageNote(2; $note_t; "NotesArchive"; ->$note_c)
				
				$note_e.detail.note:=$note_e.detail.note.combine($note_c)
				$statut_o:=$note_e.save()
			End if 
			
			If ($7#"")  // Note 2
				$note_es:=$heberge_e.AllNote.query("type = :1"; "HB_Notes2Archive")
				
				If ($note_es.length=0)
					$note_e:=ds:C1482.Note.new()
					
					$note_e.detail:=New object:C1471
					$note_e.detail.note:=New collection:C1472
					
					$note_e.Ref_Structure:=<>ref_soc_active
					$note_e.hebergeID:=$heberge_e.ID
					$note_e.type:="HB_Notes2Archive"
					
					$statut_o:=$note_e.save()
				Else 
					$note_e:=$note_es.first()
				End if 
				
				If ($note_e.detail.note=Null:C1517)
					$note_e.detail.note:=New collection:C1472
				End if 
				
				$note_c:=New collection:C1472
				$note_t:=$7
				
				// On nettoie la note de la mise en forme éventuelle appliquée
				$note_t:=Replace string:C233($note_t; Char:C90(Retour à la ligne:K15:40); "")
				$note_t:=Replace string:C233($note_t; Char:C90(Retour chariot:K15:38); "")
				
				While ($note_t="@  @")
					$note_t:=Replace string:C233($note_t; "  "; " ")
				End while 
				
				outilsManageNote(2; $note_t; "HB_Notes2Archive"; ->$note_c)
				
				$note_e.detail.note:=$note_e.detail.note.combine($note_c)
				$statut_o:=$note_e.save()
			End if 
			
		Else 
			$heberge_e.NotesArchive:=$6
			$heberge_e.HB_Notes2Archive:=$7
			
			$heberge_e.save()
		End if 
		
	: ($1=13)  // Traitement d'une ligne (application mobile / structure)
		$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($2[6]; $2[7]; $2[8]; <>ref_soc_active)
		$note_es:=$heberge_e.AllNote.query("type = :1"; $3)
		
		If ($note_es.length=0)
			$note_e:=ds:C1482.Note.new()
			
			$note_e.detail:=New object:C1471
			$note_e.detail.note:=New collection:C1472
			
			$note_e.Ref_Structure:=<>ref_soc_active
			$note_e.hebergeID:=$heberge_e.ID
			$note_e.type:=$3
			
			$statut_o:=$note_e.save()
		Else 
			$note_e:=$note_es.first()
		End if 
		
		If ($note_e.detail.note=Null:C1517)
			// Modifié par : Scanu Rémy (22/06/2023)
			// Obligé de faire le .save() ici sinon le .combine() plus bas ne fonctionne pas, mystère...
			$note_e.detail.note:=New collection:C1472
			$statut_o:=$note_e.save()
		End if 
		
		$note_e.reload()
		
		$note_c:=New collection:C1472
		$note_t:=$2[11]+" - "+$2[4]
		
		// On nettoie la note de la mise en forme éventuelle appliquée
		$note_t:=Replace string:C233($note_t; Char:C90(Guillemets:K15:41); "")
		
/*
$note_t:=Remplacer chaîne($note_t; Caractère(Retour à la ligne); "")
$note_t:=Remplacer chaîne($note_t; Caractère(Retour chariot); "")
*/
		
		While ($note_t="@  @")
			$note_t:=Replace string:C233($note_t; "  "; " ")
		End while 
		
		$note_c.push(New object:C1471(\
			"date"; Date:C102($2[12]); \
			"heure"; "23:59:59"; \
			"typeNote"; $3; \
			"UUID"; Generate UUID:C1066; \
			"note"; $note_t; \
			"ts"; outilsTimeStamp(Date:C102($2[12]); Time:C179("23:59:59"))))
		
		$note_e.detail.note:=$note_e.detail.note.combine($note_c)
		$statut_o:=$note_e.save()
	: ($1=99)  // Obtenir une collection de type de note de la structure de son choix
		outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]SO_Site:8; $3; ->$societe_e; "first")
		
		For each ($propriete_t; ds:C1482.HeBerge.new().toObject())
			
			If (($propriete_t="@Note@") & ($propriete_t#"AllNote") & ($propriete_t#"HB_NoteExtract")) | ($propriete_t="@HB_Maraude") | ($propriete_t="@HB_Maraude2")
				
				Case of 
					: ($societe_e#Null:C1517)
						
						Case of 
							: ($propriete_t="Notes")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "NotesNote"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_6))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_6))
								End case 
								
							: ($propriete_t="HB_Notes2")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "NotesNote"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_3))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_3))
								End case 
								
							: ($propriete_t="HB_Notes3")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "NotesNote"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_7))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_7))
								End case 
								
							: ($propriete_t="HB_notes4")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "NotesNote"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_4))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_4))
								End case 
								
							: ($propriete_t="HB_NotesTrans")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "NotesNote"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_5))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_5))
								End case 
								
							: ($propriete_t="HB_Maraude")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "MARAUDE"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_8))
										End if 
										
									: (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_8))
								End case 
								
							: ($propriete_t="HB_Maraude2")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "MARAUDE"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_9))
										End if 
										
									: (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_9))
								End case 
								
							: ($propriete_t="HB_Note_FVV")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										If (User in group:C338($4; "Notes FVV"))
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_10))
										End if 
										
									: (outilsManagePrivilege(1; "Notes FVV"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_10))
								End case 
								
							: ($propriete_t="NotesArchive")
								$2->push(New object:C1471("field"; $propriete_t; "lib"; "Notes Santé non confidentielles"))
							: ($propriete_t="HB_Notes2Archive")
								$2->push(New object:C1471("field"; $propriete_t; "lib"; "Notes Autres non confidentielles"))
						End case 
						
					: ($propriete_t="@HB_Maraude@")
						
						Case of 
							: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
								
								If (User in group:C338($4; "MARAUDE"))
									$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
								End if 
								
							: (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214)
								$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
						End case 
						
					: ($propriete_t="HB_Note_FVV")
						
						Case of 
							: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
								
								If (User in group:C338($4; "Notes FVV"))
									$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
								End if 
								
							: (outilsManagePrivilege(1; "Notes FVV"; w_userUID)=True:C214)
								$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
						End case 
						
					Else 
						$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
				End case 
				
			End if 
			
		End for each 
		
		$2->:=$2->orderBy("lib asc")
End case 