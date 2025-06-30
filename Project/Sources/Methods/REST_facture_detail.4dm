//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 29/07/21, 15:29:05
// ----------------------------------------------------
// Méthode : REST_facture_detail
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $jsonString; $vt_data; $vt_HTTP_METHOD; $provenance_t : Text
var $vl_fact_id : Integer
var $template; $vo_vide; $vo_data; $autreTable_o : Object

var $writePro_es : cs:C1710.DOCWPROSelection

ARRAY TEXT:C222($tab_header_Champs; 0)
ARRAY TEXT:C222($tab_header_Valeurs; 0)

ARRAY TEXT:C222($tt_tabNoms; 0)
ARRAY TEXT:C222($tt_tabValeurs; 0)

ARRAY TEXT:C222($head_tt_tabNoms; 0)
ARRAY TEXT:C222($head_tt_tabValeurs; 0)

ARRAY TEXT:C222($tt_text_error; 0)

WEB GET VARIABLES:C683($tt_tabNoms; $tt_tabValeurs)
WEB GET HTTP HEADER:C697($head_tt_tabNoms; $head_tt_tabValeurs)

REST_variable_extraire(->$head_tt_tabNoms; ->$head_tt_tabValeurs; ->$vt_HTTP_METHOD; "X-METHOD")
REST_variable_extraire(->$tt_tabNoms; ->$tt_tabValeurs; ->$vt_data; "data")
REST_variable_extraire(->$tt_tabNoms; ->$tt_tabValeurs; ->$provenance_t; "provenance")

If ($vt_data#"")
	$vo_data:=JSON Parse:C1218($vt_data; Est un objet:K8:27)
	$vl_fact_id:=OB_Lire_entier_long($vo_data; "fact_id")
Else 
	REST_variable_extraire(->$tt_tabNoms; ->$tt_tabValeurs; ->$vl_fact_id; "fact_id")
End if 

If ($vl_fact_id#0)
	QUERY:C277([Factures:86]; [Factures:86]ID:1=$vl_fact_id)
	
	If ([Factures:86]ID:1=0)
		APPEND TO ARRAY:C911($tt_text_error; "'fact_id' "+String:C10($vl_fact_id)+" not found.")
	End if 
	
Else 
	APPEND TO ARRAY:C911($tt_text_error; "'fact_id' missing.")
End if 

If (Size of array:C274($tt_text_error)=0)
	APPEND TO ARRAY:C911($tab_header_Champs; "X-STATUS")
	APPEND TO ARRAY:C911($tab_header_Valeurs; "200")
	
	// Modifié par : Scanu Rémy (22/03/2023)
	// Prise en compte du modèle 4D Write Pro
	QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=[Factures:86]Ref_Structure:19)
	$vt_Structure_UID:=[Structures:79]UID:1
	
	QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
	
	If ([SOciete:18]SO_ChoixModeleFactureLoyerWeb:133="Modèle 4D Write Pro")
		$template:=New object:C1471("useWriteProModel"; True:C214)
		
		// Modifié par : Scanu Rémy (01/03/2024)
		$writePro_es:=ds:C1482.DOCWPRO.newSelection()
		
		Case of 
			: ($provenance_t="fdp_piece_print_avis")
				outilsOrdaSearchSimple(->[DOCWPRO:121]; ->[DOCWPRO:121]tag:5; "@Avis@Factures@"; ->$writePro_es)
			: ($provenance_t="fdp_piece_print_quittance")
				outilsOrdaSearchSimple(->[DOCWPRO:121]; ->[DOCWPRO:121]tag:5; "@Quittances@"; ->$writePro_es)
		End case 
		
		outilsOrdaSearchByRefStctre(->$writePro_es; w_visiteur.Ref_Structure; "structureRef")
		$template.modele:=$writePro_es.toCollection("nom").orderBy("nom").extract("nom")
	Else 
		ref_soc_active:=[Factures:86]Ref_Structure:19
		
		// On envoie la fiche Facture
		$vo:=REST_Table_Detail(1; ->[Factures:86])
		OB_Fixer_objet(->$template; "facture"; $vo)
		
		If (ref_soc_active#"")
			// On envoie la fiche [Structures]
			QUERY:C277([Structures:79]; [Structures:79]Ref_Structure:3=[Factures:86]Ref_Structure:19)
			
			$vo:=REST_Table_Detail(1; ->[Structures:79])
			OB_Fixer_objet(->$template; "structure"; $vo)
			
			QUERY:C277([Locations:84]; [Locations:84]ID:1=[Factures:86]FAC_Bien_ID:28)
			QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Factures:86]FAC_Bien_ID:28)
			
			QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[LesCentres:9]ID:60; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[LesCentres:9]))
			
			If ([Adresses:53]ID:32#0)
				$vo_adresse:=REST_Table_Detail(1; ->[Adresses:53])
				OB_Fixer_objet(->$template; "facture.adresse"; $vo_adresse)
			End if 
			
			GES_Imp_Maj_Variables(->[Factures:86]; "")
			GES_GL_Imp_Maj_Variables
			
			$vo_variables:=$vo_vide
			
			// On envoie le logo
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
			OB_Fixer_texte(->$vo_variables; "txt_strc_nom"; txt_strc_nom)
			OB_Fixer_texte(->$vo_variables; "txt_strc_nom_suite"; txt_strc_nom_suite)
			OB_Fixer_texte(->$vo_variables; "txt_strc_adresse"; txt_strc_adresse)
			
			// Modifié par : Scanu Rémy (29/07/2021)
			OB_Fixer_texte(->$vo_variables; "txt_strc_cp_ville"; txt_strc_cp_ville)
			
			OB_Fixer_texte(->$vo_variables; "txt_piece_titre"; txt_piece_titre)
			OB_Fixer_texte(->$vo_variables; "txt_ht"; txt_ht)
			
			// Modifié par : Scanu Rémy (29/07/2021)
			//OB_Fixer_texte (->$vo_variables;"periode";"Période du "+Chaîne([Factures]FAC_Periode_Du)+" au "+Chaîne([Factures]FAC_Periode_Au))
			OB_Fixer_texte(->$vo_variables; "periode"; "Période du "+String:C10(outilsGetDateWithPeriod([Factures:86]FAC_Periode:32; True:C214))+" au "+String:C10(outilsGetDateWithPeriod([Factures:86]FAC_Periode:32; False:C215)))
			
			OB_Fixer_texte(->$vo_variables; "txt_locataire_nom"; txt_locataire_nom)
			OB_Fixer_texte(->$vo_variables; "txt_locataire_adresse_1"; txt_locataire_adresse_1)
			OB_Fixer_texte(->$vo_variables; "txt_locataire_adresse_2"; txt_locataire_adresse_2)
			OB_Fixer_texte(->$vo_variables; "txt_locataire_adresse_3"; txt_locataire_adresse_3)
			OB_Fixer_texte(->$vo_variables; "txt_locataire_adresse_4"; txt_locataire_adresse_4)
			
			OB_Fixer_texte(->$vo_variables; "txt_destinataire_nom"; txt_destinataire_nom)
			OB_Fixer_texte(->$vo_variables; "txt_destinataire_adresse"; txt_destinataire_adresse)
			
			OB_Fixer_texte(->$vo_variables; "txt_lig_usager"; txt_lig_usager)
			
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_1"; txt_titre_ligne_1)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_2"; txt_titre_ligne_2)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_3"; txt_titre_ligne_3)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_4"; txt_titre_ligne_4)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_5"; txt_titre_ligne_5)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_6"; txt_titre_ligne_6)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_7"; txt_titre_ligne_7)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_8"; txt_titre_ligne_8)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_9"; txt_titre_ligne_9)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_10"; txt_titre_ligne_10)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_11"; txt_titre_ligne_11)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_12"; txt_titre_ligne_12)
			OB_Fixer_texte(->$vo_variables; "txt_titre_ligne_13"; txt_titre_ligne_13)
			
			OB_Fixer_texte(->$vo_variables; "txt_reference"; txt_reference)
			OB_Fixer_texte(->$vo_variables; "txt_qt_numero"; txt_qt_numero)
			OB_Fixer_texte(->$vo_variables; "txt_echeance_num"; txt_echeance_num)
			OB_Fixer_texte(->$vo_variables; "txt_echeance_paye"; txt_echeance_paye)
			OB_Fixer_texte(->$vo_variables; "txt_ll_date"; txt_ll_date)
			
			//FAC_Modeles_Impression_Get ("values";impression_modele)
			OB_Fixer_objet(->$template; "facture.variables"; $vo_variables)
			
			// Modifié par : Scanu Rémy (29/07/2021)
			// Il faut reprendre le solde due de la dernière facture
			$template.facture.FAC_Solde_Du_Facture_Precedente:=outilsManageFacture(0)
			
			// Modifié par : Scanu Rémy (01/06/2022)
			// Ajout du n° de réglement
			$autreTable_o:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10([Factures:86]ID:1)+"@")
			$template.facture.reglement:=$autreTable_o.toCollection()
		End if 
		
		// On cherche les lignes qui vont bien
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$vl_fact_id)
		ARRAY OBJECT:C1221($to_lignes; Records in selection:C76([Factures_Lignes:87]))
		
		// On remplit un tableau avec les lignes de factures
		For ($vl_ligne; 1; Records in selection:C76([Factures_Lignes:87]))
			$vo_ligne:=$vo_vide
			$vo_ligne:=REST_Table_Detail(1; ->[Factures_Lignes:87])
			
			$to_lignes{$vl_ligne}:=$vo_ligne
			NEXT RECORD:C51([Factures_Lignes:87])
		End for 
		
		OB_Fixer_tableau(->$template; "facture.lignes"; ->$to_lignes)
	End if 
	
Else 
	APPEND TO ARRAY:C911($tab_header_Champs; "X-STATUS")
	APPEND TO ARRAY:C911($tab_header_Valeurs; "500")
	
	OB_Fixer_tableau(->$template; "error"; ->$tt_text_error)
End if 

WEB SET HTTP HEADER:C660($tab_header_Champs; $tab_header_Valeurs)
$jsonstring:=JSON Stringify:C1217($template)

WEB SEND TEXT:C677($jsonString; ".json")