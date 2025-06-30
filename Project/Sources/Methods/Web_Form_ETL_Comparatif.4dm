//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 24-05-19, 08:15:19
// ----------------------------------------------------
// Method: Web_Form_ETL_Comparatif
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($HTML_CONTENT; FIX_DATE_FORMAT)
C_LONGINT:C283($o; $id_location; $1)
$o:=0

$id_location:=$1


READ ONLY:C145([Locations:84])
READ ONLY:C145([Inventaire_Pieces:96])

QUERY:C277([Locations:84]; [Locations:84]ID:1=[Locations:84]ID:1)
QUERY:C277([Inventaire_Pieces:96]; [Inventaire_Pieces:96]INV_ID_Bien:18=[Locations:84]LOC_Bien_ID:5)

ALL RECORDS:C47([Pieces_Elements:98])

WEB_CHAMP_Saisissable:="readonly"

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:=""

PARAM_MANDATORY_FIELDS:=""

$disabled:=""
WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=etl_fiche_valider\" name=\"fiche_form_print\" id=\"fiche_form_print\" method=\"POST\" class=\"collectable form-horizontal well iw_print_page\" enctype=\"multipart/form-data\" >"

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"etl_print_content\" class=\"iw_print\">"

$HTML_CONTENT:=$HTML_CONTENT+"<h2 class=\"iw_print_title_doc\" >ÉTAT DES LIEUX</h2>"

//-------------------------------------------------------------------------//
// ETAT DES LIEUX
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"



$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Date d'entrée : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_date\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Date de sortie : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_date\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//


//-------------------------------------------------------------------------//
// LES LOCAUX
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre\" >LES LOCAUX</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Type : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_bien_type\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Surface : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_surface\"></label> m²"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Nombre des pièces principales : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pieces_principales\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Adresse : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_bien_adresse\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//


//-------------------------------------------------------------------------//
// LE BAILLEUR (OU MANDATAIRE)
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre\" >LE BAILLEUR (OU MANDATAIRE)</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Prénom et nom / Dénomination sociale : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_bailleur_nom\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Adresse : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_bailleur_adresse\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : ELECTRICITE 
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre\" >ÉLECTRICITÉ : DÉMARCHES</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Numéro du compteur : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_electricite_no_compteur\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Relevé HP : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_electricite_releve_hp\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Relevé HC : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_electricite_releve_hc\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//


//-------------------------------------------------------------------------//
// SECTION : GAZ NATUREL
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre\" >GAZ NATUREL : DÉMARCHES</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Numéro du compteur : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_gaz_naturel_no_compteur\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Relevé du compteur : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_gaz_naturel_releve\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : EAU
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre\" >EAU</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Eau froide (relévé m3) : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_eau_froide_releve\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Eau chaude (relévé m3) : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_eau_chaude_releve\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : CARACTÉRISTIQUES ÉNERGÉTIQUES
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content   \">"

$HTML_CONTENT:=$HTML_CONTENT+"<h3 class=\"section_titre\" >CARACTÉRISTIQUES ÉNERGÉTIQUES</h3>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_print_item\">"
$HTML_CONTENT:=$HTML_CONTENT+"Chauffage : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_chauffage\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div>"
$HTML_CONTENT:=$HTML_CONTENT+"Eau chaude : "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_eau_chaude\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//


//-------------------------------------------------------------------------//
// SECTION : PARTIES PRIVATIVES ATTACHÉES AU LOGEMENT
//-------------------------------------------------------------------------//


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section  iw_print_page_break_before\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"PARTIES PRIVATIVES ATTACHÉES AU LOGEMENT"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_resp_table  iw-alternance-only etl_table \" >"

$HTML_CONTENT:=$HTML_CONTENT+"<table class=\"iw_print_items iw_print_pv\">"

$HTML_CONTENT:=$HTML_CONTENT+"<thead>"
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_1\" >"
$HTML_CONTENT:=$HTML_CONTENT+"Partie privative"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_2\">"
$HTML_CONTENT:=$HTML_CONTENT+"Etat d'entrée"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_3\">"
$HTML_CONTENT:=$HTML_CONTENT+"Etat de sortie"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_4\">"
$HTML_CONTENT:=$HTML_CONTENT+"N°"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_5\">"
$HTML_CONTENT:=$HTML_CONTENT+"Commentaire"
$HTML_CONTENT:=$HTML_CONTENT+"</th>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
$HTML_CONTENT:=$HTML_CONTENT+"</thead>"

$HTML_CONTENT:=$HTML_CONTENT+"<tbody>"

//=====================//
// CAVE
//=====================//

$HTML_CONTENT:=$HTML_CONTENT+"<tr  class=\"item-row\">"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"Cave"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_cave_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_cave_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_cave_num\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_cave_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_cave_separator\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_cave_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"


//=====================//
// Parking
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"Parking"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_parking_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_parking_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_parking_num\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_parking_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_parking_separator\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_parking_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"


//=====================//

//=====================//
// Jardin
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"Jardin"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_jardin_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_jardin_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_jardin_num\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_jardin_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_jardin_separator\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_jardin_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"

//=====================//

//=====================//
// Balcon
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"Balcon"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_balcon_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_balcon_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_balcon_num\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_balcon_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_balcon_separator\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_balcon_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
//=====================//

//=====================//
// Terrasse
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"Terrasse"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_terrasse_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_terrasse_etat\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_terrasse_num\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"<td>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_etl_pv_terrasse_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_etl_pv_terrasse_separator\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_etl_pv_terrasse_commentaires\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+"</td>"
$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
//=====================//

$HTML_CONTENT:=$HTML_CONTENT+"</tbody>"
$HTML_CONTENT:=$HTML_CONTENT+"</table>"
//


$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

C_LONGINT:C283($piece_id; $element_cpt; $cpt_pieces)
C_TEXT:C284($css_section)

$piece_id:=0
$cpt_pieces:=0

//-------------------------------------------------------------------------//
// SECTION : PIECES
//-------------------------------------------------------------------------//

READ ONLY:C145([Inventaire_Pieces_Lignes:100])
QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=[Inventaire_Pieces:96]ID:1)
ORDER BY:C49([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5; >)
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

ORDER BY:C49([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5; >)

While (Not:C34(End selection:C36([Inventaire_Pieces_Lignes:100])))
	
	
	$piece_id:=[Inventaire_Pieces_Lignes:100]ID:1
	
	$cpt_pieces:=$cpt_pieces+1
	
	$css_section:=""
	If ($cpt_pieces=2)
		$css_section:="iw_print_page_break_before"
	End if 
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section  "+$css_section+"\">"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
	$HTML_CONTENT:=$HTML_CONTENT+[Inventaire_Pieces_Lignes:100]IPL_Libelle:6
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_resp_table  iw-alternance-only etl_table \" >"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<table class=\"iw_print_items iw_print_pv\">"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<thead>"
	$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
	$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_1\" >"
	$HTML_CONTENT:=$HTML_CONTENT+"Elément"
	$HTML_CONTENT:=$HTML_CONTENT+"</th>"
	$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_2\">"
	$HTML_CONTENT:=$HTML_CONTENT+"Etat d'entrée"
	$HTML_CONTENT:=$HTML_CONTENT+"</th>"
	$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_3\">"
	$HTML_CONTENT:=$HTML_CONTENT+"Etat de sortie"
	$HTML_CONTENT:=$HTML_CONTENT+"</th>"
	$HTML_CONTENT:=$HTML_CONTENT+"<th class=\"iw_cell_5\">"
	$HTML_CONTENT:=$HTML_CONTENT+"Commentaire"
	$HTML_CONTENT:=$HTML_CONTENT+"</th>"
	$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
	$HTML_CONTENT:=$HTML_CONTENT+"</thead>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<tbody>"
	
	
	C_TEXT:C284(WEB_CHAMP_Titre)
	
	FIRST RECORD:C50([Pieces_Elements:98])
	$element_cpt:=0
	
	
	
	While (Not:C34(End selection:C36([Pieces_Elements:98])))
		
		$element_cpt:=$element_cpt+1
		
		$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
		$HTML_CONTENT:=$HTML_CONTENT+"<td>"
		$HTML_CONTENT:=$HTML_CONTENT+[Pieces_Elements:98]PEL_Libelle:2
		$HTML_CONTENT:=$HTML_CONTENT+"</td>"
		$HTML_CONTENT:=$HTML_CONTENT+"<td>"
		$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_pce"+String:C10($piece_id)+"_"+String:C10($element_cpt)+"\"></label>"
		$HTML_CONTENT:=$HTML_CONTENT+"</td>"
		$HTML_CONTENT:=$HTML_CONTENT+"<td>"
		$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_pce"+String:C10($piece_id)+"_"+String:C10($element_cpt)+"\"></label>"
		$HTML_CONTENT:=$HTML_CONTENT+"</td>"
		$HTML_CONTENT:=$HTML_CONTENT+"<td>"
		$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_pcc"+String:C10($piece_id)+"_"+String:C10($element_cpt)+"\"></label>"
		$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_separator_"+String:C10($piece_id)+"_"+String:C10($element_cpt)+"\"></label>"
		$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_pcc"+String:C10($piece_id)+"_"+String:C10($element_cpt)+"\"></label>"
		$HTML_CONTENT:=$HTML_CONTENT+"</td>"
		$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
		
		NEXT RECORD:C51([Pieces_Elements:98])
	End while 
	
	$HTML_CONTENT:=$HTML_CONTENT+"</tbody>"
	$HTML_CONTENT:=$HTML_CONTENT+"</table>"
	
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"
	$HTML_CONTENT:=$HTML_CONTENT+"Autres commentaires : "
	$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_eli_commentaires_p"+String:C10($piece_id)+"\"></label>"
	$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_separator_commentaires_p"+String:C10($piece_id)+"\"></label>"
	$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_eli_commentaires_p"+String:C10($piece_id)+"\"></label>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	NEXT RECORD:C51([Inventaire_Pieces_Lignes:100])
End while 







//-------------------------------------------------------------------------//
// SECTION : SIGNATURE DES PARTIES - Entrée 
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_print_page_break_before\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"SIGNATURE DES PARTIES - Entrée :"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full iw_txt_signature\">"
$HTML_CONTENT:=$HTML_CONTENT+"Fait à "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_ville_signature\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+", le "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_e_date_signature\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+" , en deux exemplaires originaux, chaque partie reconnaissant en avoir reçu un."
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_half \">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre_1\">"
$HTML_CONTENT:=$HTML_CONTENT+"LE BAILLEUR"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<img id=\"print_e_signature_bailleur\" src=\"\" />"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre_1\">"
$HTML_CONTENT:=$HTML_CONTENT+"LE LOCATAIRE PRINCIPAL"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<img id=\"print_e_signature_locataire\" src=\"\" />"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : SIGNATURE DES PARTIES - Sortie 
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"SIGNATURE DES PARTIES - Sortie :"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full iw_txt_signature\">"
$HTML_CONTENT:=$HTML_CONTENT+"Fait à "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_ville_signature\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+", le "
$HTML_CONTENT:=$HTML_CONTENT+"<label id=\"print_s_date_signature\"></label>"
$HTML_CONTENT:=$HTML_CONTENT+" , en deux exemplaires originaux, chaque partie reconnaissant en avoir reçu un."
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre_1\">"
$HTML_CONTENT:=$HTML_CONTENT+"LE BAILLEUR"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<img id=\"print_s_signature_bailleur\" src=\"\" />"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre_2\">"
$HTML_CONTENT:=$HTML_CONTENT+"LE LOCATAIRE PRINCIPAL"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<img id=\"print_s_signature_locataire\" src=\"\" />"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//



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

$HTML_CONTENT:=$HTML_CONTENT+"</form>"

$0:=$HTML_CONTENT