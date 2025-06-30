// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/01/20, 20:31:43
// ----------------------------------------------------
// Method: [Factures].edit.btn_imprimer
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_TEXT:C284($filename; $file_name_pdf; $impression_modele)
		
		SOC_Get_Config
		
		If (Size of array:C274(tb_fac_modeles_imp)>1)
			UTL_Form_Popup("Modèles d'impression"; ->tb_fac_modeles_imp; ->$impression_modele)
		End if 
		
		If (OK=1)
			GES_Imp_Maj_Variables(->[Factures:86]; $impression_modele)
			
			If ([Factures:86]FAC_Montant_TTC:8>0)
				If ([Factures:86]FAC_No_Piece:2#"")
					$filename:="Facture_"+Replace string:C233([Factures:86]FAC_No_Piece:2; SO_Facture_Prefixe+"/"; "")+"_"+[Factures:86]FAC_Destinataire_Nom:13
				Else 
					$filename:="Facture_provisoire_"+String:C10([Factures:86]ID:1)+"_"+[Factures:86]FAC_Destinataire_Nom:13
				End if 
			Else 
				$filename:="Avoir_"+Replace string:C233([Factures:86]FAC_No_Piece:2; SO_Avoir_Prefixe+"/"; "")+"_"+[Factures:86]FAC_Destinataire_Nom:13
			End if 
			
			$file_name_pdf:=$filename+".pdf"
			$file_name_pdf:=Replace string:C233($file_name_pdf; " "; "_")
			
			If ([Factures:86]FAC_Type_Facturation:49="Participations")
				$file_name_pdf:=Replace string:C233($file_name_pdf; "Facture"; "Participation")
			End if 
			
			SET PRINT OPTION:C733(Option nom document à imprimer:K47:10; $file_name_pdf)
			SET PRINT OPTION:C733(Option destination:K47:7; 1; $file_name_pdf)
			
			If ($impression_modele#"Modèle par défaut")
				
				If (SO_Activer_TVA)
					WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_tva"; 2; 2; False:C215)
				Else 
					WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_model"; 2; 2; False:C215)
				End if 
				
			Else 
				
				If (SO_Activer_TVA)
					WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_hb_tva"; 2; 2; False:C215)
				Else 
					WebAGL_Print_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; "print_hg_ancien"; 2; 2; False:C215)
				End if 
				
			End if 
			
			SET PRINT OPTION:C733(Option destination:K47:7; 2; $file_name_pdf)
			
		End if 
		
End case 