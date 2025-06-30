var $position_el : Integer
var $element_o : Object
var $liste_c; $heberge_c : Collection

var $facture_e : cs:C1710.FacturesEntity

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

$liste_c:=New collection:C1472
$heberge_c:=New collection:C1472

$position_el:=Find in array:C230(tb_fac_choix; True:C214)

If ($position_el>0)
	CONFIRM:C162("Voulez-vous vraiment imprimer la situation comptable des factures sélectionnées ci-dessous ?"; "Oui"; "Non")
	
	If (OK=1)
		ARRAY TO COLLECTION:C1563($liste_c; tb_fac_id; "factureID"; tb_fac_date; "datePiece"; tb_fac_numero_piece; "numeroPiece"; tb_fac_type_piece; \
			"typePiece"; tb_fac_libelle; "libelle"; tb_fac_debit; "debit"; tb_fac_credit; "credit"; tb_fac_choix; "selectionne")
		
		$liste_c:=$liste_c.query("typePiece # :1 AND selectionne = :2"; "Règlement"; True:C214)
		
		SOC_Get_Config(1)
		PRINT SETTINGS:C106(Dialogue impression:K47:17)
		
		If (OK=1)
			OPEN PRINTING JOB:C995
			
			// Extraction de tous les hébergés concernés
			For each ($element_o; $liste_c)
				$facture_e:=ds:C1482.Factures.get($element_o.factureID)
				
				If ($facture_e#Null:C1517)
					$heberge_c.push($facture_e.FAC_Origine_ID)
				End if 
				
			End for each 
			
			$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID in :1"; $heberge_c)
			
			For each ($heberge_e; $heberge_es)
				// Génération de la liste des factures et règlements pour chaque hébergé
				liste_c:=$heberge_e.getSituationComptableList()
				
				// Génération du document PDF
				QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$heberge_e.ID)
				
				SOC_Get_Config(1)
				outilsWProSend("Situation comptable"; 2; "")
			End for each 
			
			CLOSE PRINTING JOB:C996
		End if 
		
	End if 
	
Else 
	ALERT:C41("Veuillez sélectionner une ou plusieurs facture")
End if 

UNLOAD RECORD:C212([HeBerge:4])