//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24/03/20, 08:27:07
// ----------------------------------------------------
// Method: Web_USR_Controller
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($action; $html)
C_BOOLEAN:C305($privileges_settings)
C_POINTER:C301($table_ptr; $champ_uid)

C_TEXT:C284(MESSAGE_INFO; MESSAGE_ETAT)

ARRAY TEXT:C222($_field; 0)
ARRAY TEXT:C222($tb_headers_th; 0)

ARRAY TEXT:C222(TB_SLISTE; 0)
ARRAY TEXT:C222(TB_METHODE_REFRESH; 1)

$table_ptr:=->[HeBerge:4]
$champ_uid:=->[HeBerge:4]ID:65

WEB GET HTTP HEADER:C697($_field; $_content)

HTML_NAME_MODULE:=LANG_TXT_PROFILE
NOM_PREF_RECHERCHE:="Profile"

$method:=$_content{1}

$method:=WEB_UTL_GET_PARAMS("method")
$action:=WEB_UTL_GET_PARAMS("action")

BTN_MAIL:=True:C214

FIX_PARAM_BTNS:=""
BTN_LISTE:=""
CHERCHER_TRANSACTION:=False:C215
FIX_PARAM_BTNS_LN:=""
FIX_PARAM_BTNS_LND:=""

HTML_NAME_MODULE:=LANG_TXT_PLANNING
HTML_HOME:=LANG_TXT_PLANNING

Case of 
	: ($action="planning")
		
		If ([SOciete:18]SO_Planning_Web_Activer:114)
			HTML_NAME_NAV:=""
			HTML_NAME_NAV_MODULE:=""
			
			UTL_Add_Script("calendar")
			Web_UTL_Add_CSS("calendar")
			
			UTL_Add_Script("planning")
			UTL_Add_Script("iw_popups")
			UTL_Add_Script("iw_print")
			
			// Modifié par : Scanu Rémy (12/09/2022)
			Web_UTL_Add_CSS("iw_select2")
			UTL_Add_Script("iw_select2")
			UTL_Add_Script("iw_bootbox")
			
			$privileges_settings:=Web_User_Check_Privilege("Privileges planning Web")
			
			BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_100 pla_calendar_top_btns\">"
			BTN_LISTE:=BTN_LISTE+"<div class=\"iw_btns_top\">"
			
			BTN_LISTE:=BTN_LISTE+"<div class=\"iw_btns_top_left\">"
			BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_create\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_planning iw_margin_right_3px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_CREATE+"</button>"
			
			If ($privileges_settings)
				BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_privileges\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_planning iw_margin_right_3px\" onclick=\"return false;\"><i class=\"fa fa-user-secret\"></i>"+LANG_TXT_BTN_PRIVILEGES+"</button>"
				BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_config\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_planning iw_margin_right_3px\" onclick=\"return false;\"><i class=\"fa fa-cogs\"></i>"+LANG_TXT_BTN_CONFIG+"</button>"
			End if 
			
			BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_list\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_planning  iw_margin_right_3px iw_btn_vert\" onclick=\"return false;\"><i class=\"fa fa-list\"></i>"+LANG_TXT_BTN_LIST+"</button>"
			BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_rappel\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_planning iw_margin_right_3px iw_btn_orange\" onclick=\"return false;\"><i class=\"fa fa-bell\"></i>"+LANG_TXT_BTN_RAPPEL+"</button>"
			
			// Modifié par : Scanu Rémy (05/09/2022)
			BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_activer_alert\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_planning iw_margin_right_3px iw_btn_orange d-none\" onclick=\"return false;\"><i class=\"fa fa-bell\"></i>Alertes</button>"
			
			BTN_LISTE:=BTN_LISTE+"<button id=\"iw_btn_plan_print\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_float_left btn_pla_search iw_display_none \" onclick=\"return false;\"><i class=\"fa fa-print\"></i></button>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			
			Web_Form_PLA_Filters(->BTN_LISTE; "simple")
			
			BTN_LISTE:=BTN_LISTE+"</div>"
			BTN_LISTE:=BTN_LISTE+"</div>"
			
			HTML_VIEW:=HTML_VIEW+BTN_LISTE
			
			BTN_LISTE:=""
			
			//*** filtres
			HTML_VIEW:=HTML_VIEW+"<div class=\"iw_width_100\">"
			Web_Form_PLA_Filters(->HTML_VIEW; "avance")
			HTML_VIEW:=HTML_VIEW+"</div>"
			//****
			
			HTML_VIEW:=HTML_VIEW+"<div class=\"iw_width_100\">"
			HTML_VIEW:=HTML_VIEW+"<div id=\"script-warning\"></div>"
			HTML_VIEW:=HTML_VIEW+"<div id=\"loading\">Chargement...</div>"
			HTML_VIEW:=HTML_VIEW+"<div id=\"calendar\"></div>"
			
			HTML_VIEW:=HTML_VIEW+Web_Form_Event_Popup
			HTML_VIEW:=HTML_VIEW+Web_Form_PLA_Privileges_Popup
			HTML_VIEW:=HTML_VIEW+Web_Form_PLA_Settings_Popup
			
			$html:=Web_Form_Event_HG
			HTML_VIEW:=HTML_VIEW+Web_Form_Popup("hg"; ->$html; True:C214)
			
			HTML_VIEW:=HTML_VIEW+"</div>"
		Else 
			WEB_message(""; "Vous n'avez pas les autorisations requises pour accèder au planning pour votre structure, veuillez contactez l'administarteur.")
		End if 
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="planning-data")
		Web_Planning_Get_Data
	: ($action="pla_get_participants")
		Web_PLA_Get_Participants
	: ($action="pla_get_privileges")
		Web_PLA_Get_Privileges
	: ($action="pla_fiche_valider")
		Web_PLA_Save(->[Events:103]; "pla")
	: ($action="pla_resize_save")
		Web_Update_Pla(->[Events:103]; "pla"; "resize")
	: ($action="pla_drop_save")
		Web_Update_Pla(->[Events:103]; "pla"; "drop")
	: ($action="pla_event_remove")
		Web_PLA_Delete_Event(->[Events:103]; "pla")
	: ($action="get_event")
		Web_Get_Event(->[Events:103]; "pla")
	: ($action="set_preference")
		PLA_Preferences_Set(->[Preferences:81]; "pla")
	: ($action="get_preference")
		PREF_Web_Get
	: ($action="events-list")
		HTML_NAME_NAV_MODULE:="Liste des événements"
		
		HTML_VIEW:=""
		HTML_VIEW:=HTML_VIEW+BTN_LISTE
		
		BTN_LISTE:=""
		BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_fill\"><div class=\"buttons\">"
		BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
		
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_eve_export\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_btn_gris\" onclick=\"return false;\"><i class=\"fa fa-file-excel-o\"></i>"+LANG_TXT_BTN_EXPORT+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_eve_list_print\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_olive iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>"+LANG_TXT_BTN_PRINT+"</button>"
		BTN_LISTE:=BTN_LISTE+"<button id=\"btn_eve_back\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_btn_gris_fonce iw_margin_left_5px \" onclick=\"return false;\"><i class=\"fa fa-arrow-left\"></i>"+LANG_TXT_BTN_BACK+"</button>"
		
		BTN_LISTE:=BTN_LISTE+"</div>"
		BTN_LISTE:=BTN_LISTE+"</div>"
		
		UTL_Add_Script("eve_events_list")
		
		Web_UTL_Add_CSS("events_list")
		
		Web_UTL_Add_CSS("fiche_usager")
		Web_UTL_Add_CSS("gl_liste_usagers")
		Web_UTL_Add_CSS("gl_liste_locataires")
		
		UTL_Add_Script("iw_datatable")
		UTL_Add_Script("gl_dashboard")
		Web_UTL_Add_CSS("iw_datatable")
		
		Web_UTL_Add_CSS("form_list")
		
		HTML_VIEW:=HTML_VIEW+Web_Form_Recherche_Event
		
		BTN_LISTE:=""
		
		APPEND TO ARRAY:C911($tb_headers_th; "Usager")
		APPEND TO ARRAY:C911($tb_headers_th; "Type")
		APPEND TO ARRAY:C911($tb_headers_th; "Présence")
		APPEND TO ARRAY:C911($tb_headers_th; "Titre")
		APPEND TO ARRAY:C911($tb_headers_th; "Date du")
		APPEND TO ARRAY:C911($tb_headers_th; "Date au")
		APPEND TO ARRAY:C911($tb_headers_th; "Heure du")
		APPEND TO ARRAY:C911($tb_headers_th; "Heure au")
		APPEND TO ARRAY:C911($tb_headers_th; "Rappel")
		APPEND TO ARRAY:C911($tb_headers_th; "Récurrence")
		APPEND TO ARRAY:C911($tb_headers_th; "Propriétaire")
		
		WebAGL_Table_Liste(->HTML_VIEW; ->$tb_headers_th; "list_table_events")
		HTML_VIEW:=HTML_VIEW+Web_Form_Usager_Popup
		
		WebAGL_render_view_modes($table_ptr; $champ_uid)
	: ($action="events_list_json")
		Web_Events_Get_List_TS
	: ($action="export_events")
		Web_Export_Events
	: ($action="print_liste")
		ASSERT:C1129(False:C215; "Appel d'une fonction désactivée : Web_Events_Print")
		//Web_Events_Print
	: ($action="pla_notification_send")
		Web_PLA_Notification_Send
	: ($action="sms_send")
		Web_PLA_Notification_Send
	: ($action="email_send")
		Web_PLA_Notification_Send
	: ($action="hg_creation_fiches")
		Web_PLA_HG_Create
	: ($action="hg_multi_pointage")
		Web_Multi_Pointage
	: ($action="get_pla_rappel")
		Web_PLA_Rappel
	: ($action="get_pla_rappel_instant")
		Web_PLA_Rappel(True:C214)
	: ($action="get_pla_autorisations")
		Web_PLA_Get_Autorisation
	: ($action="get_hg_liste")
		Web_PLA_Get_HG_Liste
End case 