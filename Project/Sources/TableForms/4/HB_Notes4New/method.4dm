var $i_el; $lengthMax_el; $moduloProgress_el; $vl_eventFF; $intervenantID_el : Integer
var $note_c : Collection

var $heberge_e : cs:C1710.HeBergeEntity
var $intervenant_e : cs:C1710.INtervenantsEntity

var $notes_es : cs:C1710.NoteSelection

$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		ARRAY TEXT:C222(noteType_at; 0)
		ARRAY TEXT:C222(noteContent_at; 0)
		ARRAY TEXT:C222(noteTime_at; 0)
		
		ARRAY LONGINT:C221(noteNum_ai; 0)
		
		ARRAY DATE:C224(noteDate_ad; 0)
		
		dateDu_d:=!1900-01-01!
		dateAu_d:=Current date:C33
		
		// Permet de ne pas déclencher la commande Sur appel extérieur pour les deux inputs de Date
		Form:C1466.appelExterieur:=True:C214
		POST OUTSIDE CALL:C329(Current process:C322)
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		$heberge_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
		
		$notes_es:=$heberge_e.AllNote.query("type in :1"; Form:C1466.typeNote.extract("field"))
		$notes_es.refresh()
		
		$note_c:=New collection:C1472
		Form:C1466.Notes:=New collection:C1472
		
		$data_o:=New object:C1471(\
			"dateDu"; dateDu_d; \
			"dateAu"; dateAu_d; \
			"typeNote"; note_at{note_at}; \
			"keyword"; String:C10(Form:C1466.keyword))
		
		// Modifié par : Scanu Rémy (26/08/2024)
		If (Current user:C182="apaxtel")
			$intervenantID_el:=-9999
		Else 
			outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_Login:3; <>User_Actif_Login; ->$intervenant_e; "first")
			$intervenantID_el:=$intervenant_e.ID
		End if 
		
		outilsManageNote(4; $notes_es; Form:C1466.typeNote; ->$note_c; $data_o; $intervenantID_el; <>ref_soc_active)
		
		Form:C1466.Notes:=$note_c.copy()
		
		// Modifié par : Scanu Rémy (30/08/2023)
		// Je tri par date pour garder le même tri que celui affiché
		Form:C1466.Notes:=Form:C1466.Notes.orderBy("date desc")
		
		// Mise en forme des hauteurs de lignes
		//LISTBOX FIXER HAUTEUR LIGNES(*; "List Box"; 100; lk pixels)  // La hauteur est globalement fixée à 30 pixels
		outilsCleanVariable(->noteNum_ai; ->noteType_at; ->noteDate_ad; ->noteTime_at; ->noteContent_at)
		
		If (Form:C1466.Notes.length>0)
			$lengthMax_el:=Form:C1466.Notes.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($note_o; Form:C1466.Notes)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lengthMax_el; "Mise en forme des notes en cours..."; False:C215)
				End if 
				
				APPEND TO ARRAY:C911(noteNum_ai; Form:C1466.Notes.indexOf($note_o)+1)
				APPEND TO ARRAY:C911(noteType_at; $note_o.typeNote)
				APPEND TO ARRAY:C911(noteDate_ad; $note_o.date)
				APPEND TO ARRAY:C911(noteTime_at; $note_o.heure)
				APPEND TO ARRAY:C911(noteContent_at; String:C10($note_o.note))
				
				$i_el:=$i_el+1
			End for each 
			
			outilsProgressBar(1; "arrêt")
		End if 
		
		OB REMOVE:C1226(Form:C1466; "noteCourant")
		LISTBOX SORT COLUMNS:C916(*; "List Box"; 3; <)
End case 