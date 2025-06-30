If (Form event code:C388=Sur clic:K2:4)
	C_TEXT:C284($tab_t; $cr_t; $export_t; $champ_t; $nomFichier_t)
	C_LONGINT:C283($i_el)
	C_BOOLEAN:C305($continue_b)
	C_OBJECT:C1216($docExport_o; $table_o; $enregistrement_o)
	
	ARRAY TEXT:C222($nomColonne_at; 0)
	ARRAY TEXT:C222($nomEntete_at; 0)
	
	ARRAY LONGINT:C221($indiceVisibleColonne_ai; 0)
	
	ARRAY BOOLEAN:C223($visibleColonne_ab; 0)
	
	ARRAY POINTER:C280($varColonne_ap; 0)
	ARRAY POINTER:C280($varEntete_ap; 0)
	ARRAY POINTER:C280($styleColonne_ap; 0)
	
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "Imprimer")
	Else 
		// Modifié par : Scanu Rémy - remy@connect-io.fr (28/05/2021)
		// On fait un export excel et plus une impression d'un formulaire
		$tab_t:=";"
		$cr_t:=Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40)
		
		$continue_b:=True:C214
		
		$nomFichier_t:="Export_"+Replace string:C233(String:C10(Current date:C33); "/"; "")+"_"+Replace string:C233(Time string:C180(Current time:C178); ":"; "")+".csv"
		
		$docExport_o:=File:C1566(System folder:C487(Bureau:K41:16)+$nomFichier_t; fk chemin plateforme:K87:2)
		
		LISTBOX GET ARRAYS:C832(*; "The_List_box"; $nomColonne_at; $nomEntete_at; $varColonne_ap; $varEntete_ap; $visibleColonne_ab; $styleColonne_ap)
		
		$table_o:=Create entity selection:C1512([HeberGement:5])
		
		// On ne va exporter que les colonnes visibles
		For ($i_el; 1; Size of array:C274($nomEntete_at))
			
			If ($visibleColonne_ab{$i_el}=True:C214)
				APPEND TO ARRAY:C911($indiceVisibleColonne_ai; $i_el)
			End if 
			
		End for 
		
		// Entête suivant les colonnes visibles
		For ($i_el; 1; Size of array:C274($indiceVisibleColonne_ai))
			$export_t:=$export_t+$nomEntete_at{$indiceVisibleColonne_ai{$i_el}}+Choose:C955($i_el<Size of array:C274($indiceVisibleColonne_ai); $tab_t; $cr_t)
		End for 
		
		// Corps suivant les colonnes visibles
		outilsProgressBar(0; "Initialisation"; True:C214)
		
		For each ($enregistrement_o; $table_o) Until ($continue_b=False:C215)
			outilsProgressBar($enregistrement_o.indexOf($table_o)/$table_o.length; "Export en cours...")
			
			For ($i_el; 1; Size of array:C274($indiceVisibleColonne_ai))
				$champ_t:=Field name:C257($varColonne_ap{$i_el})
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (11/06/2021)
				// Ajout de quelques cas particuliers pour l'export
				Case of 
					: ($champ_t="HB_Telephone")
						$export_t:=$export_t+String:C10($enregistrement_o.HG_HB_ID_1_HB_ReferenceID[$champ_t])+Choose:C955($i_el<Size of array:C274($indiceVisibleColonne_ai); $tab_t; $cr_t)
					Else 
						$export_t:=$export_t+String:C10($enregistrement_o[$champ_t])+Choose:C955($i_el<Size of array:C274($indiceVisibleColonne_ai); $tab_t; $cr_t)
				End case 
				
			End for 
			
			If (progressBar_el=0)
				$continue_b:=False:C215
			End if 
			
		End for each 
		
		outilsProgressBar(1; "arrêt")
		
		$docExport_o.setText($export_t; "UTF-8")
		
		// Alerte
		ALERT:C41("** Le fichier "+$nomFichier_t+" a été créé sur le bureau de votre poste")
		
		//_O_UTILISER PARAMÈTRES IMPRESSION([HeberGement];"HG_PrtVeille")
		//PARAMÈTRES IMPRESSION
		
		//Si (OK=1)
		//vL_NbFiches:=Enregistrements trouvés([HeberGement])
		
		//FORM FIXER SORTIE([HeberGement];"HG_PrtVeille")
		//IMPRIMER SÉLECTION([HeberGement];*)
		//Fin de si 
	End if 
	
End if 