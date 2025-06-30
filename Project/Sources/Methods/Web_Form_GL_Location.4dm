//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-01-19, 16:10:03
// ----------------------------------------------------
// Method: Web_Form_GL_Location
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($HTML_CONTENT; FIX_DATE_FORMAT; $disabled_nom)
C_LONGINT:C283($o)

ARRAY TEXT:C222($TB_HTML; 150; 15)

$disabled_nom:="readonly"

WEB_CHAMP_Saisissable:=""
PARAM_MANDATORY_FIELDS:=""

FIX_DATE_FORMAT:="dd/mm/yyyy"

UTL_Add_Script("gl_fiche_location")
UTL_Add_Script("gl_charges")
UTL_Add_Script("etat_des_lieux.js")

Web_UTL_Add_CSS("recherche_usager")
Web_UTL_Add_CSS("gl_liste_usagers")
Web_UTL_Add_CSS("gl_fiche_location")
Web_UTL_Add_CSS("fiche_usager")
Web_UTL_Add_CSS("form_list")
Web_UTL_Add_CSS("gl_charges")

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=bien_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Boutons("gl_doc_fiche_top")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_entete\">"

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Location(->[Locations:84]ID:1; "content")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // Fin entête

//=============================================================================//
// LES APL
//=============================================================================//
BTN_LISTE:=""
BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"span7 fdp_boutons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<select id=\"aplYearList\" class=\"iw_float_left\">"
BTN_LISTE:=BTN_LISTE+"</select>"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_save_apl\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-save\"></i>SAUVEGARDER</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_refresh_apl\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-refresh\"></i>DEMANDER RÉACTUALISATION DU MONTANT EN RETARD DES APL</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_apl\" class=\"fdp_resp_table wrap-table100 iw-alternance-only overflow-x\">"
$HTML_CONTENT:=$HTML_CONTENT+"<table id=\"tableAPL\" class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</table>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//===============================END APL==========================================//

//=========================================================================//
// COLOCATAIRES
//=========================================================================//
BTN_LISTE:=""
BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"LES COLOCATAIRES"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half\" style=\"margin: 0px 0px 0px 0px;\" >"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_colocataire\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" style=\"float:right;margin-bottom:5px;\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NV_COLOCATAIRE+"</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_colocataires\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=============================END COLOCATAIRES============================================//

//=============================================================================//
// LES CHARGES
//=============================================================================//
BTN_LISTE:=""
BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"LES CHARGES"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_charge\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_CHARGE+"</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_charges\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//===============================END CHARGES==========================================//

//=========================================================================//
// ÉTAT DES LIEUX
//=========================================================================//
BTN_LISTE:=""
BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"ÉTAT DES LIEUX"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half\" style=\"\" >"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div id=\"etatSelection\" class=\"rowB\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"col-3\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"control-group\">"

BTN_LISTE:=BTN_LISTE+"<label class=\"control-label-group\">Choisir le modèle pour créer ou ouvrir un état</label>"
BTN_LISTE:=BTN_LISTE+"<div class=\"controls \">"
BTN_LISTE:=BTN_LISTE+"<select id=\"etatList\"><option value=\"\">Sélectionnez un état des lieux</option></select>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"col-9\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"g-align-center-vertically-col-9\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_etl_ouvrir\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_margin_left_5px d-none\" onclick=\"return false;\"><i class=\"fa fa-book\"></i>Ouvrir</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_etl_creer\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px d-none\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>Créer</button>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP
//=============================END ETAT DES LIEUX============================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied iw_display_none\" style=\"\">"
//=========================================================================//
// COL LEFT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_third\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
//=========================================================================//

//=========================================================================//
// COL RIGHT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=========================================================================//

//=========================================================================//
// Hidden 
//=========================================================================//
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id"
$TB_HTML{$o}{4}:=String:C10([Locations:84]ID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="ref_structure"
$TB_HTML{$o}{4}:=[Factures:86]Ref_Structure:19
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ref_structure"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="form_back_view"
$TB_HTML{$o}{4}:=web_form_back_view
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="form_back_view"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="action"
$TB_HTML{$o}{4}:=$action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="action"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</form>"

// Modifié par : Scanu Rémy (03/03/2023)
//$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Doc_Popup

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Charge_Popup("gl_charge_location_valider"; "charges_locations_list_json"; False:C215)
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Colocataire_Popup

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Popup("gl_etl_valider"; "etl_list_json"; [Locations:84]ID:1)
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Popup("gl_etl_valider"; "etl_list_json"; [Locations:84]ID:1; "print")

$0:=$HTML_CONTENT