//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 03/11/18, 18:59:44
// ----------------------------------------------------
// Méthode : Web_Form_Usager_Fiche_Boutons
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($html; $type)

$type:=$1

Case of 
	: ($type="top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		// Modifié par : Scanu Rémy (07/02/2024)
		// Ajout check si l'utilisateur a le privilège nécessaire
		If (outilsManagePrivilege(1; "NotesNote"; w_userUID)=True:C214) | (outilsManagePrivilege(1; "MARAUDE"; w_userUID)=True:C214) | (outilsManagePrivilege(1; "Notes FVV"; w_userUID)=True:C214)
			$html:=$html+"<button id=\"fdp_usager_nouvellesNotes\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_yellow iw_margin_right_5px\" onclick=\"return false;\"><i class=\"fa fa-commenting-o\"></i>Notes</button>"
		End if 
		
		$html:=$html+"<button id=\"fdp_usager_notes\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_yellow\" onclick=\"return false;\"><i class=\"fa fa-commenting-o\"></i>"+LANG_TXT_BTN_NOTES+"</button>"
		$html:=$html+"<button id=\"fdp_usager_sp\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-commenting-o\"></i>"+LANG_TXT_BTN_SP+"</button>"
		
		// Modifié par : Scanu Rémy (29/05/2024)
		// Les boutons avec l'id fdp-usager-add ne font rien...
		
		//$html:=$html+"<button id=\"fdp-usager-add\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_grey iw_margin_left_5px\" onclick=\"return false;\">"+LANG_TXT_BTN_NR+"</button>"
		$html:=$html+"<button id=\"fdp_usager_actions\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_grey iw_margin_left_5px\" onclick=\"return false;\">"+LANG_TXT_BTN_ACTIONS+"</button>"
		
		//$html:=$html+"<button id=\"fdp-usager-add\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>"+LANG_TXT_BTN_IMP_ACTIONS+"</button>"
		$html:=$html+"<button id=\"fdp_usager_af\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_grey iw_margin_left_5px\" onclick=\"return false;\">"+LANG_TXT_BTN_AF+"</button>"
		//$html:=$html+"<button id=\"fdp-usager-add\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_grey iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>"+LANG_TXT_BTN_IMP_AF+"</button>"
		
		If (outilsManagePrivilege(1; "ReportManuel"; w_userUID)=True:C214) & ([HeberGement:5]HG_Nuit:2=False:C215)
			$html:=$html+"<button id=\"fdp_usager_report_manuel\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue iw_margin_left_5px\" onclick=\"return false;\" style=\"width:150px!important;\"><i class=\"fa fa-calendar\"></i>Activer report manuel</button>"
		End if 
		
		$html:=$html+"<button id=\"fdp_usager_quitter\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-ban\"></i>"+LANG_TXT_BTN_QUITTER+"</button>"
		$html:=$html+"<button id=\"fdp_usager_valider\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button>"
		
		If ([HeberGement:5]HG_Nuit:2=False:C215)
			$html:=$html+"<button id=\"fdp_usager_sortie\" class=\"fdp_Button fdp_btn_top iw_button_red iw_margin_left_5px iw_float_right\"><i class=\"fa-solid fa-right-from-bracket\"></i>Sortie</button>"
		End if 
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="GHGPT")
		$html:=$html+"<button id=\"btn-ghgt-plateforme\" type=\"submit\" class=\"fdp_Button iw_button_blue  \" onclick=\"return false;\">"+LANG_TXT_BTN_GHGPT+"</button>"
End case 

$0:=$html