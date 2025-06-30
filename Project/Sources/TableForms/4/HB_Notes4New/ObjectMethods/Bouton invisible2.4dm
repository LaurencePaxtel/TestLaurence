var $position_t; $typeNote_t : Text
var $noteNew_b : Boolean
var $form_o; $statut_o : Object

var $heberge_es : cs:C1710.HeBergeSelection
var $heberge_e : cs:C1710.HeBergeEntity

var $note_es : cs:C1710.NoteSelection
var $note_e : cs:C1710.NoteEntity

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$position_t:="center"
		$form_o:=New object:C1471("typeNote"; Form:C1466.typeNote.query("field # :1"; "@Archive@").orderBy("lib asc"); "date"; Current date:C33)
		
		outilsCreateWindowsForm("EditNote"; ->$position_t; $form_o; ->[Note:124])
		
		If (OK=1)  // Bouton sauvegarder et Confirmer
			$heberge_es:=Create entity selection:C1512([HeBerge:4])
			$heberge_e:=$heberge_es.first()
			
			$typeNote_t:=Form:C1466.typeNote.query("lib = :1"; typeNote_at{typeNote_at})[0].field
			$noteNew_b:=($heberge_e.AllNote.query("type = :1"; $typeNote_t).length=0)
			
			If ($noteNew_b=True:C214)
				$note_e:=ds:C1482.Note.new()
				
				$note_e.detail:=New object:C1471
				$note_e.detail.note:=New collection:C1472
				
				$note_e.Ref_Structure:=<>ref_soc_active
				$note_e.hebergeID:=[HeBerge:4]ID:65
				$note_e.type:=$typeNote_t
			Else 
				$note_es:=$heberge_e.AllNote.query("type = :1"; $typeNote_t)
				$note_e:=$note_es.first()
			End if 
			
			$note_e.detail.note.push(New object:C1471(\
				"date"; Date:C102($form_o.date); \
				"heure"; String:C10(Current time:C178); \
				"typeNote"; $typeNote_t; \
				"UUID"; Generate UUID:C1066; \
				"note"; String:C10($form_o.note); \
				"utilisateur"; Current user:C182; \
				"ts"; outilsTimeStamp(Current date:C33; Current time:C178)))
			
			$statut_o:=$note_e.save()
			POST OUTSIDE CALL:C329(Current process:C322)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 