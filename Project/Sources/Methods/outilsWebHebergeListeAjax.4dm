//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/06/23, 17:25:26
// ----------------------------------------------------
// Méthode : outilsWebHebergeListeAjax
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $note_t; $typeNote_t : Text
var $noteNew_b : Boolean
var $retour_o; $data_o; $note_o; $statut_o : Object
var $typeNote_c; $tableExport_c; $note_c; $hebergementID_c : Collection

var $heberge_e : cs:C1710.HeBergeEntity

var $note_e : cs:C1710.NoteEntity
var $notes_es : cs:C1710.NoteSelection

var $hebergement_es; $hebergementNotDrop_es : cs:C1710.HeberGementSelection

ARRAY TEXT:C222($hebergementID_at; 0)

$retour_o:=New object:C1471

$typeNote_c:=New collection:C1472

$note_c:=New collection:C1472
$tableExport_c:=New collection:C1472

$hebergementID_c:=New collection:C1472


outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; Num:C11(w_visiteur.hebergeID); ->$heberge_e; "first")
outilsManageNoteWeb(99; ->$typeNote_c; Session:C1714.storage.intervenant.Ref_Structure; Session:C1714.storage.intervenant.Login)

$notes_es:=$heberge_e.AllNote.query("type in :1"; $typeNote_c.extract("field"))
$notes_es.refresh()

Case of 
	: (w_visiteur.action="chargeTypeNote")
		$retour_o.data:=$typeNote_c.extract("lib"; "value"; "lib"; "lib").map("outilsCollectionValueToString"; "value")
	: (w_visiteur.action="chargeNote")
		
		If ($notes_es.length>0)
			$data_o:=New object:C1471(\
				"dateDu"; Date:C102(w_visiteur.dateDu); \
				"dateAu"; Date:C102(w_visiteur.dateAu); \
				"typeNote"; String:C10(w_visiteur.typeNote); \
				"keyword"; String:C10(w_visiteur.keyword))
			outilsManageNoteWeb(4; $notes_es; $typeNote_c; ->$note_c; $data_o; w_userUID; Session:C1714.storage.intervenant.Ref_Structure)
			
			For each ($note_o; $note_c)
				$note_t:=$note_o.note
				$note_t:=Replace string:C233($note_o.note; Char:C90(Retour à la ligne:K15:40); "<br/>")
				
				outilsWebPushTableExptListeAjax(->$tableExport_c; \
					String:C10($note_c.indexOf($note_o)+1); \
					$note_o.typeNote; \
					String:C10($note_o.date); \
					$note_t; \
					String:C10($note_o.utilisateur); \
					String:C10($note_o.UUID); \
					$note_o.heure; \
					String:C10(Bool:C1537($note_o.edit)))
			End for each 
			
		End if 
		
		$retour_o.data:=$tableExport_c
	: (w_visiteur.action="createNote")
		$typeNote_t:=$typeNote_c.query("lib = :1"; String:C10(w_visiteur.typeNoteEdit))[0].field
		$noteNew_b:=($heberge_e.AllNote.query("type = :1"; $typeNote_t).length=0)
		
		If ($noteNew_b=True:C214)
			$note_e:=ds:C1482.Note.new()
			
			$note_e.detail:=New object:C1471
			$note_e.detail.note:=New collection:C1472
			
			$note_e.Ref_Structure:=Session:C1714.storage.intervenant.Ref_Structure
			$note_e.hebergeID:=$heberge_e.ID
			$note_e.type:=$typeNote_t
			
			$statut_o:=$note_e.save()
		Else 
			$note_es:=$heberge_e.AllNote.query("type = :1"; $typeNote_t)
			$note_e:=$note_es.first()
		End if 
		
		$note_e.reload()
		
		$note_e.detail.note.push(New object:C1471(\
			"date"; Date:C102(outilsDateIsoVersDateFr(w_visiteur.dateNoteEdit)); \
			"heure"; String:C10(Current time:C178); \
			"typeNote"; $typeNote_t; \
			"UUID"; Generate UUID:C1066; \
			"note"; String:C10(w_visiteur.contenuNoteEdit); \
			"utilisateur"; String:C10(Session:C1714.storage.intervenant.Login); \
			"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
		
		$statut_o:=$note_e.save()
	: (w_visiteur.action="editNote")
		$typeNote_t:=$typeNote_c.query("lib = :1"; String:C10(w_visiteur.typeNoteEdit))[0].field
		
		$note_es:=$heberge_e.AllNote.query("type = :1"; $typeNote_t)
		$note_e:=$note_es.first()
		
		$note_c:=$note_e.detail.note.query("UUID = :1"; String:C10(w_visiteur.noteEditUUID))
		
		If ($note_c.length=1)
			$note_o:=$note_c[0]
			
			$note_o.date:=Date:C102(outilsDateIsoVersDateFr(w_visiteur.dateNoteEdit))
			$note_o.heure:=String:C10(Current time:C178)
			$note_o.note:=String:C10(w_visiteur.contenuNoteEdit)
			$note_o.ts:=outilsTimeStamp(Current date:C33; Current time:C178)
		End if 
		
		$statut_o:=$note_e.save()
	: (w_visiteur.action="dropNote")
		$typeNote_t:=$typeNote_c.query("lib = :1"; String:C10(w_visiteur.typeNoteEdit))[0].field
		
		$note_es:=$heberge_e.AllNote.query("type = :1"; $typeNote_t)
		$note_e:=$note_es.first()
		
		$note_c:=$note_e.detail.note.indices("UUID = :1"; String:C10(w_visiteur.noteEditUUID))
		
		If ($note_c.length=1)
			$note_e.detail.note.remove($note_c[0])
		End if 
		
		$statut_o:=$note_e.save()
	: (w_visiteur.action="deleteHebergement")
		JSON PARSE ARRAY:C1219(w_visiteur.hebergementIDS; $hebergementID_at)
		
		ARRAY TO COLLECTION:C1563($hebergementID_c; $hebergementID_at)
		$hebergement_es:=ds:C1482.HeberGement.query("ID in :1"; $hebergementID_c)
		
		Case of 
			: ($hebergementID_c.length#$hebergement_es.length)
				$retour_o.notificationError:="Toutes les fiches sélectionnées n'ont pas pu être trouvées dans la base de données"
			: ($hebergement_es.length>0)
				$hebergementNotDrop_es:=$hebergement_es.drop()
				
				If ($hebergementNotDrop_es.length>0)
					$retour_o.notificationError:=String:C10($hebergementNotDrop_es)+" fiche(s) n'a(ont) pas pu être supprimée(s) de la base de données"
				End if 
				
			Else 
				$retour_o.notificationError:="Aucune fiche n'a été trouvée dans la base de données"
		End case 
		
End case 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))