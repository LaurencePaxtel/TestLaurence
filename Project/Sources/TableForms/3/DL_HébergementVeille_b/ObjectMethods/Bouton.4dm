C_LONGINT:C283($pos_el)
C_BOOLEAN:C305($stop_b)
C_DATE:C307($date_d)
C_OBJECT:C1216($table_o; $enregistrement_o)

ARRAY LONGINT:C221($hbID_ai; 0)
ARRAY LONGINT:C221($hbIDTraite_ai; 0)

If (Records in set:C195("$ListboxSet")>0)
	CONFIRM:C162("Êtes-vous certain de vouloir générer les dates de sorties pour les fiches d'hébergements antérieures liées à chaque fiche d'hébergement sélectionnée ?"; "Oui"; "Non")
	
	If (OK=1)
		USE SET:C118("$ListboxSet")
		
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; [HeberGement:5]HG_Date:4; <)
		DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $hbID_ai)
		
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		While (Not:C34(End selection:C36([HeberGement:5])))
			outilsProgressBar(Selected record number:C246([HeberGement:5])/Records in selection:C76([HeberGement:5]); "Application des dates de sorties en cours...")
			
			$pos_el:=Find in array:C230($hbIDTraite_ai; [HeberGement:5]HG_HB_ID:19)
			
			If ($pos_el=-1)
				// On cherche toutes les fiches d'hébergements de l'hébergé qui ont une date PEC début inférieure à la date de sortie indiquée
				$table_o:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date < :2 AND ID # :3"; [HeberGement:5]HG_HB_ID:19; [HeberGement:5]HG_Date:4; [HeberGement:5]ID:168).orderBy("HG_Date desc")
				$date_d:=Date:C102([HeberGement:5]HG_Date:4)
				
				For each ($enregistrement_o; $table_o) Until ($stop_b=True:C214)
					$date_d:=Add to date:C393($date_d; 0; 0; -1)
					
					If (Date:C102($enregistrement_o.HG_Date)=$date_d)
						$enregistrement_o.HG_DateSortie:=[HeberGement:5]HG_DateSortie:185
						
						$enregistrement_o.save()
					Else 
						$stop_b:=True:C214
					End if 
					
				End for each 
				
				APPEND TO ARRAY:C911($hbIDTraite_ai; [HeberGement:5]HG_HB_ID:19)
				CLEAR VARIABLE:C89($stop_b)
			End if 
			
			If (progressBar_el=0)
				LAST RECORD:C200([HeberGement:5])
			End if 
			
			NEXT RECORD:C51([HeberGement:5])
		End while 
		
		outilsProgressBar(1; "arrêt")
	End if 
	
End if 