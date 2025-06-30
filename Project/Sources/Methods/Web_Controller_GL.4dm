//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 02/12/18, 18:39:23
// ----------------------------------------------------
// Méthode : Web_Controller_GL
// Description
// Controlleur du module de la Gestion immobilière
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($action; $saction; $staction; $user_type; $UIDP; $UIDT; $sform; $html; $folder; $reponse_t; \
$records_selected; $nom_bien; $nom_locataire)
C_LONGINT:C283($table_num; $id_el; $id; $bien_id; $id_bien; $id_locataire; $i)
C_REAL:C285($montant_reglement)
C_BOOLEAN:C305($go; $continue_b; $privileges_facturation; $new_record; $error)
C_POINTER:C301($table_ptr; $champ_uid_ptr; $champ_uid; $param_1)
C_OBJECT:C1216($enregistrement_o; $retour_o; $data_o; $table_o)
C_COLLECTION:C1488($collection_c)

C_TEXT:C284(LANG_TXT_FICHE; MESSAGE_INFO; MESSAGE_ETAT; BTN_LISTE_TOP; web_form_back_view)

ARRAY TEXT:C222($_field; 0)
ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY TEXT:C222($tab_records_selected; 0)

ARRAY LONGINT:C221($id_ai; 0)
ARRAY LONGINT:C221($tb_ids; 0)
ARRAY LONGINT:C221($tb_fac_id; 0)

ARRAY TEXT:C222(TB_SLISTE; 0)
ARRAY TEXT:C222(TB_METHODE_REFRESH; 1)

$table_ptr:=->[HeBerge:4]
$champ_uid:=->[HeBerge:4]ID:65

READ WRITE:C146($table_ptr->)

//--------------params-----------------
WEB GET HTTP HEADER:C697($_field; $_content)

$method:=$_content{1}
$method:=WEB_UTL_GET_PARAMS("method")
$action:=WEB_UTL_GET_PARAMS("action")

$UID:=WEB_UTL_GET_PARAMS("UID")  // sinon utl_champ est utilisé -> WEB_GET_VALUE_CHAMP(->[Taches]UID)
UIDM:=WEB_UTL_GET_PARAMS("UIDM")

$Length:=60

$Page:=Num:C11(WEB_UTL_GET_PARAMS("page"))
$champAuto:=WEB_UTL_GET_PARAMS("c")
$annuler:=WEB_UTL_GET_PARAMS("annuler")
$search:=WEB_UTL_GET_PARAMS("search")

$user_type:=WEB_UTL_GET_PARAMS("user")
$profile_type:=WEB_UTL_GET_PARAMS("type")

$saction:=WEB_UTL_GET_PARAMS("saction")
$staction:=WEB_UTL_GET_PARAMS("staction")
$UIDP:=WEB_UTL_GET_PARAMS("UIDP")

$UIDT:=WEB_UTL_GET_PARAMS("UIDT")

$sform:=WEB_UTL_GET_PARAMS("sform")

BTN_LISTE:=""
LANG_TXT_FICHE:=""
NOM_PREF_RECHERCHE:="Profile"

FIX_PARAM_BTNS:=""
FIX_PARAM_BTNS_LN:=""
FIX_PARAM_BTNS_LND:=""

HTML_HOME:="Gestion immobilière"
HTML_NAME_MODULE:="Paxtel"
HTML_NAME_NAV:=""
HTML_NAME_NAV_MODULE:=LANG_TXT_USAGER_RECHERCHE

BTN_MAIL:=True:C214
CHERCHER_TRANSACTION:=False:C215

vDate:=Current date:C33
vHour:=Current time:C178

UNLOAD RECORD:C212($table_ptr->)

If ($_content{1}="POST")
	$action:=WEB_URL_GET_PARAM($_content{2}; "action")
End if 

Case of 
	: ($action="usager-list")
		HTML_NAME_NAV_MODULE:="Gestion des locataires, colocataires et mandataires"
		
		UNLOAD RECORD:C212([HeBerge:4])
		UNLOAD RECORD:C212([HeberGement:5])
		
		$table_ptr:=->[HeBerge:4]
		$champ_uid_ptr:=->[HeBerge:4]HB_ReferenceID:1
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_full\"><div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-locataires-search\" type=\"submit\" class=\"fdp_Button  fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH_LOCATAIRES+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-search\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_margin_left_5px\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH_USAGERS+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"fdp_locataire_add\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_LOCATAIRE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		UTL_Add_Script("gl_liste_locataires")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_locataires")
		
		UTL_Add_Script("iw_datatable")
		UTL_Add_Script("gl_dashboard")
		Web_UTL_Add_CSS("iw_datatable")
		
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Usager_Recherche(->$go)
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"int-usager-table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		BTN_LISTE:=""
		
		APPEND TO ARRAY:C911($tb_headers_th; " ")
		APPEND TO ARRAY:C911($tb_headers_th; "Clé")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom")
		APPEND TO ARRAY:C911($tb_headers_th; "Prénom")
		APPEND TO ARRAY:C911($tb_headers_th; "Date de naissance")
		APPEND TO ARRAY:C911($tb_headers_th; "Type locataire")
		APPEND TO ARRAY:C911($tb_headers_th; "Lien de famille")
		APPEND TO ARRAY:C911($tb_headers_th; "Tél")
		APPEND TO ARRAY:C911($tb_headers_th; "Location en cours")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_locataires")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Usager_Popup
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		BTN_LISTE:=""
		
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form($champ_uid_ptr; $table_ptr)
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="usager_list_json")
		$nom:=WEB_UTL_GET_PARAMS("nom")
		$prenom:=WEB_UTL_GET_PARAMS("prenom")
		$date_naissance:=Date:C102(WEB_UTL_GET_PARAMS("date_naissance"))
		$lien_famille:=WEB_UTL_GET_PARAMS("lien_famille")
		$telephone:=WEB_UTL_GET_PARAMS("telephone")
		
		Web_Int_Get_Heberges($nom; $prenom; $date_naissance; $lien_famille; $telephone; "all")
	: ($action="locataires_list_json")
		Web_Int_Get_Locataires("usagers"; "details")
	: ($action="locataires_list_ts_json")
		Web_Int_Get_Locataires_TS("usagers"; "details")
	: ($action="usager_fiche_valider")
		Web_GL_Set_Heberge
	: ($action="pro_fiche_valider")
		Web_GL_Set_Proprietaire
	: ($action="irl_fiche_valider")
		Web_Save_IRL(->[IRL_CONFIG:85]; "irl")
	: ($action="location_fiche_valider")
		Web_Save_Location(->[Locations:84]; "location")
	: ($action="proprietaires")
		HTML_NAME_NAV_MODULE:="Gestion des propriétaires"
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		// Modifié par : Scanu Rémy (24/05/2024)
		//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_FICHE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_AFFICHER_TOUT+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		//UTL_Add_Script ("gl_main")
		UTL_Add_Script("gl_liste_proprietaires")
		UTL_Add_Script("gl_dashboard")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("gl_liste_proprietaires")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Proprietaires(->$go)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		APPEND TO ARRAY:C911($tb_headers_th; "Nom")
		APPEND TO ARRAY:C911($tb_headers_th; "Prénom")
		APPEND TO ARRAY:C911($tb_headers_th; "Téléphone")
		APPEND TO ARRAY:C911($tb_headers_th; "E-mail")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_proprietaires")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Proprietaire_Popup
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Proprietaires:83]ID:1; ->[Proprietaires:83])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="locations")
		HTML_NAME_NAV_MODULE:="Gestion des locations"
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_fac_export\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-file-excel-o\"></i>Export Factures</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_fac_auto\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-file-pdf-o\"></i>"+LANG_TXT_BTN_FAC_AUTO+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_FICHE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_AFFICHER_TOUT+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_recalculer\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-orange iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-calculator\"></i>"+LANG_TXT_BTN_RECALCULER_IRL+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_delete\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa  fa-remove\"></i>"+LANG_TXT_BTN_SUPPRIMER+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_liste_locations")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_locations")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=Web_Form_Locations(->$go)
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		APPEND TO ARRAY:C911($tb_headers_th; " ")
		APPEND TO ARRAY:C911($tb_headers_th; "Date du bail")
		APPEND TO ARRAY:C911($tb_headers_th; "Usager")
		APPEND TO ARRAY:C911($tb_headers_th; "Bien en location")
		APPEND TO ARRAY:C911($tb_headers_th; "Montant du loyer")
		APPEND TO ARRAY:C911($tb_headers_th; "Montant révisé")
		APPEND TO ARRAY:C911($tb_headers_th; "Date d'entrée dans les lieux")
		APPEND TO ARRAY:C911($tb_headers_th; "Date de sortie des lieux")
		APPEND TO ARRAY:C911($tb_headers_th; "APL")
		APPEND TO ARRAY:C911($tb_headers_th; "Charges")
		APPEND TO ARRAY:C911($tb_headers_th; "Statut")
		APPEND TO ARRAY:C911($tb_headers_th; "Commentaire")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_locations")
		
		// Modifié par : Scanu Rémy (25/08/2021)
		// Ajout du popup facturation automatique
		HTML_VIEW:=HTML_VIEW+Web_Form_FAC_Auto_Popup
		
		//HTML_VIEW:=HTML_VIEW+Web_Form_Location_Popup 
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Locations:84]ID:1; ->[Locations:84])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="location")
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		$bien_id:=Num:C11(WEB_UTL_GET_PARAMS("bien_id"))
		
		web_form_back_view:=WEB_UTL_GET_PARAMS("retour")
		
		If ($id=0)
			READ WRITE:C146([Locations:84])
			
			CREATE RECORD:C68([Locations:84])
			MultiSoc_Init_Structure(->[Locations:84])
			
			[Locations:84]LOC_Statut:17:="temp"
			[Locations:84]LOC_Intervenant_ID:18:=w_userUID
			[Locations:84]LOC_Date:2:=Current date:C33(*)
			[Locations:84]LOC_Bien_ID:5:=$bien_id
			SAVE RECORD:C53([Locations:84])
			
			$id:=[Locations:84]ID:1
			UNLOAD RECORD:C212([Locations:84])
			
			$new_record:=True:C214
			WEB SEND HTTP REDIRECT:C659("/GL?action=location&id="+String:C10($id)+"&retour="+web_form_back_view)
			ABORT:C156
		End if 
		
		READ ONLY:C145([Locations:84])
		
		QUERY:C277([Locations:84]; [Locations:84]ID:1=$id)
		MultiSoc_Filter(->[Locations:84])
		
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
		MultiSoc_Filter(->[LesCentres:9])
		
		READ ONLY:C145([HeBerge:4])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
		MultiSoc_Filter(->[HeBerge:4])
		
		HTML_NAME_NAV:="Location"
		
		If (Records in selection:C76([Locations:84])=1)
			LANG_TXT_FICHE:=LANG_TXT_FICHE+[Locations:84]LOC_Titre:14
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		End if 
		
		HTML_VIEW:=Web_Form_GL_Location
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Locations:84]ID:1; ->[Locations:84])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		// Modifié par : Scanu Rémy (08/03/2023)
		// Ajout du script pour éditer une cellule dans un tableau HTML
		UTL_Add_Script("iw_tableCellEditor")
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="biens")
		HTML_NAME_NAV_MODULE:="Liste des biens"
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		// Modifié par : Scanu Rémy (24/05/2024)
		//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
		//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		
		UTL_Add_Script("gl_liste_biens")
		UTL_Add_Script("gl_dashboard")
		Web_UTL_Add_CSS("recherche_usager")
		
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_biens")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GL_Biens(->$go)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		ARRAY TEXT:C222($tb_headers_th; 0)
		
		APPEND TO ARRAY:C911($tb_headers_th; "Nom du bien")
		APPEND TO ARRAY:C911($tb_headers_th; "Propriétaire")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom Immeuble")
		APPEND TO ARRAY:C911($tb_headers_th; "Type de gestion")
		APPEND TO ARRAY:C911($tb_headers_th; "Locations en cours")
		APPEND TO ARRAY:C911($tb_headers_th; "Sinistres en cours")
		APPEND TO ARRAY:C911($tb_headers_th; "Bien actif")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_biens")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GL_Bien_Popup
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[LesCentres:9]ID:60; ->[LesCentres:9])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="bien")
		C_TEXT:C284(web_form_back_view)
		
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		web_form_back_view:=WEB_UTL_GET_PARAMS("retour")
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
		//Si ($id=0)
		//WEB ENVOYER REDIRECTION HTTP("/GL?action=biens")
		//STOP
		//Fin de si 
		
		If ($id=0)
			READ WRITE:C146([LesCentres:9])
			CREATE RECORD:C68([LesCentres:9])
			
			MultiSoc_Init_Structure(->[LesCentres:9])
			
			SAVE RECORD:C53([LesCentres:9])
			
			$id:=[LesCentres:9]ID:60
			UNLOAD RECORD:C212([LesCentres:9])
			$new_record:=True:C214
			
			WEB SEND HTTP REDIRECT:C659("/GL?action=bien&id="+String:C10($id)+"&retour="+web_form_back_view)
			ABORT:C156
		End if 
		
		READ ONLY:C145([LesCentres:9])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=$id)
		MultiSoc_Filter(->[LesCentres:9])
		
		HTML_NAME_NAV:="Bien en location"
		
		If (Records in selection:C76([LesCentres:9])=1)
			LANG_TXT_FICHE:=LANG_TXT_FICHE+[LesCentres:9]LC_GL_Nom_Suite:63
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		End if 
		
		HTML_VIEW:=Web_Form_GL_Bien
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[LesCentres:9]ID:60; ->[LesCentres:9])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="equipements")
		HTML_NAME_NAV_MODULE:="Paramétrage des équipements"
		BTN_LISTE:=Web_Form_Boutons("dashboard_equippements")
		
		HTML_VIEW:=""
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_EQU+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		
		UTL_Add_Script("gl_dashboard")
		UTL_Add_Script("gl_liste_equipements")
		
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("form")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GL_Filtres_EQU
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		APPEND TO ARRAY:C911($tb_headers_th; "Type")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom")
		APPEND TO ARRAY:C911($tb_headers_th; "Référence fabricant")
		APPEND TO ARRAY:C911($tb_headers_th; "Référence structure")
		APPEND TO ARRAY:C911($tb_headers_th; "Garantie")
		APPEND TO ARRAY:C911($tb_headers_th; "Date d’achat")
		APPEND TO ARRAY:C911($tb_headers_th; "Prix d’achat")
		APPEND TO ARRAY:C911($tb_headers_th; "Montant TTC")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table")
		
		$html:=Web_Form_GI_Equipement
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("equipement"; ->$html; False:C215)
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Equipement:107]ID:1; ->[Equipement:107])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="equipements_biens")
		HTML_NAME_NAV_MODULE:="Liste des équipements"
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard_equippements")
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_EQU+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		
		UTL_Add_Script("gl_dashboard")
		UTL_Add_Script("gl_liste_equipements_b")
		
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("form")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GL_Filtres_EQU(True:C214)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		APPEND TO ARRAY:C911($tb_headers_th; " ")
		APPEND TO ARRAY:C911($tb_headers_th; "Type")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom")
		APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
		APPEND TO ARRAY:C911($tb_headers_th; "Emplacement")
		APPEND TO ARRAY:C911($tb_headers_th; "Pièce")
		APPEND TO ARRAY:C911($tb_headers_th; "Date d’installation")
		APPEND TO ARRAY:C911($tb_headers_th; "Garantie")
		APPEND TO ARRAY:C911($tb_headers_th; "Date d’achat")
		APPEND TO ARRAY:C911($tb_headers_th; "Prix d’achat")
		APPEND TO ARRAY:C911($tb_headers_th; "Montant TTC")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table")
		
		$html:=Web_Form_GI_Equipement("LK_GB")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("equipement"; ->$html; False:C215)
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Piece_LK_Equipement:115]ID:1; ->[Piece_LK_Equipement:115])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="stocks")
		HTML_NAME_NAV_MODULE:="Gestion de stock"
		
		HTML_VIEW:=""
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NV_MVMT_STK+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_dashboard")
		UTL_Add_Script("gl_liste_stock")
		
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("form")
		//Web_UTL_Add_CSS ("gl_liste_stock") //**
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GL_Filtres_Stock
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		//APPEND TO ARRAY($tb_headers_th;" ")
		APPEND TO ARRAY:C911($tb_headers_th; "Équipement")
		APPEND TO ARRAY:C911($tb_headers_th; "Type")
		APPEND TO ARRAY:C911($tb_headers_th; "Référence fabricant")
		APPEND TO ARRAY:C911($tb_headers_th; "Quantité en stock")
		APPEND TO ARRAY:C911($tb_headers_th; "Quantité réservée")
		APPEND TO ARRAY:C911($tb_headers_th; "Quantité disponible")
		//APPEND TO ARRAY($tb_headers_th;"Emplacement")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table")
		
		//$html:=Web_Form_GI_Equipement 
		//HTML_VIEW:=HTML_VIEW+Web_Form_Popup ("equipement";->$html;False)
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="stock")
		C_LONGINT:C283($id)
		C_BOOLEAN:C305($new_record)
		
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		
		UTL_Add_Script("gl_fiche_stock")
		
		Web_UTL_Add_CSS("form")
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("fiche_stock.css")
		
		READ ONLY:C145([Stock:113])
		READ ONLY:C145([Equipement:107])
		
		QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=$id)
		MultiSoc_Filter(->[Stock:113])
		
		QUERY:C277([Equipement:107]; [Equipement:107]ID:1=$id)
		MultiSoc_Filter(->[Equipement:107])
		
		HTML_HOME:="Gestion immobilière"
		HTML_NAME_NAV:="Mouvements de stock"
		
		If (Records in selection:C76([Equipement:107])=1)
			LANG_TXT_FICHE:=LANG_TXT_FICHE+"  "+[Equipement:107]EQU_Nom:4+" "+[Equipement:107]EQU_Reference_Fabricant:6
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		End if 
		
		//=============================================================================//
		// Mouvements de stock
		//=============================================================================//
		
		BTN_LISTE:=""
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
		BTN_LISTE:=BTN_LISTE+"MOUVEMENTS DE STOCK"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half btns_list_right\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_mouvement\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NV_MVMT_STK+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Boutons("stock_fiche_top")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Stock
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		ARRAY TEXT:C222($tb_headers_th; 0)
		
		APPEND TO ARRAY:C911($tb_headers_th; "Date")
		APPEND TO ARRAY:C911($tb_headers_th; "Heure")
		APPEND TO ARRAY:C911($tb_headers_th; "Nature")
		APPEND TO ARRAY:C911($tb_headers_th; "Quantité")
		APPEND TO ARRAY:C911($tb_headers_th; "Motif")
		APPEND TO ARRAY:C911($tb_headers_th; "Emplacement")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table")
		
		$html:=Web_Form_GI_STK_Ligne
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("stkm"; ->$html; False:C215)
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="interventions")
		READ WRITE:C146([Intervention:108])
		READ WRITE:C146([Intervention_Lignes:109])
		
		QUERY:C277([Intervention:108]; [Intervention:108]INT_Statut:15="temp"; *)
		QUERY:C277([Intervention:108];  & ; [Intervention:108]INT_Intervenant_ID:4=w_userUID)
		
		SELECTION TO ARRAY:C260([Intervention:108]ID:1; $tb_ids)
		QUERY WITH ARRAY:C644([Intervention_Lignes:109]INTL_Piece_ID:3; $tb_ids)
		
		DELETE SELECTION:C66([Intervention:108])
		DELETE SELECTION:C66([Intervention_Lignes:109])
		
		HTML_NAME_NAV_MODULE:="Liste des interventions"
		
		HTML_VIEW:=""
		BTN_LISTE:=Web_Form_Boutons("dashboard_interventions")
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_INTRV+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_delete\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa  fa-remove\"></i>"+LANG_TXT_BTN_SUPPRIMER+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_liste_interventions")
		UTL_Add_Script("gl_dashboard")
		
		Web_UTL_Add_CSS("gl_interventions")
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("form")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GL_Filtres_INTRV
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		ARRAY TEXT:C222($tb_headers_th; 0)
		
		APPEND TO ARRAY:C911($tb_headers_th; " ")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom immeuble")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom logement")
		APPEND TO ARRAY:C911($tb_headers_th; "Type intervention")
		APPEND TO ARRAY:C911($tb_headers_th; "Nom intervenant")
		APPEND TO ARRAY:C911($tb_headers_th; "Date début")
		APPEND TO ARRAY:C911($tb_headers_th; "Date fin")
		APPEND TO ARRAY:C911($tb_headers_th; "Coût matériel TTC")
		APPEND TO ARRAY:C911($tb_headers_th; "Coût prestation TTC")
		APPEND TO ARRAY:C911($tb_headers_th; "Coût total TTC")
		APPEND TO ARRAY:C911($tb_headers_th; "Etape")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table")
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Intervention:108]ID:1; ->[Intervention:108])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="intervention")
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		$new_record:=False:C215
		
		If ($id=0)
			READ WRITE:C146([Intervention:108])
			
			CREATE RECORD:C68([Intervention:108])
			MultiSoc_Init_Structure(->[Intervention:108])
			
			[Intervention:108]INT_Statut:15:="temp"
			[Intervention:108]INT_Intervenant_ID:4:=w_userUID
			[Intervention:108]INT_Date_debut:5:=Current date:C33(*)
			SAVE RECORD:C53([Intervention:108])
			
			$id:=[Intervention:108]ID:1
			UNLOAD RECORD:C212([Intervention:108])
			
			$new_record:=True:C214
			WEB SEND HTTP REDIRECT:C659("/GL?action=intervention&id="+String:C10($id))
			
			ABORT:C156
		End if 
		
		UTL_Add_Script("gl_fiche_intervention")
		UTL_Add_Script("basedoc")
		
		// Modifié par : Scanu Rémy (21/03/2023)
		UTL_Add_Script("iw_select2")
		
		Web_UTL_Add_CSS("form")
		Web_UTL_Add_CSS("form_list")
		Web_UTL_Add_CSS("fiche_intervention.css")
		Web_UTL_Add_CSS("basedoc")
		Web_UTL_Add_CSS("fiche_usager")
		
		// Modifié par : Scanu Rémy (21/03/2023)
		Web_UTL_Add_CSS("iw_select2")
		
		READ ONLY:C145([Intervention:108])
		
		QUERY:C277([Intervention:108]; [Intervention:108]ID:1=$id)
		MultiSoc_Filter(->[Intervention:108])
		
		//===================================================//
		// Equipements
		//===================================================//
		READ ONLY:C145([Piece_LK_Equipement:115])
		READ ONLY:C145([LesCentres:9])
		READ ONLY:C145([Pieces:106])
		READ ONLY:C145([Equipement:107])
		
		READ WRITE:C146([Intervention_Lignes:109])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Intervention:108]INT_LC_ReferenceID:16)
		MultiSoc_Filter(->[LesCentres:9])
		
		QUERY:C277([Pieces:106]; [Pieces:106]PIE_Origine_ID:3=[LesCentres:9]ID:60)
		MultiSoc_Filter(->[Pieces:106])
		
		SELECTION TO ARRAY:C260([Pieces:106]ID:1; $tb_ids)
		QUERY WITH ARRAY:C644([Piece_LK_Equipement:115]PLE_Piece_ID:3; $tb_ids)
		MultiSoc_Filter(->[Piece_LK_Equipement:115])
		
		While (Not:C34(End selection:C36([Piece_LK_Equipement:115])))
			QUERY:C277([Intervention_Lignes:109]; [Intervention_Lignes:109]INTL_Piece_ID:3=[Intervention:108]ID:1; *)
			QUERY:C277([Intervention_Lignes:109];  & ; [Intervention_Lignes:109]INTL_EQU_ID:4=[Piece_LK_Equipement:115]PLE_EQU_ID:4)
			MultiSoc_Filter(->[Intervention_Lignes:109])
			
			QUERY:C277([Equipement:107]; [Equipement:107]ID:1=[Piece_LK_Equipement:115]PLE_EQU_ID:4)
			MultiSoc_Filter(->[Equipement:107])
			
			QUERY:C277([Pieces:106]; [Pieces:106]ID:1=[Piece_LK_Equipement:115]PLE_Piece_ID:3)
			MultiSoc_Filter(->[Pieces:106])
			
			If (Records in selection:C76([Intervention_Lignes:109])=0)
				CREATE RECORD:C68([Intervention_Lignes:109])
				MultiSoc_Init_Structure(->[Intervention_Lignes:109])
				
				[Intervention_Lignes:109]INTL_Piece_ID:3:=[Intervention:108]ID:1
				[Intervention_Lignes:109]INTL_EQU_ID:4:=[Piece_LK_Equipement:115]PLE_EQU_ID:4
				[Intervention_Lignes:109]INTL_Quantite:5:=[Piece_LK_Equipement:115]PLE_Quantite:5
				
				[Intervention_Lignes:109]INTL_EQU_Nom:11:=[Equipement:107]EQU_Nom:4
				[Intervention_Lignes:109]INTL_Piece_Nom:14:=[Pieces:106]PIE_Nom:4
				
				[Intervention_Lignes:109]INTL_Prix_HT:6:=[Equipement:107]EQU_Prix_Achat_HT:9
				[Intervention_Lignes:109]INTL_TVA_Taux:8:=[Equipement:107]EQU_TVA:11
				[Intervention_Lignes:109]INTL_Montant_HT:7:=[Equipement:107]EQU_Prix_Achat_HT:9*[Intervention_Lignes:109]INTL_Quantite:5
				[Intervention_Lignes:109]INTL_Montant_TVA:9:=[Intervention_Lignes:109]INTL_Montant_HT:7*([Intervention_Lignes:109]INTL_TVA_Taux:8/100)
				[Intervention_Lignes:109]INTL_Montant_TTC:10:=[Intervention_Lignes:109]INTL_Montant_HT:7+[Intervention_Lignes:109]INTL_Montant_TVA:9
				
				SAVE RECORD:C53([Intervention_Lignes:109])
			End if 
			
			NEXT RECORD:C51([Piece_LK_Equipement:115])
		End while 
		
		//===================================================//
		
		HTML_HOME:="Gestion immobilière"
		HTML_NAME_NAV:="Intervention"
		
		If ((Records in selection:C76([Intervention:108])=1) & ($new_record=False:C215))
			
			If ([Intervention:108]INT_Numero:13#"")
				LANG_TXT_FICHE:=LANG_TXT_FICHE+"Intervention N° "+String:C10([Intervention:108]INT_Numero:13)
			Else 
				LANG_TXT_FICHE:=LANG_TXT_FICHE+"Intervention"
			End if 
			
			LANG_TXT_FICHE:=LANG_TXT_FICHE+" du "+String:C10([Intervention:108]INT_Date_debut:5)
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		Else 
			HTML_NAME_NAV_MODULE:="Nouvelle intervention"
		End if 
		
		//=============================================================================//
		// Materiel
		//=============================================================================//
		BTN_LISTE:=""
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
		BTN_LISTE:=BTN_LISTE+"ÉQUIPEMENTS"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half btns_list_right\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_equipement\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_EQUIPEMENT+"</button>"
		
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Boutons("intervention_fiche_top")
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_intervention
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div  class=\"iw_piece_lignes\">"
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table_equipements\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		$html:=Web_Form_GI_Intervenant
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("intn"; ->$html; False:C215)
		
		$html:=Web_Form_GI_INT_Ligne("equipement")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("intl"; ->$html; False:C215)
		
		// Modifié par : Scanu Rémy (14/03/2023)
		$html:=outilsWebManagePopup(1)
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("4DWritePopup"; ->$html; False:C215)
		
		//=============================================================================//
		// Prestation
		//=============================================================================//
		BTN_LISTE:=""
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
		BTN_LISTE:=BTN_LISTE+"PRESTATIONS"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half btns_list_right\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_prestation\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_PRESTATION+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div  class=\"iw_piece_lignes\">"
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table_prestations\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		$html:=Web_Form_GI_INT_Ligne("prestation")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("intlp"; ->$html; False:C215)
		
		HTML_VIEW:=HTML_VIEW+"<div  class=\"iw_piece_lignes\">"
		HTML_VIEW:=HTML_VIEW+"<div id=\"intervention_pied\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		$html:=Web_Doc_Form(->[Intervention:108]ID:1; ->[Intervention:108])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="sinistres")
		HTML_NAME_NAV_MODULE:="Sinistres"
		
		BTN_LISTE:=""
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_fill\"><div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green \" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_SINISTRE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px \" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		
		If (outilsManagePrivilege(1; "Suppression_gestion_immo"; w_userUID)=True:C214)
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_delete\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa  fa-remove\"></i>"+LANG_TXT_BTN_SUPPRIMER+"</button>"
		End if 
		
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		UTL_Add_Script("gl_dashboard_sinistres")
		
		Web_UTL_Add_CSS("form")
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_locataires")
		
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=Web_Form_Recherche_Sinistres
		
		APPEND TO ARRAY:C911($tb_headers_th; "")
		APPEND TO ARRAY:C911($tb_headers_th; "Date")
		APPEND TO ARRAY:C911($tb_headers_th; "Libellé")
		APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
		APPEND TO ARRAY:C911($tb_headers_th; "Logement")
		APPEND TO ARRAY:C911($tb_headers_th; "Coût")
		APPEND TO ARRAY:C911($tb_headers_th; "Prise en charge d'assurance")
		APPEND TO ARRAY:C911($tb_headers_th; "N° du contrat")
		APPEND TO ARRAY:C911($tb_headers_th; "Mt de remboursement")
		APPEND TO ARRAY:C911($tb_headers_th; "Travaux clôturées")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "liste_table_sinistres")
		
		BTN_LISTE:=""
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		HTML_VIEW:=HTML_VIEW+Web_Form_Sinistre_Popup("gl_sinistre_bien_valider"; "sinistres_biens_list_json"; True:C214)
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Sinistres:89]ID:1; ->[Sinistres:89])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="charges")
		HTML_NAME_NAV_MODULE:="Charges"
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_fill\"><div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button  fdp_btn_top fdp-btn-green \" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_CHARGE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px \" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		UTL_Add_Script("gl_dashboard_charges")
		
		Web_UTL_Add_CSS("form")
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_locataires")
		
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=Web_Form_Recherche_Sinistres
		
		ARRAY TEXT:C222($tb_headers_th; 0)
		
		APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
		APPEND TO ARRAY:C911($tb_headers_th; "Logement")
		APPEND TO ARRAY:C911($tb_headers_th; "Type de la charge")
		APPEND TO ARRAY:C911($tb_headers_th; "Montant")
		APPEND TO ARRAY:C911($tb_headers_th; "Période")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "liste_table_charges")
		
		BTN_LISTE:=""
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		HTML_VIEW:=HTML_VIEW+Web_Form_Charge_Popup("gl_charge_bien_valider"; "charges_biens_list_json"; True:C214)
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Charges:92]ID:1; ->[Charges:92])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="gl_sinistre_bien_valider")
		Web_Save_Piece_Ligne(->[LesCentres:9]; ->[Sinistres:89]; ->[Sinistres:89]SIN_Origine_ID:12; ->[Sinistres:89]SIN_Origine_Table_No:14; "ligne"; True:C214)
	: ($action="gl_charge_bien_valider")
		Web_Save_Piece_Ligne(->[LesCentres:9]; ->[Charges:92]; ->[Charges:92]CHA_Origine_ID:6; ->[Charges:92]CHA_Origine_Table_No:8; "ligne"; False:C215)
	: ($action="gl_inventaire_pieces_valider")
		Web_Save_Piece_Ligne(->[LesCentres:9]; ->[Inventaire_Pieces:96]; ->[Inventaire_Pieces:96]INV_ID_Bien:18; ->[Inventaire_Pieces:96]INV_Origine_Table_No:20; "ligne"; False:C215)
	: ($action="gl_charge_location_valider")
		Web_Save_Piece_Ligne(->[Locations:84]; ->[Charges:92]; ->[Charges:92]CHA_Origine_ID:6; ->[Charges:92]CHA_Origine_Table_No:8; "ligne"; False:C215)
	: ($action="gl_coloc_location_valider")
		Web_Save_Table_LK(->[Locations:84]; ->[Location_LK_Colocataires:95]; ->[Location_LK_Colocataires:95]COL_LOC_ID:3; ->[Location_LK_Colocataires:95]COL_ID:2; "lk")
	: ($action="location_ligne_valider")
		Web_Save_Piece_Ligne(->[Locations:84]; ->[Base_documentaire:90]; ->[Base_documentaire:90]DOC_Origine_ID:4; ->[Base_documentaire:90]DOC_Table_No:5; "ligne"; False:C215)
	: ($action="save_document")
		Web_Save_Document(->[Base_documentaire:90]; ->[Base_documentaire:90]DOC_Origine_ID:4; "ligne"; "locations")
	: ($action="gl_bien_pieces_valider")
		Web_Save_Piece_Ligne(->[LesCentres:9]; ->[Pieces:106]; ->[Pieces:106]PIE_Origine_ID:3; ->[Pieces:106]PIE_Origine_Table_No:5; "ligne"; False:C215)
	: ($action="etl_save_signature")
		Web_Save_Document(->[Base_documentaire:90]; ->[Base_documentaire:90]DOC_Origine_ID:4; "ligne"; "etl_signatures")
	: ($action="factures")
		READ WRITE:C146([Factures:86])
		READ WRITE:C146([Factures_Lignes:87])
		
		QUERY:C277([Factures:86]; [Factures:86]FAC_Statut:16="temp"; *)
		QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Intervenant_ID:27=w_userUID)
		
		SELECTION TO ARRAY:C260([Factures:86]ID:1; $tb_fac_id)
		QUERY WITH ARRAY:C644([Factures_Lignes:87]FACL_Piece_ID:3; $tb_fac_id)
		
		DELETE SELECTION:C66([Factures:86])
		DELETE SELECTION:C66([Factures_Lignes:87])
		
		SOC_Get_Config
		$privileges_facturation:=Web_User_Check_Privilege("Privilege Facturation Web")
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		HTML_HOME:="Comptabilité"
		HTML_NAME_NAV_MODULE:="Factures"
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		If ($privileges_facturation)
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_FACTURE+"</button>"
		End if 
		
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa  fa-bars\"></i>"+LANG_TXT_BTN_AFFICHER_TOUT+"</button>"
		
		If ($privileges_facturation)
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_fac_export\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-file-excel-o\"></i>Export Factures</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_fac_auto\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-file-pdf-o\"></i>"+LANG_TXT_BTN_FAC_AUTO+"</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_fac_regler\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_brown iw_margin_left_5px\" onclick=\"return false;\" ><i class=\"fa fa-mail-forward\"></i>"+LANG_TXT_BTN_FAC_REGLER+"</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_avoir\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_yellow iw_margin_left_5px\" onclick=\"return false;\" ><i class=\"fa fa-minus-square-o\"></i>"+LANG_TXT_BTN_AVOIR+"</button>"
		End if 
		
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_email\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_grey  iw_margin_left_5px\" onclick=\"return false;\" ><i class=\"fa fa-envelope-o\"></i>"+LANG_TXT_BTN_MAIL+"</button>"
		
		If ($privileges_facturation)
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_delete\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa  fa-remove\"></i>"+LANG_TXT_BTN_SUPPRIMER+"</button>"
		End if 
		
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_liste_factures")
		UTL_Add_Script("gl_dashboard")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_factures")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Factures(->$go)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		APPEND TO ARRAY:C911($tb_headers_th; " ")
		APPEND TO ARRAY:C911($tb_headers_th; "N° de pièce")
		APPEND TO ARRAY:C911($tb_headers_th; "Date")
		APPEND TO ARRAY:C911($tb_headers_th; "Bien")
		APPEND TO ARRAY:C911($tb_headers_th; "Locataire")
		
		APPEND TO ARRAY:C911($tb_headers_th; "Montant TTC")
		APPEND TO ARRAY:C911($tb_headers_th; "Solde antérieur")
		APPEND TO ARRAY:C911($tb_headers_th; "Net à payer")
		APPEND TO ARRAY:C911($tb_headers_th; "")
		APPEND TO ARRAY:C911($tb_headers_th; "Solde dû")
		
		APPEND TO ARRAY:C911($tb_headers_th; "Échéance")
		APPEND TO ARRAY:C911($tb_headers_th; "Période")
		
		APPEND TO ARRAY:C911($tb_headers_th; "Charges")
		APPEND TO ARRAY:C911($tb_headers_th; "APL")
		APPEND TO ARRAY:C911($tb_headers_th; "Loyer")
		APPEND TO ARRAY:C911($tb_headers_th; "Dépôt de garantie")
		APPEND TO ARRAY:C911($tb_headers_th; "Date d’entrée")
		
		APPEND TO ARRAY:C911($tb_headers_th; "Type")
		APPEND TO ARRAY:C911($tb_headers_th; "Réglée")
		APPEND TO ARRAY:C911($tb_headers_th; "Exportée")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_factures_")
		HTML_VIEW:=HTML_VIEW+Web_Form_FAC_Auto_Popup
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Factures:86]ID:1; ->[Factures:86])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		WebAGL_render_view_modes(->[Factures:86]; $champ_uid)
	: ($action="facture")
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		$privileges_facturation:=Web_User_Check_Privilege("Privilege Facturation Web")
		
		web_form_back_view:=WEB_UTL_GET_PARAMS("retour")
		
		If ($id=0)
			READ WRITE:C146([Factures:86])
			
			CREATE RECORD:C68([Factures:86])
			MultiSoc_Init_Structure(->[Factures:86])
			[Factures:86]FAC_Statut:16:="temp"
			[Factures:86]FAC_Intervenant_ID:27:=w_userUID
			[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
			SAVE RECORD:C53([Factures:86])
			
			$id:=[Factures:86]ID:1
			UNLOAD RECORD:C212([Factures:86])
			
			$new_record:=True:C214
			
			WEB SEND HTTP REDIRECT:C659("/GL?action=facture&id="+String:C10($id)+"&retour="+web_form_back_view+"&newInvoice=1")
			ABORT:C156
		End if 
		
		READ ONLY:C145([Factures:86])
		READ ONLY:C145([Factures_Lignes:87])
		
		QUERY:C277([Factures:86]; [Factures:86]ID:1=$id)
		MultiSoc_Filter(->[Factures:86])
		
		HTML_HOME:="Comptabilité"
		HTML_NAME_NAV:="Factures"
		
		If (Records in selection:C76([Factures:86])=1) & ($new_record=False:C215)
			
			If ([Factures:86]FAC_Type:21="Avoir")
				
				If ([Factures:86]FAC_No_Piece:2#"")
					LANG_TXT_FICHE:=LANG_TXT_FICHE+"Facture d'avoir N° "+String:C10([Factures:86]FAC_No_Piece:2)
				Else 
					LANG_TXT_FICHE:=LANG_TXT_FICHE+"Facture d'avoir"
				End if 
				
			Else 
				If ([Factures:86]FAC_No_Piece:2#"")
					LANG_TXT_FICHE:=LANG_TXT_FICHE+"Facture N° "+String:C10([Factures:86]FAC_No_Piece:2)
				Else 
					LANG_TXT_FICHE:=LANG_TXT_FICHE+"Facture provisoire"
				End if 
			End if 
			
			LANG_TXT_FICHE:=LANG_TXT_FICHE+" du "+String:C10([Factures:86]FAC_Date_Piece:3)
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		Else 
			HTML_NAME_NAV_MODULE:="Nouvelle facture"
		End if 
		
		BTN_LISTE:=""
		
		If ($privileges_facturation)
			
			If ([Factures:86]FAC_Type:21#"Définitive")
				BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
				BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
				BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
				BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_autre\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_AUTRE_LIGNE+"</button>"
				BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>Location</button>"
				BTN_LISTE:=BTN_LISTE+"</div>"
				BTN_LISTE:=BTN_LISTE+"</div>"
				BTN_LISTE:=BTN_LISTE+"</div>"
			End if 
			
		End if 
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_fiche_facture")
		UTL_Add_Script("iw_bootbox")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("fiche_facture")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=Web_Form_Facture("entete")
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div  class=\"iw_piece_lignes\">"
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Facture("pied")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Facture_Popup("")
		HTML_VIEW:=HTML_VIEW+Web_Form_Facture_Popup("autre")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Print_Facture
		
		// Modifié par : Scanu Rémy (22/03/2023)
		$html:=outilsWebManagePopup(1)
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("4DWritePopup"; ->$html; False:C215)
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Factures:86]ID:1; ->[Factures:86])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		WebAGL_render_view_modes(->[Factures:86]; $champ_uid)
	: ($action="facturation_automatique")
		Web_Facturation_Auto
	: ($action="reglement_automatique")
		Web_Reglement_Auto
	: ($action="avoir_automatique")
		Web_Genere_Avoir
	: ($action="reglements")
		HTML_HOME:="Comptabilité"
		HTML_NAME_NAV_MODULE:="Règlements"
		
		C_BOOLEAN:C305($privileges_facturation)
		
		$privileges_facturation:=Web_User_Check_Privilege("Privilege Facturation Web")
		
		READ WRITE:C146([Reglements:93])
		QUERY:C277([Reglements:93]; [Reglements:93]REG_Statut:12="temp"; *)
		QUERY:C277([Reglements:93];  & ; [Reglements:93]REG_Intervenant_ID:13=w_userUID)
		DELETE SELECTION:C66([Reglements:93])
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\" style=\"margin-bottom: 10px;\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		If ($privileges_facturation)
			BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NV_REGLEMENT+"</button>"
		End if 
		
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_AFFICHER_TOUT+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_liste_reglements")
		UTL_Add_Script("gl_dashboard")
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Reglements
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		APPEND TO ARRAY:C911($tb_headers_th; "N° de pièce")
		APPEND TO ARRAY:C911($tb_headers_th; "Date du règlement")
		APPEND TO ARRAY:C911($tb_headers_th; "Bien")
		APPEND TO ARRAY:C911($tb_headers_th; "Locataire")
		APPEND TO ARRAY:C911($tb_headers_th; "Montant")
		APPEND TO ARRAY:C911($tb_headers_th; "Mode du règlement")
		APPEND TO ARRAY:C911($tb_headers_th; "Échéance")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_reglements_")
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Reglements:93]ID:1; ->[Reglements:93])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
		//--------------------------------------------------------------------------------------//
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="reglement")
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		
		$records_selected:=WEB_UTL_GET_PARAMS("records_selected")
		web_form_back_view:=WEB_UTL_GET_PARAMS("retour")
		
		HTML_HOME:="Comptabilité"
		UTL_Decoupe_texte(->$records_selected; ->$tab_records_selected; ";")
		outilsManageArray(1; ->$tab_records_selected; ->$id_ai)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (13/10/2021)
		QUERY WITH ARRAY:C644([Factures:86]ID:1; $id_ai)
		
		If (Records in selection:C76([Factures:86])>1)
			ORDER BY:C49([Factures:86]; [Factures:86]FAC_Annee:34; <; [Factures:86]FAC_Mois:33; <)
			
			$id_el:=[Factures:86]ID:1
		End if 
		
		For ($i; 1; Size of array:C274($tab_records_selected))
			QUERY:C277([Factures:86]; [Factures:86]ID:1=Num:C11($tab_records_selected{$i}))
			var $factures_e : cs:C1710.FacturesEntity
			$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)
			Case of 
				: ($i=1) | (($i>1) & ($montant_reglement=0))
					$id_bien:=[Factures:86]FAC_Bien_ID:28
					$id_locataire:=[Factures:86]FAC_Locataire_ID:29
					$nom_bien:=[Factures:86]FAC_Bien_Nom:30
					$nom_locataire:=[Factures:86]FAC_Locataire_Nom:31
					
					$continue_b:=True:C214
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (11/10/2021)
					If (Size of array:C274($tab_records_selected)>1)
						$continue_b:=([Factures:86]ID:1=$id_el)
					End if 
					
					If ($continue_b=True:C214)
						$montant_reglement:=$factures_e.FAC_Net_A_Payer_cal-[Factures:86]FAC_Solde_Regle:26
					End if 
					
				: ($id_bien#[Factures:86]FAC_Bien_ID:28) | ($id_locataire#[Factures:86]FAC_Locataire_ID:29)  // S'il ne n'agit pas du même locataire OU du même bien
					$error:=True:C214
			End case 
			
		End for 
		
		If ($id=0)  // On a fait un réglement partiel sur une ou plusieurs factures
			READ WRITE:C146([Reglements:93])
			
			CREATE RECORD:C68([Reglements:93])
			MultiSoc_Init_Structure(->[Reglements:93])
			
			[Reglements:93]REG_Statut:12:="temp"
			[Reglements:93]REG_Intervenant_ID:13:=w_userUID
			[Reglements:93]REG_Date_Piece:4:=Current date:C33(*)
			
			If (Size of array:C274($tab_records_selected)>0) & ($error=False:C215)
				[Reglements:93]REG_Bien_ID:24:=$id_bien
				[Reglements:93]REG_Locataire_ID:25:=$id_locataire
				[Reglements:93]REG_Bien_Nom:26:=$nom_bien
				[Reglements:93]REG_Locataire_Nom:27:=$nom_locataire
				[Reglements:93]REG_Montant:5:=$montant_reglement
				[Reglements:93]REG_Origine_IDS:21:=$records_selected
			End if 
			
			SAVE RECORD:C53([Reglements:93])
			
			$id:=[Reglements:93]ID:1
			$new_record:=True:C214
			
			UNLOAD RECORD:C212([Reglements:93])
			
			WEB SEND HTTP REDIRECT:C659("/GL?action=reglement&id="+String:C10($id)+"&retour="+web_form_back_view)
			ABORT:C156
		End if 
		
		READ ONLY:C145([Reglements:93])
		
		QUERY:C277([Reglements:93]; [Reglements:93]ID:1=$id)
		MultiSoc_Filter(->[Reglements:93])
		
		HTML_NAME_NAV:="Règlements"
		
		If (Records in selection:C76([Reglements:93])=1)
			
			If ([Reglements:93]REG_No_Piece:3#"")
				LANG_TXT_FICHE:=LANG_TXT_FICHE+"Règlement N° "+String:C10([Reglements:93]REG_No_Piece:3)
			Else 
				LANG_TXT_FICHE:=LANG_TXT_FICHE+"Règlement"
			End if 
			
			LANG_TXT_FICHE:=LANG_TXT_FICHE+" du "+String:C10([Reglements:93]REG_Date_Piece:4)
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		Else 
			HTML_NAME_NAV_MODULE:="Nouveau règlement"
		End if 
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Reglement
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="irl")
		HTML_HOME:="GESTION IMMOBILIERE"
		HTML_NAME_NAV_MODULE:="IRL : L'INDICE DE RÉFÉRENCE DES LOYERS"
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		// Modifié par : Scanu Rémy (24/05/2024)
		//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_FICHE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_liste_irl")
		UTL_Add_Script("gl_dashboard")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_IRLS(->$go)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		HTML_VIEW:=HTML_VIEW+Web_Form_IRL_Popup
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="relances")
		HTML_HOME:="Comptabilité"
		HTML_NAME_NAV_MODULE:="Relances"
		
		READ WRITE:C146([Relances:94])
		QUERY:C277([Relances:94]; [Relances:94]RLC_Statut:10="temp"; *)
		QUERY:C277([Relances:94];  & ; [Relances:94]RLC_Intervenant_ID:5=w_userUID)
		DELETE SELECTION:C66([Relances:94])
		
		HTML_VIEW:=""
		
		BTN_LISTE:=Web_Form_Boutons("dashboard")
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		// Modifié par : Scanu Rémy (24/05/2024)
		//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_FICHE+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_liste_relances")
		UTL_Add_Script("gl_dashboard")
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_factures")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Relances(->$go)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="tableau-de-bord")
	: ($action="relance")
		HTML_HOME:="Comptabilité"
		
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		web_form_back_view:=WEB_UTL_GET_PARAMS("retour")
		
		If ($id=0)
			READ WRITE:C146([Relances:94])
			
			CREATE RECORD:C68([Relances:94])
			MultiSoc_Init_Structure(->[Relances:94])
			
			[Relances:94]RLC_Statut:10:="temp"
			[Relances:94]RLC_Intervenant_ID:5:=w_userUID
			[Relances:94]RLC_Date:11:=Current date:C33(*)
			SAVE RECORD:C53([Relances:94])
			
			$id:=[Relances:94]ID:1
			UNLOAD RECORD:C212([Relances:94])
			
			$new_record:=True:C214
			WEB SEND HTTP REDIRECT:C659("/GL?action=relance&id="+String:C10($id)+"&retour="+web_form_back_view)
			ABORT:C156
		End if 
		
		READ ONLY:C145([Relances:94])
		
		QUERY:C277([Relances:94]; [Relances:94]ID:1=$id)
		MultiSoc_Filter(->[Relances:94])
		
		HTML_NAME_NAV:="Relances"
		
		If ((Records in selection:C76([Relances:94])=1) & ($new_record=False:C215))
			LANG_TXT_FICHE:="Relance"
			LANG_TXT_FICHE:=LANG_TXT_FICHE+" du "+String:C10([Relances:94]RLC_Date:11)
			HTML_NAME_NAV_MODULE:=LANG_TXT_FICHE
		Else 
			HTML_NAME_NAV_MODULE:="Nouvelle relance"
		End if 
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Relance
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="base_documentaire")
		$table_ptr:=->[Base_documentaire:90]
		$champ_uid_ptr:=->[Base_documentaire:90]ID:1
		
		HTML_VIEW:=""
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		HTML_NAME_NAV_MODULE:="Base documentaire"
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_bd_new_document\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_DOCUMENT+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_bd_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		BTN_LISTE:=""
		
		UTL_Add_Script("gl_dashboard")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_factures")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Documents(->$go)
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		//--------------------------------------------------------------------------------------//
		// Base documentaire
		//--------------------------------------------------------------------------------------//
		UTL_Add_Script("basedoc")
		Web_UTL_Add_CSS("basedoc")
		
		$html:=Web_Doc_Form(->[Base_documentaire:90]ID:1; ->[Base_documentaire:90])
		HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
		
		$html:=Web_Doc_Form_Liste("GI")
		HTML_VIEW:=HTML_VIEW+Web_Doc_Form_Liste
		//--------------------------------------------------------------------------------------//
		
		HTML_VIEW:=HTML_VIEW+Web_Form_GI_Menu
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="documents_list_ts_json")
		Web_GB_Get_Documents
	: ($action="proprietaires_list_json")
		Web_GL_Get_Proprietaires
	: ($action="documents_list_json")
		Web_Get_Lignes_Data(->[Locations:84]; ->[Base_documentaire:90]; ->[Base_documentaire:90]DOC_Origine_ID:4; ->[Base_documentaire:90]DOC_Table_No:5)
	: ($action="irl_list_json")
		Web_GL_Get_IRLS
	: ($action="locations_list_json")
		Web_GL_Get_Locations
	: ($action="biens_list_json")
		Web_GL_Get_Biens
	: ($action="factures_list_json")
		Web_GL_Get_Factures
	: ($action="factures_list_ts_json")
		Web_GL_Get_Factures_TS
	: ($action="biens_list_ts_json")
		Web_GL_Get_Biens_TS
	: ($action="locations_list_ts_json")
		Web_GL_Get_Locations_TS
	: ($action="sinistres_selection_delete")
		Web_Delete_Selection(->[Sinistres:89])
	: ($action="locations_selection_delete")
		Web_Delete_Selection(->[Locations:84])
	: ($action="proprietaires_list_ts_json")
		Web_GL_Get_Proprietaires_TS
	: ($action="equipements_list_ts_json")
		Web_GL_Get_Equipements_TS
	: ($action="equipements_b_list_ts_json")
		Web_GL_Get_Equipements_B_TS
	: ($action="stock_list_ts_json")
		Web_GL_Get_Stock_TS
	: ($action="stkm_list_ts_json")
		Web_GL_Get_Stkm_TS
	: ($action="interventions_list_ts_json")
		Web_GL_Get_Interventions_TS
	: ($action="interventions_selection_delete")
		Web_Delete_Selection(->[Intervention:108])
	: ($action="relances_list_json")
		Web_GL_Get_Relances
	: ($action="reglements_list_json")
		Web_GL_Get_Reglements
	: ($action="reglements_list_spec_json")
		Web_GL_Get_Reglements_Spec
	: ($action="colocataires_list_json")
		Web_GL_Get_Colocataires
	: ($action="apl_list_json")
		outilsWebSendData(->[Locations:84]; ->[Locations:84]ID:1; "locationsapls")
	: ($action="budget_list_json")
		outilsWebSendData(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; ->[HeBerge:4]situationBudgetaire:85)
	: ($action="facture_lignes_list_json")
		Web_Get_Lignes_Data(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; ->[Factures_Lignes:87]FACL_Origine_Table_No:20)
	: ($action="sinistres_biens_list_json")
		Web_Get_Lignes_Data(->[LesCentres:9]; ->[Sinistres:89]; ->[Sinistres:89]SIN_Origine_ID:12; ->[Sinistres:89]SIN_Origine_Table_No:14)
	: ($action="sinistres_dashboard_list_json")
		Web_GL_Get_Sinistres
	: ($action="sinistres_list_json")
		Web_GL_Get_Sinistres_TS
	: ($action="charges_list_json")
		Web_GL_Get_Charges_TS
	: ($action="charges_biens_list_json")
		Web_Get_Lignes_Data(->[LesCentres:9]; ->[Charges:92]; ->[Charges:92]CHA_Origine_ID:6; ->[Charges:92]CHA_Origine_Table_No:8)
	: ($action="charges_locations_list_json")
		Web_Get_Lignes_Data(->[Locations:84]; ->[Charges:92]; ->[Charges:92]CHA_Origine_ID:6; ->[Charges:92]CHA_Origine_Table_No:8)
	: ($action="etl_list_json")
		Web_Get_Lignes_Data(->[Locations:84]; ->[Etat_des_lieux:97]; ->[Etat_des_lieux:97]ETL_ID_Location:9; ->[Etat_des_lieux:97]CHA_Origine_Table_No:11)
	: ($action="gl_bien_pieces_list_json")
		Web_Get_Lignes_Data(->[LesCentres:9]; ->[Pieces:106]; ->[Pieces:106]PIE_Origine_ID:3; ->[Pieces:106]PIE_Origine_Table_No:5)
	: ($action="gl_equ_noms_list_json")
		Web_GI_EQU_Get_Data
	: ($action="int_lignes_list_json")
		Web_Get_Lignes_Intervention(->[Intervention:108]; ->[Intervention_Lignes:109]; ->[Intervention_Lignes:109]INTL_Piece_ID:3)
	: ($action="get_sinistre")
		Web_Get_Record_Data(->[Sinistres:89]; "ligne"; ""; True:C214)
	: ($action="get_charge")
		Web_Get_Record_Data(->[Charges:92]; "ligne"; ""; True:C214)
	: ($action="get_colocataire")
		Web_Get_Record_Data(->[HeBerge:4]; "ligne"; ""; True:C214)
	: ($action="get_bien_piece")
		Web_Get_Record_Data(->[Pieces:106]; "ligne")
	: ($action="get_etl")
		Web_Get_ETL_Data(->[Etat_des_lieux:97]; "ligne")
	: ($action="get_etl_ligne")
		Web_Get_Data_ETL_Ligne(->[ETL_Lignes:101]; "ligne")
	: ($action="get_inventaire_pieces")
		Web_Get_Record_Data(->[Inventaire_Pieces:96]; "ligne"; "inv_id_bien")
	: ($action="get_reglement_data")
		Web_Get_Record_Data(->[Reglements:93]; "ligne")
	: ($action="get_destinataire_data")
		Web_Get_Destinataire_Data("ligne")
	: ($action="get_facture_ligne")
		Web_Get_Record_Data(->[Factures_Lignes:87]; "ligne")
	: ($action="facture_valider")
		Web_Save_Piece(->[Factures:86]; "facture")
	: ($action="facture_delete")
		Web_Delete_Piece(->[Factures:86]; "facture")
		
	: ($action="get_location_ligne")
		Web_Get_Record_Data(->[Base_documentaire:90]; "ligne")
	: ($action="delete_location_ligne")
		Web_Delete_Record(->[Base_documentaire:90]; "ligne"; True:C214; "locations")
	: ($action="get_intervention_ligne")
		Web_Get_Record_Data(->[Intervention_Lignes:109]; "data")
	: ($action="intervention_valider")
		Web_Save_Piece(->[Intervention:108]; "data")
	: ($action="reglement_delete")
		Web_Delete_Piece(->[Reglements:93]; "reglement")
	: ($action="factures_selection_delete")
		Web_Delete_Selection(->[Factures:86])
	: ($action="equipements_selection_delete")
		// Modifié par : Scanu Rémy (11/08/2021) et re-modifié par : Scanu Rémy (02/08/2022)
		//Web_Delete_Selection(->[Piece_LK_Equipement])
		$data_o:=Web_AGL_Get_Post_Json_Data
		$collection_c:=Split string:C1554($data_o.ids; ";")
		
		$table_o:=ds:C1482.EquipementBien.query("UUID in :1"; $collection_c)
		$retour_o:=$table_o.drop()
		
		$reponse_t:=Choose:C955($retour_o.length=0; "Vrai"; "Failed")
		WEB SEND TEXT:C677($reponse_t)
	: ($action="pieces_selection_delete")
		// Modifié par : Scanu Rémy (25/03/2022)
		Web_Delete_Selection(->[Pieces:106])
	: ($action="reglement_valider")
		Web_Save_Piece(->[Reglements:93]; "reglement")
	: ($action="relance_valider")
		Web_Save_Piece(->[Relances:94]; "relance")
	: ($action="intervention_ligne_valider")
		Web_Save_Piece_Ligne(->[Intervention:108]; ->[Intervention_Lignes:109]; ->[Intervention_Lignes:109]INTL_Piece_ID:3; $param_1; "data"; False:C215)
	: ($action="stock_ligne_valider")
		Web_Save_Stock
	: ($action="facture_ligne_valider")
		Web_Save_Piece_Ligne(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; ->[Factures_Lignes:87]FACL_Origine_Table_No:20; "ligne"; False:C215)
	: ($action="facture_calcul_pied")
		Web_Piece_Calcul_Pied(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
	: ($action="intervention_calcul_pied")
		Web_Piece_Calcul_Pied(->[Intervention:108]; ->[Intervention_Lignes:109]; ->[Intervention_Lignes:109]INTL_Piece_ID:3; "intervention")
	: ($action="gl_etl_valider")
		Web_Save_ETL
	: ($action="get_proprietaire")
		Web_Get_Record_Data(->[Proprietaires:83]; "proprietaire")
	: ($action="get_irl")
		Web_Get_Record_Data(->[IRL_CONFIG:85]; "irl")
	: ($action="get_address")
		Web_Get_Ligne_Data(->[Adresses:53]; ->[Adresses:53]AD_ID_Origine:34; ->[Adresses:53]AD_ID_Table_Origine:35; ->[Proprietaires:83]; "address")
	: ($action="pro_get_info_bancaires")
		Web_Get_Ligne_Data(->[Banques:91]; ->[Banques:91]BQE_Origine_ID:17; ->[Banques:91]BQE_Origine_No_Table:18; ->[Proprietaires:83]; "coordonnees_bancaires")
	: ($action="locataire_get_info_bancaires")
		Web_Get_Ligne_Data(->[Banques:91]; ->[Banques:91]BQE_Origine_ID:17; ->[Banques:91]BQE_Origine_No_Table:18; ->[HeBerge:4]; "coordonnees_bancaires")
	: ($action="get_address_sinistre")
		Web_Get_Ligne_Data(->[Adresses:53]; ->[Adresses:53]AD_ID_Origine:34; ->[Adresses:53]AD_ID_Table_Origine:35; ->[LesCentres:9]; "address")
	: ($action="get_address_usager")
		Web_Get_Ligne_Data(->[Adresses:53]; ->[Adresses:53]AD_ID_Origine:34; ->[Adresses:53]AD_ID_Table_Origine:35; ->[HeBerge:4]; "address")
	: ($action="get_location")
		Web_Get_Location_Data(->[Locations:84]; "location")
	: ($action="get_intervenants")
		Web_GI_Get_Intervenants
	: ($action="irl_recalculer")
		Web_Location_Calcul_MT_Revise
	: ($action="get_adresse_facturation")
		Web_Get_Address_Facturation(->[Adresses:53]; ->[Adresses:53]AD_ID_Origine:34; ->[Adresses:53]AD_ID_Table_Origine:35; "address")
	: ($action="genere_fac_lignes")
		Web_FAC_Genere_Lignes
	: ($action="print_facture")
		// Grég le 02/12/24, je pense que ce n'est plus utilisé...
		TRACE:C157
/*
$id:=Num(WEB_UTL_GET_PARAMS("id"))
		
LECTURE SEULEMENT([Factures])
LECTURE SEULEMENT([Factures_Lignes])
		
CHERCHER([Factures]; [Factures]ID=$id)
CHERCHER([Factures_Lignes]; [Factures_Lignes]FACL_Piece_ID=[Factures]ID)
		
GES_GL_Imp_Maj_Variables
SOC_Get_Config
		
RÉDUIRE SÉLECTION([Factures_Lignes]; 0)
		
Si ([Factures]FAC_Type_Piece="charge")
CHERCHER([Factures_Lignes]; [Factures_Lignes]FACL_Piece_ID=[Factures]ID)
MultiSoc_Filter(->[Factures_Lignes])
		
AGL_Fiche_Print(->[Factures]; "print_charges"; ->[Factures_Lignes]; Vrai)
Sinon 
AGL_Fiche_Print(->[Factures]; "print"; ->[Factures_Lignes]; Vrai)
Fin de si 
*/
	: ($action="fac_envoi_mail")
		
		Web_FAC_Envoi_Mail
	: ($action="set_bien")
		Web_Save_Record(->[LesCentres:9]; "bien")
	: ($action="set_immeuble")
		Web_Save_Record(->[Immeuble:105]; "ligne")
	: ($action="set_intervenant")
		Web_Save_Record(->[GI_Intervenants:110]; "data")
	: ($action="get_immeubles")
		Web_Get_Records(->[Immeuble:105]; ->[Immeuble:105]ID:1; ->[Immeuble:105]IMM_Nom:3; ->[LesCentres:9]; ->[LesCentres:9]LC_Immeuble_ID:84; ->[LesCentres:9]ID:60)
	: ($action="get_immeuble")
		Web_Get_Record_Data(->[Immeuble:105]; "ligne")
	: ($action="gl_remove_immeuble")
		Web_Delete_Record(->[Immeuble:105]; "ligne"; False:C215; "")
	: ($action="set_equipement")
		Web_Save_Record(->[Equipement:107]; "data")
	: ($action="get_equipement")
		Web_Get_Record_Data(->[Equipement:107]; "data"; ""; True:C214)
	: ($action="gl_remove_equipement") | ($action="gl_remove_prestation")
		Web_Delete_Record(->[Intervention_Lignes:109]; "data"; False:C215; "")
	: ($action="get_equipement_lk_piece")
		Web_Get_Record_Data(->[EquipementBien:125]; "data"; "UUID"; True:C214)
	: ($action="gl_remove_equipement")
		Web_Delete_Record(->[Equipement:107]; "data"; False:C215; "")
	: ($action="gl_remove_charge")
		Web_Delete_Record(->[Charges:92]; "data"; False:C215; "")
	: ($action="gl_remove_facture_ligne")
		Web_Delete_Record(->[Factures_Lignes:87]; "data"; False:C215; "")
	: ($action="gl_remove_colocataire")
		Web_Delete_Record(->[Locations:84]; "data"; False:C215; ""; ->[Location_LK_Colocataires:95]; ->[Location_LK_Colocataires:95]COL_LOC_ID:3)
	: ($action="set_intervention")
		Web_Save_Record(->[Intervention:108]; "data")
	: ($action="get_intervention")
		Web_Get_Record_Data(->[Intervention:108]; "data")
	: ($action="gl_remove_intervention")
		Web_Delete_Record(->[Intervention:108]; "data"; False:C215; "")
	: ($action="get_stock_mouvement")
		Web_Get_Record_Data(->[Stock_Mouvements:114]; "data"; ""; True:C214)
	: ($action="gl_pieces_equ_list_json")
		Web_GI_Get_Piece_EQU
	: ($action="set_pieces_lk_equ")
		//Web_GI_Save_PEQU
		$data_o:=Web_AGL_Get_Post_Json_Data
		$data_o:=OB Get:C1224($data_o; "data"; Est un objet:K8:27)
		
		outilsManageEquipement(20; $data_o; ->$reponse_t)
		WEB SEND TEXT:C677($reponse_t)
	: ($action="get_piece_equipement")
		Web_GI_Get_Piece_EQU
	: ($action="basedoc_list_ts_json")
		Web_Get_BaseDoc_TS
	: ($action="basedoc_ligne_valider")
		$table_num:=Num:C11(WEB_URL_GET_PARAM($_content{2}; "table_num"))
		$table_ptr:=Table:C252($table_num)
		
		Web_Save_Piece_Ligne($table_ptr; ->[Base_documentaire:90]; ->[Base_documentaire:90]DOC_Origine_ID:4; ->[Base_documentaire:90]DOC_Table_No:5; "ligne"; False:C215)
	: ($action="basedoc_save_document")
		Web_Save_Document(->[Base_documentaire:90]; ->[Base_documentaire:90]DOC_Origine_ID:4; "ligne"; ""; ->$_content{2})
	: ($action="basedoc_delete_document")
		$folder:=WEB_URL_GET_PARAM($_content{2}; "table_name")
		
		Web_Delete_Record(->[Base_documentaire:90]; "ligne"; True:C214; $folder)
	: ($action="basedoc_get_record")
		Web_Get_Record_Data(->[Base_documentaire:90]; "ligne")
	: ($action="changeProprietaire")
		$enregistrement_o:=ds:C1482.LesCentres.get(Num:C11(w_visiteur.bienID))
		
		If ($enregistrement_o#Null:C1517)
			$enregistrement_o.LC_GL_Proprietaire_ID:=Num:C11(w_visiteur.id)
			$retour_o:=$enregistrement_o.save()
		End if 
		
		WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))
	: ($action="ajoutKit")
		$enregistrement_o:=ds:C1482.LesCentres.get(Num:C11(w_visiteur.bienID))
		
		If ($enregistrement_o#Null:C1517)
			outilsManageEquipement(1; w_visiteur.kit)
		End if 
		
		WEB SEND TEXT:C677("Vrai")
End case 