//%attributes = {"preemptive":"capable"}
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

var $note_t; $propriete_t : Text
var $i_el; $lengthMax_el; $moduloProgress_el; $i_el : Integer
var $noteEdit_b; $noteEditB_b : Boolean
var $statut_o; $note_o : Object
var $note_c; $noteOld_c : Collection

var $heberge_e : cs:C1710.HeBergeEntity

var $note_e : cs:C1710.NoteEntity
var $note_es : cs:C1710.NoteSelection

var $societe_e : cs:C1710.SOcieteEntity

var $intervenant_e : cs:C1710.INtervenantsEntity



Case of 
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
				// mise en commentaire le 11/10/24 par GF pour l'utilisation du preemptif et  session storage  sur le web.
				//outilsProgressBar(0; "Initialisation"; Vrai)
			End if 
			
			For each ($note_e; $2)
				
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
		
		
	: ($1=13)  // Traitement d'une ligne (application mobile / structure)
		$heberge_e:=ds:C1482.HeBerge.searchAndCreateRecordIfDontExist($2[6]; $2[7]; $2[8]; Session:C1714.storage.intervenant.Ref_Structure)
		$note_es:=$heberge_e.AllNote.query("type = :1"; $3)
		
		If ($note_es.length=0)
			$note_e:=ds:C1482.Note.new()
			
			$note_e.detail:=New object:C1471
			$note_e.detail.note:=New collection:C1472
			
			$note_e.Ref_Structure:=Session:C1714.storage.intervenant.Ref_Structure
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
										
										//Si (Appartient au groupe($4; "NotesNote"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "NotesNote").length=1)
											
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_6))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_6))
								End case 
								
							: ($propriete_t="HB_Notes2")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "NotesNote"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "NotesNote").length=1)
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_3))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_3))
								End case 
								
							: ($propriete_t="HB_Notes3")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "NotesNote"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "NotesNote").length=1)
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_7))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_Ongletnote_7))
								End case 
								
							: ($propriete_t="HB_notes4")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "NotesNote"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "NotesNote").length=1)
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_4))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_4))
								End case 
								
							: ($propriete_t="HB_NotesTrans")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "NotesNote"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "NotesNote").length=1)
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_5))
										End if 
										
									: (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_5))
								End case 
								
							: ($propriete_t="HB_Maraude")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "MARAUDE"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "MARAUDE").length=1)
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_8))
										End if 
										
									: (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_8))
								End case 
								
							: ($propriete_t="HB_Maraude2")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "MARAUDE"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "MARAUDE").length=1)
											$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_9))
										End if 
										
									: (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214)
										$2->push(New object:C1471("field"; $propriete_t; "lib"; $societe_e.SO_OngletNote_9))
								End case 
								
							: ($propriete_t="HB_Note_FVV")
								
								Case of 
									: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
										
										//Si (Appartient au groupe($4; "Notes FVV"))
										If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "Notes FVV").length=1)
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
								
								//Si (Appartient au groupe($4; "MARAUDE"))
								If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "MARAUDE").length=1)
									$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
								End if 
								
							: (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214)
								$2->push(New object:C1471("field"; $propriete_t; "lib"; $propriete_t))
						End case 
						
					: ($propriete_t="HB_Note_FVV")
						
						Case of 
							: (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
								
								//Si (Appartient au groupe($4; "Notes FVV"))
								If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "Notes FVV").length=1)
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