var $colonne_el; $ligne_el : Integer
var $note_c : Collection

var $heberge_es : cs:C1710.HeBergeSelection
var $heberge_e : cs:C1710.HeBergeEntity

var $note_es : cs:C1710.NoteSelection
var $note_e : cs:C1710.NoteEntity

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		LISTBOX GET CELL POSITION:C971(*; "List Box"; $colonne_el; $ligne_el)
		
		Case of 
			: ($ligne_el>0)
				CONFIRM:C162("Êtes-vous certain de vouloir supprimer la note sélectionnée ?"; "Oui"; "Non")
				
				If (OK=1)
					$heberge_es:=Create entity selection:C1512([HeBerge:4])
					$heberge_e:=$heberge_es.first()
					
					Form:C1466.noteCourant:=Form:C1466.Notes[$ligne_el-1]
					$note_es:=$heberge_e.AllNote.query("type = :1"; Form:C1466.typeNote.query("lib = :1"; Form:C1466.noteCourant.typeNote)[0].field)
					$note_e:=$note_es.first()
					
					$note_c:=$note_e.detail.note.indices("UUID = :1"; Form:C1466.noteCourant.UUID)
					$note_e.detail.note.remove($note_c[0])
					
					$statut_o:=$note_e.save()
					POST OUTSIDE CALL:C329(Current process:C322)
				End if 
				
			Else 
				ALERT:C41("Merci de sélectionner une note")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 