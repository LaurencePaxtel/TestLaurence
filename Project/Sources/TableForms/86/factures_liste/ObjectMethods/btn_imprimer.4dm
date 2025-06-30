// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13/02/20, 13:04:12
// ----------------------------------------------------
// Method: [Factures].Liste_HB.btn_imprimer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($fileName_t; $fileNamePDF_t; $modeleImpression_t; $document_t)
C_LONGINT:C283($i_el; $position_el)
C_BOOLEAN:C305($stop_b; $displayPrintParamWindows_b; $forcePassage_b; $ajoutSituationComptable_b)
C_COLLECTION:C1488($factureSelect_c)

$position_el:=Find in array:C230(tb_fac_choix; True:C214)

If ($position_el>0)
	// Modifié par : Scanu Rémy - remy@connect-io.fr (05/05/2021)
	SOC_Get_Config(1)
	
	If ([SOciete:18]modele:135#Null:C1517)
		$modele_c:=[SOciete:18]modele:135["4D"].query("table = :1 AND type = :2"; Table:C252(->[Factures:86]); "participation")
		
		If ($modele_c.length=1)
			$forcePassage_b:=($modele_c[0].modele="Modèle 4D Write Pro")
			
			If ($forcePassage_b=True:C214)
				$document_t:=$modele_c[0].document
			End if 
			
		End if 
		
	End if 
	
	Case of 
		: (Num:C11(Form:C1466.appel)=2) & ($forcePassage_b=True:C214)  // Bouton "Liste des factures" du formulaire [Factures]Liste_P
			OK:=1
		: (Size of array:C274(tb_fac_modeles_imp)>1)
			UTL_Form_Popup("Modèles d'impression"; ->tb_fac_modeles_imp; ->$modeleImpression_t)
	End case 
	
	If (OK=1)
		// Modifié par : Scanu Rémy (14/03/2023)
		// On doit vérifier combien de factures sont sélectionnées
		$factureSelect_c:=New collection:C1472
		
		ARRAY TO COLLECTION:C1563($factureSelect_c; tb_fac_choix; "factureSelect"; tb_fac_id; "factureID"; tb_fac_numero; "factureNum")
		$factureSelect_c:=$factureSelect_c.query("factureSelect = :1"; True:C214)
		
		// Modifié par : Scanu Rémy (29/08/2023)
		CONFIRM:C162("Voulez-vous inclure la situation comptable lors de l'impression de la facture ?"; "Oui"; "Non")
		$ajoutSituationComptable_b:=(OK=1)
		
		$displayPrintParamWindows_b:=($factureSelect_c.length=1)
		
		If ($factureSelect_c.length>1)
			PRINT SETTINGS:C106(Dialogue impression:K47:17)
			$stop_b:=(OK=0)
			
			If (OK=1)
				$fileNamePDF_t:="Liasse facture "+$factureSelect_c.extract("factureID").join(", ")
				
				SET PRINT OPTION:C733(Option nom document à imprimer:K47:10; $fileNamePDF_t)
				SET PRINT OPTION:C733(Option destination:K47:7; 1; $fileNamePDF_t)
				
				OPEN PRINTING JOB:C995
			End if 
			
		End if 
		
		If (($factureSelect_c.length>1) & ($stop_b=False:C215)) | ($factureSelect_c.length=1)  // S'il y a plusieurs factures sélectionnées et que l'utilisateur à sélectionner le repertoire dans lequel enregistrer le pdf OU s'il n'y a qu'une facture de sélectionner
			
			For ($i_el; 1; Size of array:C274(tb_fac_id))
				
				If (tb_fac_choix{$i_el}) & (tb_fac_type_piece{$i_el}#"Règlement")
					QUERY:C277([Factures:86]; [Factures:86]ID:1=tb_fac_id{$i_el})
					MultiSoc_Filter(->[Factures:86])
					
					QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
					MultiSoc_Filter(->[Factures_Lignes:87])
					
					ORDER BY:C49([Factures_Lignes:87]; [Factures_Lignes:87]FACL_No_Ordre:7; >)
					GES_Imp_Maj_Variables(->[Factures:86]; $modeleImpression_t)
					
					If ($factureSelect_c.length=1)  // Une seule facture sélectionnée
						
						If ([Factures:86]FAC_Montant_TTC:8>0)
							
							If ([Factures:86]FAC_No_Piece:2#"")
								$fileName_t:="Facture_"+Replace string:C233([Factures:86]FAC_No_Piece:2; SO_Facture_Prefixe+"/"; "")+"_"+[Factures:86]FAC_Destinataire_Nom:13
							Else 
								$fileName_t:="Facture_provisoire_"+String:C10([Factures:86]ID:1)+"_"+[Factures:86]FAC_Destinataire_Nom:13
							End if 
							
						Else 
							$fileName_t:="Avoir_"+Replace string:C233([Factures:86]FAC_No_Piece:2; SO_Avoir_Prefixe+"/"; "")+"_"+[Factures:86]FAC_Destinataire_Nom:13
						End if 
						
						$fileNamePDF_t:=$fileName_t+".pdf"
						$fileNamePDF_t:=Replace string:C233($fileNamePDF_t; " "; "_")
						
						If ([Factures:86]FAC_Type_Facturation:49="Participations")
							$fileNamePDF_t:=Replace string:C233($fileNamePDF_t; "Facture"; "Participation")
						End if 
						
						SET PRINT OPTION:C733(Option nom document à imprimer:K47:10; $fileNamePDF_t)
						SET PRINT OPTION:C733(Option destination:K47:7; 1; $fileNamePDF_t)
					End if 
					
					Case of 
						: (Num:C11(Form:C1466.appel)=2) & ($forcePassage_b=True:C214)  // Bouton "Liste des factures" du formulaire [Factures]Liste_P
							
							If ($ajoutSituationComptable_b=True:C214)
								outilsWProSend($document_t; $factureSelect_c.length; $fileNamePDF_t; New collection:C1472("Situation comptable"); True:C214)
							Else 
								outilsWProSend($document_t; $factureSelect_c.length; $fileNamePDF_t)
							End if 
							
						: ($modeleImpression_t#"Modèle par défaut") & (SO_Activer_TVA=True:C214)
							WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_tva"; 2; 2; False:C215; True:C214; False:C215; $displayPrintParamWindows_b)
						: ($modeleImpression_t#"Modèle par défaut") & (SO_Activer_TVA=False:C215)
							WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_model"; 2; 2; False:C215; True:C214; False:C215; $displayPrintParamWindows_b)
						: (SO_Activer_TVA)
							WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_hb_tva"; 2; 2; False:C215; True:C214; False:C215; $displayPrintParamWindows_b)
						Else 
							WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_ancien"; 2; 2; False:C215; True:C214; False:C215; $displayPrintParamWindows_b)
					End case 
					
				End if 
				
				CLEAR VARIABLE:C89($fileNamePDF_t)
			End for 
			
			If ($factureSelect_c.length>1)  // S'il y a plusieurs factures sélectionnées et que l'utilisateur à sélectionner le repertoire dans lequel enregistrer le pdf
				CLOSE PRINTING JOB:C996
			End if 
			
		End if 
		
	End if 
	
Else 
	ALERT:C41("Veuillez sélectionner une ou plusieurs facture à imprimer")
End if 