//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 26/08/21, 15:24:59
// ----------------------------------------------------
// Méthode : REST_reglement_detail
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($jsonString; $vt_data; $vt_HTTP_METHOD; $lib_t)
C_LONGINT:C283($vl_regl_id)
C_OBJECT:C1216($template; $vo_vide; $vo_data; $autreTable_o)
var $factures_e : cs:C1710.FacturesEntity
var $facturesLignes_es : cs:C1710.Factures_LignesSelection

ARRAY TEXT:C222($tab_header_Champs; 0)
ARRAY TEXT:C222($tab_header_Valeurs; 0)

ARRAY TEXT:C222($tt_tabNoms; 0)
ARRAY TEXT:C222($tt_tabValeurs; 0)

ARRAY TEXT:C222($head_tt_tabNoms; 0)
ARRAY TEXT:C222($head_tt_tabValeurs; 0)

ARRAY TEXT:C222($tt_text_error; 0)

ARRAY TEXT:C222($tableau_at; 0)
ARRAY LONGINT:C221($tableau_ai; 0)

Compiler_Variables

// spécifique
WEB GET VARIABLES:C683($tt_tabNoms; $tt_tabValeurs)

WEB GET HTTP HEADER:C697($head_tt_tabNoms; $head_tt_tabValeurs)

REST_variable_extraire(->$head_tt_tabNoms; ->$head_tt_tabValeurs; ->$vt_HTTP_METHOD; "X-METHOD")
REST_variable_extraire(->$tt_tabNoms; ->$tt_tabValeurs; ->$vt_data; "data")

Case of 
	: (False:C215)
	Else 
		
		If ($vt_data#"")
			$vo_data:=JSON Parse:C1218($vt_data; Est un objet:K8:27)
			$vl_regl_id:=OB_Lire_entier_long($vo_data; "regl_id")
		Else 
			REST_variable_extraire(->$tt_tabNoms; ->$tt_tabValeurs; ->$vl_regl_id; "regl_id")
		End if 
		
		If ($vl_regl_id#0)
			QUERY:C277([Reglements:93]; [Reglements:93]ID:1=$vl_regl_id)
			
			If ([Reglements:93]ID:1=0)
				APPEND TO ARRAY:C911($tt_text_error; "'regl_id' "+String:C10($vl_regl_id)+" not found.")
			End if 
			
		Else 
			APPEND TO ARRAY:C911($tt_text_error; "'regl_id' missing.")
		End if 
		
		If (Size of array:C274($tt_text_error)=0)
			APPEND TO ARRAY:C911($tab_header_Champs; "X-STATUS")
			APPEND TO ARRAY:C911($tab_header_Valeurs; "200")
			
			ref_soc_active:=[Reglements:93]Ref_Structure:2
			
			// on envoie la fiche Reglements
			$vo:=REST_Table_Detail(1; ->[Reglements:93])
			OB_Fixer_objet(->$template; "reglement"; $vo)
			
			If (ref_soc_active#"")
				// ici, on peut ajouter des tables si besoin
				QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=ref_soc_active)
				$vt_Structure_UID:=[Structures:79]UID:1
				
				QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
				
				// on envoie la fiche [Structures]
				QUERY:C277([Structures:79]; [Structures:79]Ref_Structure:3=[Factures:86]Ref_Structure:19)
				
				$vo:=REST_Table_Detail(1; ->[Structures:79])
				OB_Fixer_objet(->$template; "structure"; $vo)
				
				// On va rechercher la facture auquel est rattaché le réglement
				Case of 
					: ([Reglements:93]REG_Libelle_Plus_1:29#"")
						$lib_t:=outilsSearchFac(2; [Reglements:93]REG_Libelle_Plus_1:29)
						
						QUERY:C277([Factures:86]; [Factures:86]FAC_No_Piece:2=$lib_t)
					: ([Reglements:93]REG_Origine_IDS:21#"")
						UTL_Decoupe_texte(->[Reglements:93]REG_Origine_IDS:21; ->$tableau_at; ";")
						outilsManageArray(1; ->$tableau_at; ->$tableau_ai)
						
						QUERY WITH ARRAY:C644([Factures:86]ID:1; $tableau_ai)
				End case 
				
				If (Records in selection:C76([Factures:86])>0)
					QUERY:C277([Locations:84]; [Locations:84]ID:1=[Factures:86]FAC_Bien_ID:28)
					QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Factures:86]FAC_Bien_ID:28)
					
					QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[LesCentres:9]ID:60; *)
					QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[LesCentres:9]))
					
					If ([Adresses:53]ID:32#0)
						$vo_adresse:=REST_Table_Detail(1; ->[Adresses:53])
						
						OB_Fixer_objet(->$template; "reglement.adresse"; $vo_adresse)
					End if 
					
					GES_Imp_Maj_Variables(->[Factures:86]; "")
					GES_GL_Imp_Maj_Variables
					
					$vo_variables:=$vo_vide
					
					// on envoie le logo
					$vt_logopath:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"logos"+Séparateur dossier:K24:12
					
					If (Test path name:C476($vt_logopath)#Est un dossier:K24:2)
						CREATE FOLDER:C475($vt_logopath)
					End if 
					
					$vt_logopath:=$vt_logopath+$vt_Structure_UID+".jpeg"
					
					If (Test path name:C476($vt_logopath)#Est un document:K24:1)
						WRITE PICTURE FILE:C680($vt_logopath; [Structures:79]STRC_Logo:5; ".jpeg")
					End if 
					
					strc_logo_path:="logos/"+$vt_Structure_UID+".jpeg"
					
					OB_Fixer_texte(->$vo_variables; "strc_logo"; strc_logo_path)
					OB_Fixer_texte(->$vo_variables; "strc_ville"; SO_Ville)
					
					OB_Fixer_texte(->$vo_variables; "txt_strc_nom"; txt_strc_nom)
					OB_Fixer_texte(->$vo_variables; "txt_strc_nom_suite"; txt_strc_nom_suite)
					OB_Fixer_texte(->$vo_variables; "txt_strc_adresse"; txt_strc_adresse)
					
					// Modifié par : Scanu Rémy (27/08/2021)
					OB_Fixer_texte(->$vo_variables; "txt_strc_telephone"; txt_strc_telephone)
					OB_Fixer_texte(->$vo_variables; "txt_strc_email"; txt_strc_email)
					
					OB_Fixer_texte(->$vo_variables; "txt_piece_titre"; txt_piece_titre)
					OB_Fixer_texte(->$vo_variables; "txt_ht"; txt_ht)
					
					// Modifié par : Scanu Rémy (29/07/2021)
					OB_Fixer_texte(->$vo_variables; "periode"; "Période "+Uppercase:C13(outilsGetLibDate(2; [Factures:86]FAC_Date_Piece:3))+" "+String:C10(Year of:C25([Factures:86]FAC_Date_Piece:3)))
					
					OB_Fixer_texte(->$vo_variables; "txt_locataire_nom"; txt_locataire_nom)
					
					OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_8"; txt_titre_ligne_8)
					OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_9"; txt_titre_ligne_9)
					OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_10"; txt_titre_ligne_10)
					
					// Modifié par : Scanu Rémy (27/08/2021)
					OB_Fixer_texte(->$vo_variables; "txt_reg_montant"; String:C10([Reglements:93]REG_Montant:5; "### ##0.00 €"))
					OB_Fixer_texte(->$vo_variables; "txt_reg_date"; String:C10([Reglements:93]REG_Date_Piece:4))
					
					// Modifié par : Scanu Rémy (27/08/2021)
					OB_Fixer_texte(->$vo_variables; "txt_centre_adresse1"; $template.reglement.adresse.AD_Adresse1)
					OB_Fixer_texte(->$vo_variables; "txt_centre_adresse2"; $template.reglement.adresse.AD_Adresse2)
					OB_Fixer_texte(->$vo_variables; "txt_centre_adresse3"; $template.reglement.adresse.AD_Adresse3)
					OB_Fixer_texte(->$vo_variables; "txt_centre_cp_ville"; $template.reglement.adresse.AD_Code_postal+" "+$template.reglement.adresse.AD_Ville)
					
					OB_Fixer_texte(->$vo_variables; "txt_date_jour"; String:C10(Current date:C33))
					
					// Modifié par : Rémy Scanu (01/09/2021)
					$facturesLignes_es:=ds:C1482.Factures_Lignes.query("FACL_Piece_ID is :1"; [Factures:86]ID:1)
					$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)
					
					$autreTable_o:=$facturesLignes_es.query("FACL_Type_Ligne = :1"; "location")
					OB_Fixer_texte(->$vo_variables; "txt_facture_loyer"; String:C10($autreTable_o.sum("FACL_Montant_TTC"); "### ##0.00 €"))
					
					$autreTable_o:=$facturesLignes_es.query("FACL_Type_Ligne = :1"; "charge")
					OB_Fixer_texte(->$vo_variables; "txt_facture_charges"; String:C10($autreTable_o.sum("FACL_Montant_TTC"); "### ##0.00 €"))
					
					$autreTable_o:=$facturesLignes_es.query("FACL_Type_Ligne = :1"; "apl")
					OB_Fixer_texte(->$vo_variables; "txt_facture_apl"; String:C10($autreTable_o.sum("FACL_Montant_TTC"); "### ##0.00 €"))
					
					OB_Fixer_texte(->$vo_variables; "txt_facture_total"; String:C10(Num:C11(Replace string:C233($vo_variables.txt_facture_loyer; " €"; ""))+Num:C11(Replace string:C233($vo_variables.txt_facture_charges; " €"; ""))+\
						Num:C11(Replace string:C233($vo_variables.txt_facture_apl; " €"; "")); "### ##0.00 €"))
					OB_Fixer_texte(->$vo_variables; "txt_facture_solde_due"; String:C10($factures_e.FAC_Solde_Du_cal; "### ##0.00 €"))
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (14/06/2022)
					OB_Fixer_texte(->$vo_variables; "txt_facture_solde_anterieur"; String:C10($factures_e.FAC_Solde_Anterieur_cal; "### ##0.00 €"))
					OB_Fixer_texte(->$vo_variables; "txt_facture_total_terme"; String:C10(Num:C11(Replace string:C233($vo_variables.txt_facture_solde_anterieur; " €"; ""))+Num:C11(Replace string:C233($vo_variables.txt_facture_total; " €"; "")); "### ##0.00 €"))
					
					//OB_Fixer_texte(->$vo_variables; "txt_facture_total_terme"; Chaîne(Num(Remplacer chaîne($vo_variables.txt_facture_solde_due; " €"; ""))+Num(Remplacer chaîne($vo_variables.txt_facture_total; " €"; "")); "### ##0.00 €"))
					
					//OB_Fixer_texte(->$vo_variables; "txt_facture_solde_restant"; Chaîne(Num(Remplacer chaîne($vo_variables.txt_facture_total_terme; " €"; ""))-Num(Remplacer chaîne($vo_variables.txt_reg_montant; " €"; "")); "### ##0.00 €"))
					$vo_variables.txt_facture_solde_restant:=String:C10($factures_e.FAC_Solde_Du_cal; "### ##0.00 €")
					
					OB_Fixer_objet(->$template; "reglement.variables"; $vo_variables)
				End if 
				
			End if 
			
		Else 
			APPEND TO ARRAY:C911($tab_header_Champs; "X-STATUS")
			APPEND TO ARRAY:C911($tab_header_Valeurs; "500")
			
			OB_Fixer_tableau(->$template; "error"; ->$tt_text_error)
		End if 
		
		WEB SET HTTP HEADER:C660($tab_header_Champs; $tab_header_Valeurs)
		
		$jsonstring:=JSON Stringify:C1217($template)
End case 

WEB SEND TEXT:C677($jsonString; ".json")