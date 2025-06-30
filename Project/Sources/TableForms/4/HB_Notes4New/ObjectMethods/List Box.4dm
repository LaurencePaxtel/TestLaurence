var $position_t : Text
var $colonne_el; $ligne_el
var $form_o; $note_o : Object
var $note_c : Collection

var $heberge_es : cs:C1710.HeBergeSelection
var $heberge_e : cs:C1710.HeBergeEntity

var $note_es : cs:C1710.NoteSelection
var $note_e : cs:C1710.NoteEntity

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		$position_t:="center"
		$form_o:=New object:C1471("typeNote"; Form:C1466.typeNote)
		
		LISTBOX GET CELL POSITION:C971(*; "List Box"; $colonne_el; $ligne_el)
		Form:C1466.noteCourant:=Form:C1466.Notes[$ligne_el-1]
		
		If (Form:C1466.noteCourant.edit=True:C214)
			$form_o.typeNoteSelected:=Form:C1466.noteCourant.typeNote
			$form_o.note:=Form:C1466.noteCourant.note
			$form_o.date:=Form:C1466.noteCourant.date
			$form_o.heure:=Form:C1466.noteCourant.heure
			
			outilsCreateWindowsForm("EditNote"; ->$position_t; $form_o; ->[Note:124])
			
			If (OK=1)  // Bouton sauvegarder et Confirmer
				$heberge_es:=Create entity selection:C1512([HeBerge:4])
				$heberge_e:=$heberge_es.first()
				
				$note_es:=$heberge_e.AllNote.query("type = :1"; Form:C1466.typeNote.query("lib = :1"; Form:C1466.noteCourant.typeNote)[0].field)
				$note_e:=$note_es.first()
				
				$note_c:=$note_e.detail.note.query("UUID = :1"; Form:C1466.noteCourant.UUID)
				$note_o:=$note_c[0]
				
				$note_o.note:=String:C10($form_o.note)
				
				If (Date:C102($form_o.date)#!00-00-00!)
					$note_o.date:=Date:C102($form_o.date)
				Else 
					ALERT:C41("Date au mauvais format, la date précédente a été prise en compte")
				End if 
				
				If (String:C10(Time:C179($form_o.heure); Heures minutes secondes:K7:3)#"00:00:00")
					$note_o.heure:=$form_o.heure
				Else 
					ALERT:C41("Heure au mauvais format, l'heure précédente a été prise en compte")
				End if 
				
				$note_o.ts:=outilsTimeStamp(Current date:C33; Current time:C178)
				
				$statut_o:=$note_e.save()
				POST OUTSIDE CALL:C329(Current process:C322)
			Else 
				OB REMOVE:C1226(Form:C1466; "noteCourant")
			End if 
			
		Else 
			ALERT:C41("Vous n'avez pas le privilège nécessaire pour modifier la note sélectionnée")
		End if 
		
End case 