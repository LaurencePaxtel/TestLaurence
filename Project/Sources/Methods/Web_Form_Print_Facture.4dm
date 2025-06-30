//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24-04-19, 15:32:06
// ----------------------------------------------------
// Method: Web_Form_Print_Facture
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($HTML_CONTENT; $HTML_CONTENT; $path_logo; $css_section)
C_LONGINT:C283($element_cpt; $cpt_pieces)

C_TEXT:C284(FIX_DATE_FORMAT; WEB_CHAMP_Titre)

FIX_DATE_FORMAT:="dd/mm/yyyy"
PARAM_MANDATORY_FIELDS:=""
WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=etl_fiche_valider\" name=\"fiche_form_print\" id=\"fiche_form_print\" method=\"POST\" class=\"collectable form-horizontal well iw_print_page fac_print_content\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"fac_print_content\" class=\"iw_print\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"fac_print_content_child\" class=\"iw_print\">"

//-------------------------------------------------------------------------//
// FACTURE ENTETE 1
//-------------------------------------------------------------------------//

READ ONLY:C145([Adresses:53])

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"iw_print_header\" class=\"iw_div_content \">"

$path_logo:="http://"+Web_Get_Server_IP+"/base_documentaire/"+[Structures:79]STRC_Initiales:2+"/logo.png"
$HTML_CONTENT:=$HTML_CONTENT+"<img class=\"strc_logo\" src=\""+$path_logo+"\">"
$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre \" >"+[Structures:79]STRC_Nom:4+"</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Date facture : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_centre_nom\">"+String:C10([Factures:86]FAC_Date_Piece:3)+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Date d'échéance : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_centre_nom\">"+String:C10([Factures:86]FAC_Date_Echeance:20)+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// FACTURE ENTETE 2
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// FACTURE ENTETE 3
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"<h4 class=\"section_titre\" >LE BAILLEUR / MANDATAIRE</h4>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_bailleur_nom\">"+[Factures:86]FAC_Locataire_Nom:31+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"

$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_bailleur_adresse\">"+[Factures:86]FAC_Adresse_Facturation:14+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \" style=\"width:100% !important;height:50px !important;\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : LIGNES 
//-------------------------------------------------------------------------//
QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
$cpt_pieces:=$cpt_pieces+1

If ($cpt_pieces=2)
	$css_section:="iw_print_page_break_before"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"iw_print_content\" class=\"iw_div_content etl_section iw_section_lignes "+$css_section+"\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_resp_table  iw-alternance-only etl_table \" >"

$HTML_CONTENT:=$HTML_CONTENT+"<table class=\"iw_print_items iw_print_pv iw_print_portlet noborders\">"
$HTML_CONTENT:=$HTML_CONTENT+"<thead>"
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_1\" >"
$HTML_CONTENT:=$HTML_CONTENT+"LOCAL LOUÉ"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
$HTML_CONTENT:=$HTML_CONTENT+"</thead>"
$HTML_CONTENT:=$HTML_CONTENT+"<tbody>"
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+[Factures_Lignes:87]FACL_Titre:6
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
$HTML_CONTENT:=$HTML_CONTENT+"</tbody>"
$HTML_CONTENT:=$HTML_CONTENT+"</table>"

$HTML_CONTENT:=$HTML_CONTENT+"<table class=\"iw_print_items iw_print_pv iw_print_quittance noborders\">"
$HTML_CONTENT:=$HTML_CONTENT+"<thead>"
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_1\" >"
$HTML_CONTENT:=$HTML_CONTENT+"QUITTANCE"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_2\" >"
$HTML_CONTENT:=$HTML_CONTENT+" "
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_3\" >"
$HTML_CONTENT:=$HTML_CONTENT+"  "
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
$HTML_CONTENT:=$HTML_CONTENT+"</thead>"
$HTML_CONTENT:=$HTML_CONTENT+"<tbody>"

$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"border:none !important;\">"
$HTML_CONTENT:=$HTML_CONTENT+"PERIODE DU 01/03/2018 AU 31/03/2018"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"border:none !important;\">"
$HTML_CONTENT:=$HTML_CONTENT+"Libellé"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"border:none !important;\">"
$HTML_CONTENT:=$HTML_CONTENT+"Montant"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"

$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"Réf. : 14750101"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"LOYER"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"599.00"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"

$HTML_CONTENT:=$HTML_CONTENT+"</tbody>"
$HTML_CONTENT:=$HTML_CONTENT+"</table>"

$HTML_CONTENT:=$HTML_CONTENT+"<table class=\"iw_print_items iw_print_pv\">"

$HTML_CONTENT:=$HTML_CONTENT+"<thead>"
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_1\" >"
$HTML_CONTENT:=$HTML_CONTENT+"Désignation"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_2\">"
$HTML_CONTENT:=$HTML_CONTENT+"Quantité"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_3\">"
$HTML_CONTENT:=$HTML_CONTENT+"Prix Unit."
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_4\">"
$HTML_CONTENT:=$HTML_CONTENT+"% Remise"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_5\">"
$HTML_CONTENT:=$HTML_CONTENT+"Prix Unit. Net"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_6\">"
$HTML_CONTENT:=$HTML_CONTENT+"Mont. remise"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_7\">"
$HTML_CONTENT:=$HTML_CONTENT+"Montant HT"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_8\">"
$HTML_CONTENT:=$HTML_CONTENT+"Montant TTC"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
$HTML_CONTENT:=$HTML_CONTENT+"</thead>"

$HTML_CONTENT:=$HTML_CONTENT+"<tbody>"

FIRST RECORD:C50([Pieces_Elements:98])

While (Not:C34(End selection:C36([Factures_Lignes:87])))
	$element_cpt:=$element_cpt+1
	
	$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+[Factures_Lignes:87]FACL_Titre:6
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10([Factures_Lignes:87]FACL_Quantite:18)
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10(Round:C94([Factures_Lignes:87]FACL_Prix_Unit_HT:8; 2))
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10(Round:C94([Factures_Lignes:87]FACL_Remise_Taux:13; 2))
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10(Round:C94([Factures_Lignes:87]FACL_Prix_Unit_Net:15; 2))
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10(Round:C94([Factures_Lignes:87]FACL_Remise_Montant:14; 2))
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10(Round:C94([Factures_Lignes:87]FACL_Montant_HT:9; 2))
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<td>"
	$HTML_CONTENT:=$HTML_CONTENT+String:C10(Round:C94([Factures_Lignes:87]FACL_Montant_TTC:12; 2))
	$HTML_CONTENT:=$HTML_CONTENT+"</td>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
	
	NEXT RECORD:C51([Factures_Lignes:87])
End while 

$HTML_CONTENT:=$HTML_CONTENT+"</tbody>"
$HTML_CONTENT:=$HTML_CONTENT+"</table>"

//-------------------------------------------------------------------------//
// SECTION : FACTURE PIED 
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<br/>"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_fac_pied \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full iw_fac_pied_libelle\">"
$HTML_CONTENT:=$HTML_CONTENT+"Total Hors Taxes : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_total_hors_taxes\">"+String:C10(Round:C94([Factures:86]FAC_Montant_HT:6; 2))+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full iw_fac_pied_libelle\">"
$HTML_CONTENT:=$HTML_CONTENT+"Total TTC : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_total_ttc\">"+String:C10(Round:C94([Factures:86]FAC_Montant_TTC:8; 2))+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin entete

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
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</form>"

$0:=$HTML_CONTENT