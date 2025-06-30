Class extends DataClass

Function searchAndCreateRecordIfDontExist($hebergeID_el : Integer; $typeNote_t : Text; $refStructure_t : Text)->$note_e : cs:C1710.NoteEntity
	var $statut_o : Object
	
	var $note_es : cs:C1710.NoteSelection
	
	$note_es:=ds:C1482.Note.query("hebergeID = :1 AND type = :2 AND Ref_Structure = :3"; $hebergeID_el; $typeNote_t; $refStructure_t)
	
	Case of 
		: ($note_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($note_es.length=1)
			$note_e:=$note_es[0]
		Else   // Création de la fiche [Note]
			$note_e:=ds:C1482.Note.new()
			
			$note_e.detail:=New object:C1471
			$note_e.detail.note:=New collection:C1472
			
			$note_e.Ref_Structure:=$refStructure_t
			$note_e.hebergeID:=$hebergeID_el
			$note_e.type:=$typeNote_t
			
			$statut_o:=$note_e.save()
			
			If ($statut_o.success=False:C215)
				TRACE:C157
			End if 
			
	End case 