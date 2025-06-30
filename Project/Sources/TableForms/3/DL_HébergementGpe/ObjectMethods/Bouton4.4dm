var $dateLimite_t; $fileName_t; $content_t; $noteClean_t; $query_t : Text
var $i_el; $lengthMax_el; $moduloProgress_el : Integer
var $note_o; $querySettings_o : Object
var $note_c : Collection
var $export_f : 4D:C1709.File

var $heberge_e; $hebergeB_e : cs:C1710.HeBergeEntity

var $note_e : cs:C1710.NoteEntity
var $note_es; $noteB_es : cs:C1710.NoteSelection

outilsHebergeLoadRecord

If ([HeBerge:4]ID:65>0)
	CONFIRM:C162("Voulez-vous importer seulement les notes de l'hébergé sélectionné ?"; "Oui"; "Non")
	
	If (OK=1)
		$hebergeB_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
	End if 
	
End if 

$dateLimite_t:=Request:C163("Avant quelle date souhaitez-vous exporter les notes écrites ?"; String:C10(Current date:C33); "Valider"; "Annuler")

If (Date:C102($dateLimite_t)#!00-00-00!)
	$fileName_t:=Select document:C905(System folder:C487(Bureau:K41:16)+"exportNote.csv"; "csv"; "Nom de du fichier d'export :"; Saisie nom de fichier:K24:17)
	
	If (OK=1)
		$export_f:=File:C1566(Document; fk chemin plateforme:K87:2)
		$querySettings_o:=New object:C1471("parameters"; New object:C1471; "context"; "liste")
		
		$querySettings_o.parameters.dateLimite:=Date:C102($dateLimite_t)
		$query_t:=$query_t+"detail.note[].date <= :dateLimite"
		
		$querySettings_o.parameters.refStructure:=<>ref_soc_active
		$query_t:=$query_t+" AND Ref_Structure = :refStructure"
		
		$note_es:=ds:C1482.Note.query($query_t; $querySettings_o)
		
		If ($hebergeB_e#Null:C1517)
			$noteB_es:=$hebergeB_e.AllNote
			$note_es:=$note_es.and($noteB_es)
		End if 
		
		$lengthMax_el:=$note_es.length
		$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($note_e; $note_es)
			
			If ($i_el%$moduloProgress_el=0)
				outilsProgressBar($i_el/$lengthMax_el; "Export des notes en cours..."; False:C215)
			End if 
			
			$note_c:=$note_e.detail.note.query("date <= :1"; Date:C102($dateLimite_t))
			
			If ($note_c.length>0)
				$heberge_e:=$note_e.OneHeberge
				
				For each ($note_o; $note_c)
					$content_t:=$content_t+$heberge_e.HB_Nom+Char:C90(Tabulation:K15:37)+$heberge_e.HB_Prénom+Char:C90(Tabulation:K15:37)
					
					$noteClean_t:=Replace string:C233(String:C10($note_o.note); Char:C90(Retour à la ligne:K15:40); "")
					$noteClean_t:=Replace string:C233($noteClean_t; Char:C90(Retour chariot:K15:38); "")
					$noteClean_t:=Replace string:C233($noteClean_t; Char:C90(Tabulation:K15:37); "")
					
					$content_t:=$content_t+String:C10($note_e.type)+Char:C90(Tabulation:K15:37)+String:C10($note_o.date)+Char:C90(Tabulation:K15:37)+String:C10($note_o.heure)+Char:C90(Tabulation:K15:37)+$noteClean_t+Char:C90(Retour à la ligne:K15:40)
				End for each 
				
			End if 
			
			$i_el:=$i_el+1
		End for each 
		
		outilsProgressBar(1; "arrêt")
		
		$export_f.setText($content_t)
		ALERT:C41("L'export des notes avant le "+$dateLimite_t+" a bien été réalisé.")
	End if 
	
End if 