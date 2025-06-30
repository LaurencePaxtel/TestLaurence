//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21-12-18, 07:26:19
// ----------------------------------------------------
// Method: Web_Form_Boutons
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($html; $type)
C_BOOLEAN:C305($privileges_facturation)

$type:=$1

Case of 
	: ($type="dashboard")
		$html:=$html+"<div class=\"span6 fdp_boutons\" style=\"margin-bottom:10px;margin-top:0px;\">"
		$html:=$html+"<div class=\"buttons\">"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		$html:=$html+"<button id=\"btn_dashboard_factures\" type=\"reset\" class=\"iw_btn_dashboard iw_btn_first fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_FACTURES+"</button>"
		$html:=$html+"<button id=\"btn_dashboard_reglements\" type=\"reset\" class=\"iw_btn_dashboard fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_REGLEMENTS+"</button>"
		$html:=$html+"<button id=\"btn_dashboard_locataires\" type=\"reset\" class=\"iw_btn_dashboard fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_LOCATAIRES+"</button>"
		$html:=$html+"<button id=\"btn_dashboard_proprietaires\" type=\"reset\" class=\"iw_btn_dashboard fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_PROPRIETAIRES+"</button>"
		$html:=$html+"<button id=\"btn_dashboard_biens\" type=\"reset\" class=\"iw_btn_dashboard fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_BIENS+"</button>"
		//$html:=$html+"<button id=\"btn_dashboard_relances\" type=\"reset\" class=\"iw_btn_dashboard fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_RELANCES+"</button>"
		$html:=$html+"<button id=\"btn_dashboard_irl\" type=\"reset\" class=\"iw_btn_dashboard fdp_Button fdp_btn_top  iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-bars\"></i>"+LANG_TXT_BTN_IRL+"</button>"
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="facture_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		$html:=$html+"<button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-ban\"></i>"+LANG_TXT_BTN_QUITTER+"</button>"
		
		// Modifié par : Scanu Rémy (19/03/2024)
/*
$html:=$html+"<button id=\"fdp_piece_print\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_olive iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>"+LANG_TXT_BTN_PRINT+"</button>"
*/
		
		// Modifié par : Scanu Rémy (01/03/2024)
		$html:=$html+"<button id=\"fdp_piece_print_avis\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_olive iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>Imprimer Avis-Facture</button>"
		$html:=$html+"<button id=\"fdp_piece_print_quittance\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_olive iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>Imprimer Quittances</button>"
		
		$privileges_facturation:=Web_User_Check_Privilege("Privilege Facturation Web")
		
		If ($privileges_facturation)
			
			If ([Factures:86]FAC_Type:21#"Définitive")
				$html:=$html+"<button id=\"fdp_piece_delete\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_red iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-remove\"></i>"+LANG_TXT_BTN_DELETE+"</button>"
				$html:=$html+"<button id=\"fdp_piece_valider\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button>"
			End if 
			
		End if 
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="gl_bien_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons\" >"
		$html:=$html+"<div class=\"btn-wrapper flex-centered\">"
		
		// Modifié par : Scanu Rémy (28/03/2022)
		$html:=$html+"<div class=\"iw_float_left width-50x\">"+\
			"<div class=\"rowB\">"+\
			"<div class=\"col-6\"><div class=\"g-align-bottom-left\"><input type=\"checkbox\" id=\"lc_actif\" name=\"bienActif\" class=\"iw_select\" style=\"height: 20px!important;text-align:left;margin:0px 5px 0px 0px;\" /> <span>Bien actif</span></div></div>"+\
			"<div class=\"col-6\"><label class=\"fdp_width100 search\">Type de gestion</label><select id=\"lc_gl_type_gestion\" class=\"span7 search\" name=\"lc_gl_type_gestion\"><option value=\"\">Sélectionnez un type de gestion</option></select></div></div></div>"
		$html:=$html+"<div class=\"iw_float_right width-50x\"><button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-arrow-left\"></i>"+LANG_TXT_BTN_RETOUR+"</button>"
		$html:=$html+"<button id=\"fdp_piece_valider\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button></div>"
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="gl_doc_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		// Modifié par : Scanu Rémy (09/03/2023)
		// On masque le bouton "Retour" sur demande de Laurence
		//$html:=$html+"<button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-arrow-left\"></i>"+LANG_TXT_BTN_RETOUR+"</button>"
		$html:=$html+"<button id=\"fdp_piece_valider\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button>"
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="reglement_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		$html:=$html+"<button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-ban\"></i>"+LANG_TXT_BTN_QUITTER+"</button>"
		$html:=$html+"<button id=\"fdp_piece_print\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_olive iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>"+LANG_TXT_BTN_PRINT+"</button>"
		$html:=$html+"<button id=\"fdp_piece_delete\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_red iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-remove\"></i>"+LANG_TXT_BTN_DELETE+"</button>"
		
		//Si ([Reglements]REG_No_Piece="")
		$html:=$html+"<button id=\"fdp_piece_valider\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button>"
		
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="regular_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		$html:=$html+"<button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-ban\"></i>"+LANG_TXT_BTN_QUITTER+"</button>"
		$html:=$html+"<button id=\"fdp_piece_valider\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button>"
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="intervention_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons btns_fiche_top\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		$html:=$html+"<button id=\"fdp_piece_imprimer\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-print\"></i>Imprimer</button>"
		$html:=$html+"<button id=\"fdp_piece_valider\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>"+LANG_TXT_BTN_VALIDER+"</button>"
		$html:=$html+"<button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-ban\"></i>"+LANG_TXT_BTN_QUITTER+"</button>"
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
	: ($type="stock_fiche_top")
		$html:=$html+"<div id=\"usager-btns\" class=\"span12 fdp_boutons btns_fiche_top\" >"
		$html:=$html+"<div class=\"btn-wrapper\">"
		
		$html:=$html+"<button id=\"fdp_piece_quitter\" type=\"submit\" class=\"fdp_Button  fdp_btn_top iw_button_blue_dark iw_margin_left_5px iw_float_right\" onclick=\"return false;\"><i class=\"fa fa-arrow-left\"></i>"+LANG_TXT_BTN_RETOUR+"</button>"
		
		$html:=$html+"</div>"
		$html:=$html+"</div>"
End case 

$0:=$html