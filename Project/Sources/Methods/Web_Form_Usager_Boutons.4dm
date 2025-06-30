//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 01/11/18, 17:15:12
// ----------------------------------------------------
// Méthode : Web_Form_Usager_Boutons
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_POINTER:C301($html)

$html:=$1

$html->:=$html->+"<div id=\"usager-btns\" class=\"span12 fdp_boutons iw_btns_usager_actions\" style=\"display: none;\">"
$html->:=$html->+"<div class=\"btn-wrapper\">"

If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "JOUR").length=1) & ([SOciete:18]SO_DC_Activer:140=False:C215)
	$html->:=$html->+"<button id=\"fdp_usager_add\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NV_FICHE_HB+"</button>"
End if 

$html->:=$html->+"<button id=\"fdp_usager_add_presta\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NV_FICHE_PRE+"</button>"
$html->:=$html->+"<button id=\"fdp_usager_multi_pointage\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_POINTAGE_MULTI+"</button>"
$html->:=$html->+"<button id=\"fdp_usager_notes\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_yellow iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-commenting-o\"></i>Coordonnées</button>"

// Modifié par : Scanu Rémy (07/02/2024)
// Ajout check si l'utilisateur a le privilège nécessaire
If (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214) | (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214) | (outilsManagePrivilege(1; "Notes FVV"; w_userUID)=True:C214)
	$html->:=$html->+"<button id=\"fdp_usager_nouvellesNotes\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_yellow iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-commenting-o\"></i>Notes</button>"
End if 

$html->:=$html->+"<button id=\"fdp_usager_sp\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_SP+"</button>"

$html->:=$html->+"<button type=\"button\" id=\"btn_sb_gi_basedoc_btn\" class=\"fdp_Button iw_margin_left_5px fdp_btn_top fdp-btn-green\">"
$html->:=$html->+"<a id=\"btn_sb_gi_basedoc_lien\" href=\"#\" class=\"btn_left\"><i class=\"fa fa-file-pdf-o\" style=\"color:#fff;\"></i></a>"
$html->:=$html->+"Documents"
$html->:=$html->+"</button>"

// Modifié par : Scanu Rémy (16/05/2023)
$html->:=$html->+"<button id=\"fdp_usager_situationBudgetaire\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-orange iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-euro\"></i>Situation budgetaire</button>"

// Modifié par : Scanu Rémy (01/06/2023)
$html->:=$html->+"<button id=\"fdp_usager_imprimerDocument\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>Imprimer</button>"

// Modifié par : Scanu Rémy (10/04/2024)
$html->:=$html->+"<button id=\"fdp_usager_hebergement_delete\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa  fa-remove\"></i>"+LANG_TXT_BTN_SUPPRIMER+"</button>"

$html->:=$html->+"</div>"
$html->:=$html->+"</div>"