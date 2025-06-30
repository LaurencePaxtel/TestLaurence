//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:04:44
// ----------------------------------------------------
// Méthode : Web_Controller_Usager
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($action; $saction; $staction; $filtre; $user_type; $UIDP; $UIDT; $sform; $html)
C_LONGINT:C283($id; $hg_hb_id; $cle)
C_BOOLEAN:C305($go)
C_POINTER:C301($table_ptr; $champ_uid; $champ_uid_ptr)

ARRAY INTEGER:C220($rI_Type; 0)

C_TEXT:C284(MESSAGE_INFO; MESSAGE_ETAT; class_invalid_password; class_invalid_email; class_invalid_first_name; class_invalid_last_name; class_invalid_communication; class_invalid_email; class_invalid_lien_famille)

ARRAY TEXT:C222($_field; 0)
ARRAY TEXT:C222($tb_headers_th; 0)

ARRAY TEXT:C222(TB_SLISTE; 0)
ARRAY TEXT:C222(TB_METHODE_REFRESH; 1)

$table_ptr:=->[HeBerge:4]
$champ_uid:=->[HeBerge:4]ID:65

READ WRITE:C146($table_ptr->)

//--------------params-----------------
WEB GET HTTP HEADER:C697($_field; $_content)

HTML_NAME_MODULE:=LANG_TXT_PROFILE
NOM_PREF_RECHERCHE:="Profile"

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

BTN_MAIL:=True:C214

FIX_PARAM_BTNS:=""
BTN_LISTE:=""
CHERCHER_TRANSACTION:=False:C215
FIX_PARAM_BTNS_LN:=""
FIX_PARAM_BTNS_LND:=""

HTML_NAME_MODULE:=LANG_TXT_USAGER_ACCUEIL
HTML_HOME:=LANG_TXT_USAGER_ACCUEIL
HTML_NAME_NAV:=LANG_TXT_LISTE
HTML_NAME_NAV_MODULE:=LANG_TXT_USAGER_RECHERCHE

vDate:=Current date:C33
vHour:=Current time:C178

UNLOAD RECORD:C212($table_ptr->)

class_invalid_password:=""
class_invalid_email:=""
class_invalid_first_name:=""
class_invalid_last_name:=""
class_invalid_communication:=""
class_invalid_email:=""
class_invalid_lien_famille:=""

// Modifié par : Scanu Rémy (08/06/2022)
// Modernisation du code, il était temps...
If ($action="usager-list") | ($action="usager-fiche") | ($action="tableau-de-bord") | ($action="situation-financiere-usagers") | ($action="centres")
	
/*
$pageWeb_es:=ds.PAGEWEB.query("url = :1 AND action = :2"; w_visiteur.url; $action)
w_visiteur.pageWebExist:=($pageWeb_es.length=1)
	
Si (w_visiteur.pageWebExist=Vrai)
// ToDo
Fin de si 
*/
	
End if 

Case of 
	: ($action="situation-budgetaire")
		WEB SEND FILE:C619(Folder:C1567(fk dossier racine web:K87:15).file("situation-budgetaire/browser/index.html").platformPath)
	: ($action="transmission")
		WEB SEND FILE:C619(Folder:C1567(fk dossier racine web:K87:15).file("transmission/browser/index.html").platformPath)
	: ($action="usager-list")
		$table_ptr:=->[HeBerge:4]
		$champ_uid_ptr:=->[HeBerge:4]HB_ReferenceID:1
		
		If ($method#"POST")
			UNLOAD RECORD:C212([HeBerge:4])
			UNLOAD RECORD:C212([HeberGement:5])
			
			BTN_LISTE:=""
			
			BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\" style=\"width: 100%;\"><div class=\"buttons\">"
			BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-add\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_CLE+"</button>"
			
			// Modifié par : Scanu Rémy (21/06/2024)
			// Ajout bouton "Inconnu"
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-inconnu\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-blue iw_margin_left_5px\" onclick=\"return false;\">Inconnu</button>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			
			UTL_Add_Script("int_usager_table")
			
			Web_UTL_Add_CSS("recherche_usager")
			Web_UTL_Add_CSS("fiche_usager")
			Web_UTL_Add_CSS("form_list")
			
			HTML_VIEW:=Web_Form_Hebergements_Recherche(->class_invalid_email)
			
			Web_Form_Usager_Boutons(->HTML_VIEW)
			
			HTML_VIEW:=HTML_VIEW+"<div id=\"int-usager-table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
			HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"</div>"
			
			HTML_VIEW:=HTML_VIEW+"<div id=\"int-usager-result\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
			HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"</div>"
			
			HTML_VIEW:=HTML_VIEW+Web_Form_Notes
			HTML_VIEW:=HTML_VIEW+Web_Form_SP
			
			BTN_LISTE:=""
			
			$html:=Web_Form_Multi_Pointage
			HTML_VIEW:=HTML_VIEW+Web_Form_Popup("hg"; ->$html; True:C214)
			
			//--------------------------------------------------------------------------------------//
			// Base documentaire
			//--------------------------------------------------------------------------------------//
			BTN_LISTE:=""
			
			UTL_Add_Script("basedoc")
			Web_UTL_Add_CSS("basedoc")
			
			$html:=Web_Doc_Form($champ_uid_ptr; $table_ptr)
			HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoc"; ->$html; False:C215)
			
			$html:=Web_Doc_Form_Liste
			HTML_VIEW:=HTML_VIEW+Web_Form_Popup("basedoclist"; ->$html; False:C215)
			//--------------------------------------------------------------------------------------//
		End if 
		
		// Modifié par : Scanu Rémy (17/05/2023)
		// Ajout du script pour éditer une cellule dans un tableau HTML
		UTL_Add_Script("iw_tableCellEditor")
		UTL_Add_Script("iw_bootbox")
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="usager-fiche")
		C_TEXT:C284(fiche_type_action)
		
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		$hg_hb_id:=Num:C11(WEB_UTL_GET_PARAMS("hb_id"))
		
		fiche_type_action:="update"
		
		READ ONLY:C145([HeberGement:5])
		READ ONLY:C145([HeBerge:4])
		
		If ($id#-1)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$hg_hb_id; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]ID:168=$id)
			MultiSoc_Filter(->[HeberGement:5])
			
			RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
			MultiSoc_Filter(->[HeBerge:4])
		Else 
			// Nouvelle fiche
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$hg_hb_id)
			MultiSoc_Filter(->[HeBerge:4])
			
			fiche_type_action:="new"
			
			$fiche_type:=WEB_UTL_GET_PARAMS("type")
			
			
			If ($fiche_type="prestation")
				$fiche_type:="N"
			Else 
				$fiche_type:="J"
			End if 
			
			Web_HB_Fiche_Init($fiche_type)
			
			w_visiteur.userCreateDate:=(Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "dateFiche").length=1)
		End if 
		
		LANG_TXT_USAGER_FICHE:=LANG_TXT_USAGER_FICHE+" N° "+String:C10([HeberGement:5]HG_FicheNuméro:3)
		LANG_TXT_USAGER_FICHE:=LANG_TXT_USAGER_FICHE+" Du "+String:C10([HeberGement:5]HG_Date:4)
		LANG_TXT_USAGER_FICHE:=LANG_TXT_USAGER_FICHE+" à <span id=\"heureFiche\">"+String:C10([HeberGement:5]HG_HeureAppel:5)+"</span>"
		LANG_TXT_USAGER_FICHE:=LANG_TXT_USAGER_FICHE+"<span class=\"g-ml-10\"><i id=\"buttonChangerDateHeureFiche\" class=\"fa fa-edit cursor-pointeur\" style=\"cursor: pointer;\"></i></span>"
		
		
		w_visiteur.modifDateFiche:=(Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "modif_date_fiche").length=1)
		
		w_visiteur.infoPage:="<p>Date de premier contact "+String:C10([HeberGement:5]HG_DatePremierContact:178)+"</p>"
		
		HTML_HOME_TXT_RIGHT:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" <i class=\"fa fa-user\" ></i>"
		HTML_HOME_TXT_LINE2_RIGHT:="Né le "+String:C10([HeberGement:5]HG_DateNéLe:24)+" ("+String:C10(UTL_Get_Date_Naissance([HeberGement:5]HG_DateNéLe:24))+" ans)"
		
		// Modifié par : Scanu Rémy (11/02/2024)
		HTML_HOME_TXT_LINE3_RIGHT:="<span id=\"hebergePhoneEdit\" contenteditable=\"true\">"+String:C10(Num:C11([HeBerge:4]HB_Telephone:66); "00 00 00 00 00")+"</span>"
		
		HTML_HOME:=LANG_TXT_INTERNE
		HTML_NAME_NAV:=LANG_TXT_USAGER
		HTML_NAME_NAV_MODULE:=LANG_TXT_USAGER_FICHE
		
		UTL_Add_Script("iw_bootbox")
		UTL_Add_Script("int_usager_fiche")
		
		HTML_VIEW:=Web_Form_Usager_Fiche
		
		Web_Form_Usager_Boutons(->HTML_VIEW)
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="usager_fiche_valider")
		Web_Int_Set_Hebergement_Cle
	: ($action="usager_fiche_add")
		Web_Int_Set_Heberge("add")
	: ($action="usager_notes_valider")
		Web_Int_Set_Heberge("notes")
	: ($action="usager_coordonnees_valider")
		Web_Int_Set_Heberge("coordonnees")
	: ($action="usager_sp_valider")
		Web_Int_Set_Heberge("sp")
	: ($action="usager_note_actions_valider")
		Web_Int_Set_Heberge("actions")
	: ($action="usager_note_af_valider")
		Web_Int_Set_Heberge("af")
	: ($action="usager_pointage")
		ASSERT:C1129(False:C215; "On ne fait pas ! (usager pointage en web)")
		//Web_Usager_Pointage
	: ($action="usager_pointage_multiple")
		Web_Usager_Pointage_Multiple
	: ($action="usager_list_json")
		$nom:=WEB_UTL_GET_PARAMS("nom")
		$prenom:=WEB_UTL_GET_PARAMS("prenom")
		
		$date_naissance:=Date:C102(WEB_UTL_GET_PARAMS("date_naissance"))
		$lien_famille:=WEB_UTL_GET_PARAMS("lien_famille")
		
		$telephone:=WEB_UTL_GET_PARAMS("telephone")
		$filtre:=WEB_UTL_GET_PARAMS("filtre")
		
		Web_Int_Get_Heberges($nom; $prenom; $date_naissance; $lien_famille; $telephone; ""; $filtre)
	: ($action="get_heberge")
		Web_Int_Get_Heberge
	: ($action="usager_list_json_rt")
		$cle:=Num:C11(WEB_UTL_GET_PARAMS("cle"))
		$filtre:=WEB_UTL_GET_PARAMS("filtre")
		
		Web_Int_Get_Heberges_Cle($cle; $filtre)
	: ($action="tableau-de-bord")
		HTML_NAME_NAV:=LANG_TXT_LISTE
		HTML_NAME_NAV_MODULE:=LANG_TXT_TABLEAU_DE_BORD
		
		If ($method="POST")
			
		Else 
			UNLOAD RECORD:C212([HeBerge:4])
			UNLOAD RECORD:C212([HeberGement:5])
			
			BTN_LISTE:=""
			BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\"><div class=\"buttons\">"
			BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
			
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-search\" type=\"submit\" class=\"fdp_Button  fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-clear\" type=\"reset\" class=\"fdp_Button  fdp_btn_top iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-times\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			
			UTL_Add_Script("int_tableau_de_bord")
			
			Web_UTL_Add_CSS("int_tableau_de_bord")
			Web_UTL_Add_CSS("general")
			
			HTML_VIEW:=Web_Form_Int_Tableau_de_Bord(->class_invalid_email)
			
			HTML_VIEW:=HTML_VIEW+"<div id=\"int-usager-table\" class=\"fdp_resp_table wrap-table100 iw-width-100 iw-alternance-only\">"
			HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"</div>"
		End if 
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="situation-financiere-usagers")
		HTML_NAME_NAV:=LANG_TXT_LISTE
		HTML_NAME_NAV_MODULE:="Situation financière des usagers"
		
		CLEAR VARIABLE:C89(HTML_VIEW)
		CLEAR VARIABLE:C89(BTN_LISTE)
		
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_AFFICHER_TOUT+"</button>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		BTN_LISTE_TOP:=BTN_LISTE
		
		CLEAR VARIABLE:C89(BTN_LISTE)
		
		UTL_Add_Script("gl_liste_situation_usagers")
		UTL_Add_Script("gl_dashboard")
		
		Web_UTL_Add_CSS("recherche_usager")
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Situation_Usagers(->$go)
		
		HTML_VIEW:=HTML_VIEW+BTN_LISTE_TOP
		
		HTML_VIEW:=HTML_VIEW+"<div id=\"list_table\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
		HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
		HTML_VIEW:=HTML_VIEW+"</div>"
		HTML_VIEW:=HTML_VIEW+"</div>"
		
		APPEND TO ARRAY:C911($tb_headers_th; "Nom hébergé")
		APPEND TO ARRAY:C911($tb_headers_th; "Prénom hébergé")
		APPEND TO ARRAY:C911($tb_headers_th; "Date de naissance hébergé")
		APPEND TO ARRAY:C911($tb_headers_th; "Date facture")
		APPEND TO ARRAY:C911($tb_headers_th; "N° facture")
		APPEND TO ARRAY:C911($tb_headers_th; "Règlement reçus")
		APPEND TO ARRAY:C911($tb_headers_th; "Net à payer")
		APPEND TO ARRAY:C911($tb_headers_th; "Solde restant")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_situation_usagers")
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="centres")
		HTML_NAME_NAV:=LANG_TXT_LISTE
		HTML_NAME_NAV_MODULE:=LANG_TXT_DISPONIBILITE_CENTRES
		
		If ($method#"POST")
			BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\"><div class=\"buttons\">"
			BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-search\" type=\"submit\" class=\"fdp_Button  fdp_btn_top\" onclick=\"document.getElementById('method').value='POST';return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"fdp-usager-clear\" type=\"reset\" class=\"fdp_Button  fdp_btn_top iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-times\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			
			UTL_Add_Script("int_centres")
			
			HTML_VIEW:=Web_Form_Int_Centres(->class_invalid_email)
			
			HTML_VIEW:=HTML_VIEW+"<div id=\"int-usager-table\" class=\"fdp_resp_table wrap-table100 iw-width-100 iw-bordered\">"
			HTML_VIEW:=HTML_VIEW+"<div class=\"iw-header\">"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"<div class=\"table\">"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"<form action=\"#\" name=\"print\" id=\"print\" method=\"POST\" onsubmit=\"return false;\" enctype=\"multipart/form-data\">"
			HTML_VIEW:=HTML_VIEW+"<div class=\"span6 fdp_boutons\"><div class=\"buttons\">"
			HTML_VIEW:=HTML_VIEW+"<div class=\"btn-wrapper\">"
			HTML_VIEW:=HTML_VIEW+"<button id=\"fdp-usager-print\"   type=\"reset\" class=\"fdp_Button  fdp_btn_top fdp_btn_black\" style=\"display: none;\"><i class=\"fa fa-print\"></i>Imprimer</button>"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"</div>"
			HTML_VIEW:=HTML_VIEW+"</form>"
		End if 
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="get_json_autres_criteres")
		Web_JSON_Autres_Criteres
	: ($action="int_tableau_bord_json")
		Web_Int_Get_Tableau_Bord
	: ($action="get_json_centres")
		//Todo: GF - A revoir...
		//Web_JSON_Get_Centres
	: ($action="get_json_centres_list")
		Web_JSON_Get_Centres_List
	: ($action="get_json_situation_usagers_list")
		Web_JSON_Get_Liste_Sit_Usagers
	: ($action="get_json_hg_coordinateur")
		APPEND TO ARRAY:C911($rI_Type; 2)
		Web_JSON_Get_Liste_Utilisateurs(->$rI_Type)
	: ($action="get_json_hg_regulateur")
		APPEND TO ARRAY:C911($rI_Type; 3)
		Web_JSON_Get_Liste_Utilisateurs(->$rI_Type)
	: ($action="get_json_hg_permanencier")
		APPEND TO ARRAY:C911($rI_Type; 4)
		Web_JSON_Get_Liste_Utilisateurs(->$rI_Type)
	: ($action="get_json_hg_maraude1_1")
		Web_JSON_Get_Liste_Maraude("1_1")
	: ($action="get_json_hg_maraude2_1")
		Web_JSON_Get_Liste_Maraude("2_1")
	: ($action="get_json_hg_maraude3_1")
		Web_JSON_Get_Liste_Maraude("3_1")
	: ($action="get_json_hg_maraude1_2")
		Web_JSON_Get_Liste_Maraude("1_2")
	: ($action="get_json_hg_maraude2_2")
		Web_JSON_Get_Liste_Maraude("2_2")
		
	: ($action="get_json_hg_famgroupe")
		Web_JSON_Get_Enumeration("FM Groupe"; "Service"; True:C214)
	: ($action="get_json_hg_signalement")
		Web_JSON_Get_Enumeration("Signalement"; "Signalement")
	: ($action="get_json_hg_codepostal")
		Web_JSON_Get_Enumeration("Code postal"; "Code postal")
	: ($action="get_json_hg_gare")
		Web_JSON_Get_Enumeration("Gares"; "Gare")
	: ($action="get_json_hg_emplacement")
		Web_JSON_Get_Enumeration("Emplacement"; "Emplacement")
	: ($action="get_json_hg_assistsocial")
		APPEND TO ARRAY:C911($rI_Type; 8)
		Web_JSON_Get_Liste_Utilisateurs(->$rI_Type)
	: ($action="get_json_hg_metro")
		Web_JSON_Get_Enumeration("Metro"; "Métro")
	: ($action="get_json_hg_famcasspec")
		Web_JSON_Get_Enumeration("FM Cas spécifique"; "Fam Cas spécifique")
	: ($action="get_json_hg_nationalite")
		Web_JSON_Get_Enumeration("Nationalité"; "Nationalité")
	: ($action="get_json_hg_situfamille")
		Web_JSON_Get_Enumeration("Situation de famille"; "Situation de famille")
	: ($action="get_json_hg_tempserrance")
		Web_JSON_Get_Enumeration("Temps d'Errance"; "Temps d'Errance")
	: ($action="get_json_hg_situprofess")
		Web_JSON_Get_Enumeration("Situation professionnelle"; "Situation professionnelle")
	: ($action="get_json_hg_piecesidte@")
		Web_JSON_Get_Enumeration("Pièces d'identité"; "Pièce d'identité")
	: ($action="get_json_hg_rupmajeur1")
		Web_JSON_Get_Enumeration("Ruptures majeures"; "Rupture majeure 2")
	: ($action="get_json_hg_rupmajeur2")
		Web_JSON_Get_Enumeration("Ruptures majeures 2"; "Rupture majeure 2")
	: ($action="get_json_hg_rupmajeur3")
		Web_JSON_Get_Enumeration("Ruptures majeures 3"; "Rupture majeure 3")
	: ($action="get_json_hg_ressources1")
		Web_JSON_Get_Enumeration("Ressources actuelles"; "Ressources actuelles")
	: ($action="get_json_hg_ressources2")
		Web_JSON_Get_Enumeration("Ressources actuelles 2"; "Ressources actuelles 2")
	: ($action="get_json_hg_ressources3")
		Web_JSON_Get_Enumeration("Ressources actuelles 3"; "Ressources actuelles 3")
	: ($action="get_json_hg_suivisocial1")
		Web_JSON_Get_Enumeration("Suivi social"; "Suivi social")
	: ($action="get_json_hg_suivisocial2")
		Web_JSON_Get_Enumeration("Suivi social 2"; "Suivi social 2")
	: ($action="get_json_hg_suivisocial3")
		Web_JSON_Get_Enumeration("Suivi social 3"; "Suivi social 3")
	: ($action="get_json_hg_couvsocial1")
		Web_JSON_Get_Enumeration("Couverture sociale"; "Couverture sociale")
	: ($action="get_json_hg_couvsocial2")
		Web_JSON_Get_Enumeration("Couverture sociale 2"; "Couverture sociale 2")
	: ($action="get_json_hg_couvsocial3")
		Web_JSON_Get_Enumeration("Couverture sociale 3"; "Couverture sociale 3")
	: ($action="get_json_hg_etatcivil@")
		Web_JSON_Get_Enumeration("Etat Civil"; "Etat civil")
	: ($action="get_json_hg_niveauetude@")
		Web_JSON_Get_Enumeration("Niveau d'étude"; "Niveau d'étude")
	: ($action="get_json_hg_centrenom@")
		Web_JSON_Get_Centres_List("radio"; New object:C1471("plateformeMulti"; True:C214))
	: ($action="get_json_hg_plateforme")
		Web_JSON_Get_Enumeration("Liste des plateformes"; "Plateforme"; True:C214)
	: ($action="get_json_hg_orientation1")
		Web_JSON_Get_Enumeration("Orientation 1"; "Orientation 1")
	: ($action="get_json_hg_orientation1suite")
		Web_JSON_Get_Enumeration("Orientation 1 suite"; "Orientation1Suite")
	: ($action="get_json_hg_orientation2")
		Web_JSON_Get_Enumeration("Orientation2"; "Orientation 2")  // Bizare... GF
	: ($action="get_json_hg_orientation@")
		Web_JSON_Get_Enumeration("DS Orientation sociale"; "Orientation")
	: ($action="get_json_hg_autresolutio")
		Web_JSON_Get_Enumeration("Autre solution"; "Autre solution")
	: ($action="get_json_hg_autresolsuite")
		Web_JSON_Get_Enumeration("Autre solution suite"; "HG_AutreSolSuite")
	: ($action="get_json_hg_famdistri@")
		Web_JSON_Get_Enumeration("FM Distri1"; "")
	: ($action="get_json_usagers_list")
		Web_JSON_Get_Liste_Usagers
	: ($action="get_json_eve_groupe_hg")  //planning
		Web_JSON_Get_Enumeration("FM Groupe"; "Groupe")
	: ($action="get_json_eve_centre_hg")  //planning 
		Web_JSON_Get_Centres_List("checkbox"; True:C214; va_UserPlateforme; "Prestations")
	: ($action="get_json_mp_groupe_hg")  //multi-pointage 
		Web_JSON_Get_Enumeration("FM Groupe"; "Groupe"; True:C214)
	: ($action="get_json_mp_centre_hg")  //multi-pointage 
		Web_JSON_Get_Centres_List("checkbox"; New object:C1471("titrePopup"; "Prestations"; "prestation"; True:C214; "plateforme"; va_UserPlateforme))
	: ($action="get_json_hg_lien")
		Web_JSON_Get_Enumeration("Liens"; "Lien")
	: ($action="get_json_hg_dernieremploi")
		Web_JSON_Get_Enumeration("Dernier emploi"; "Dernier emploi")
	: ($action="get_json_hg_dernierheber")
		Web_JSON_Get_Enumeration("Dernier hébergement"; "Dernier hébergement")
	: ($action="get_json_hg_duresanemploi")
		Web_JSON_Get_Enumeration("DUREE SANS EMPLOI"; "Durée sans emploi")
	: ($action="get_json_pla_service")
		Web_JSON_Get_Enumeration("FM Groupe"; "Groupe")
		
	: ($action="HeberGement_statistiqueGenerer")
		WEB SEND FILE:C619(Folder:C1567(fk dossier racine web:K87:15).file("statistique/browser/index.html").platformPath)
/*
$statParam_o:={}
$statParam_o.affichageNom:="état civil"  // Nom personnalisé statistique
$statParam_o.filtreRecherche:={}
$statParam_o.filtreRecherche.HG_DateMin:=!01/09/2024!
$statParam_o.filtreRecherche.HG_DateMax:=!02/10/2024!
$statParam_o.filtreRecherche.HG_Cloturée:=Vrai
$statParam_o.filtreRecherche.HG_Nuit:=Faux
$statParam_o.filtreRecherche.HG_EtatCivil:=["Enfants F avec parents (FP)"; "Enfants M avec parents (HP)"]  // Item de l'énumération en propriété
$statParam_o.dataRetour:=["HG_Date"; "HG_Nom"; "HG_Prénom"; "HG_DateNéLe"; "HG_FamClé"; "HG_EtatCivil"; "HG_FamGroupe"]  // (nom du champ 4D)
$statParam_o.typeGraph:="Bar"
		
$statParam_o.statistiqueComptage:="personne"  // Obligatoire : fiche ou personne
$statParam_o.statistiqueType:="HG_FamGroupe"  // Obligatoire (nom du champ 4D)
$statParam_o.statistiqueFicheUnique:=Vrai
		
$query_t:=JSON Stringify($statParam_o)
*/
		
		$return_o:=ds:C1482.HeberGement.statistiqueGenerer(JSON Parse:C1218(WEB_UTL_GET_PARAMS("query")))
		WEB SEND TEXT:C677(JSON Stringify:C1217($return_o))
		
End case 