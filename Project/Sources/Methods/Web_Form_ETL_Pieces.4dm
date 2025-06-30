//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06-05-19, 09:31:21
// ----------------------------------------------------
// Method: Web_Form_ETL_Pieces
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_TEXT:C284($post_action; $get_action; $HTML_CONTENT; $enum_etat)
C_LONGINT:C283($o; $id_location; $piece_id; $element_cpt; $cpt_pieces)

C_TEXT:C284(FIX_DATE_FORMAT)

ARRAY TEXT:C222($TB_HTML; 405; 15)
ARRAY TEXT:C222($tb_enum_etat; 0)

$post_action:=$1
$get_action:=$2
$id_location:=$3

UTL_Add_Script("iw_signature")

APPEND TO ARRAY:C911($tb_enum_etat; "1")
APPEND TO ARRAY:C911($tb_enum_etat; "2")
APPEND TO ARRAY:C911($tb_enum_etat; "3")
APPEND TO ARRAY:C911($tb_enum_etat; "4")

$enum_etat:=";;"

For ($i; 1; Size of array:C274($tb_enum_etat))
	$enum_etat:=$enum_etat+"|"+$tb_enum_etat{$i}+"_"+$tb_enum_etat{$i}
End for 

READ ONLY:C145([Locations:84])
READ ONLY:C145([Inventaire_Pieces:96])

QUERY:C277([Locations:84]; [Locations:84]ID:1=[Locations:84]ID:1)
QUERY:C277([Inventaire_Pieces:96]; [Inventaire_Pieces:96]INV_ID_Bien:18=[Locations:84]LOC_Bien_ID:5)

ALL RECORDS:C47([Pieces_Elements:98])

WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:=""
$disabled:=""
WEB_CHAMP_Saisissable:=""

Web_UTL_Add_CSS("etl.css")

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=etl_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"\">"

//-------------------------------------------------------------------------//
// ENTETE
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Ligne("section_1")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : ELECTRICITE 
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"ÉLECTRICITÉ : DÉMARCHES"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Ligne("section_2")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : GAZ NATUREL
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"GAZ NATUREL : DÉMARCHES"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Ligne("section_3")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : EAU
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"EAU"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Ligne("section_4")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : CARACTÉRISTIQUES ÉNERGÉTIQUES
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"CARACTÉRISTIQUES ÉNERGÉTIQUES"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_ETL_Ligne("section_5")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//


//-------------------------------------------------------------------------//
// SECTION : PARTIES PRIVATIVES ATTACHÉES AU LOGEMENT
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content etl_section\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
$HTML_CONTENT:=$HTML_CONTENT+"PARTIES PRIVATIVES ATTACHÉES AU LOGEMENT"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_resp_table  iw-alternance-only etl_table\" >"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row header iw_etl_table_pv\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_cell_1\">Partie privative</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_cell_2\">État</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_cell_3\">N°</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_cell_4\">Commentaires</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=====================//
// CAVE
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row body \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
$HTML_CONTENT:=$HTML_CONTENT+"Cave"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="etl_pv_cave_etat"
$TB_HTML{$o}{4}:=$enum_etat
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_cave_etat"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_cave_num"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_cave_num"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_cave_commentaires"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_cave_commentaires"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=====================//
// Parking
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row body \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
$HTML_CONTENT:=$HTML_CONTENT+"Parking"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="etl_pv_parking_etat"
$TB_HTML{$o}{4}:=$enum_etat
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_parking_etat"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_parking_num"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_parking_num"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_parking_commentaires"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_parking_commentaires"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=====================//

//=====================//
// Jardin
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row body \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
$HTML_CONTENT:=$HTML_CONTENT+"Jardin"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="etl_pv_jardin_etat"
$TB_HTML{$o}{4}:=$enum_etat
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_jardin_etat"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_jardin_num"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_jardin_num"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_jardin_commentaires"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_jardin_commentaires"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=====================//

//=====================//
// Balcon
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row body \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
$HTML_CONTENT:=$HTML_CONTENT+"Balcon"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="etl_pv_balcon_etat"
$TB_HTML{$o}{4}:=$enum_etat
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_balcon_etat"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_balcon_num"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_balcon_num"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_balcon_commentaires"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_balcon_commentaires"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=====================//

//=====================//
// Terrasse
//=====================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row body \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
$HTML_CONTENT:=$HTML_CONTENT+"Terrasse"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="etl_pv_terrasse_etat"
$TB_HTML{$o}{4}:=$enum_etat
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_terrasse_etat"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_terrasse_num"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_terrasse_num"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="etl_pv_terrasse_commentaires"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_pv_terrasse_commentaires"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=====================//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

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
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre\">"
	$HTML_CONTENT:=$HTML_CONTENT+[Inventaire_Pieces_Lignes:100]IPL_Libelle:6
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="id_ligne_"+String:C10($piece_id)
	$TB_HTML{$o}{4}:=String:C10([ETL_Lignes:101]ID:1)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="id_ligne_"+String:C10($piece_id)
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="ipl_id_"+String:C10($piece_id)
	$TB_HTML{$o}{4}:=String:C10([Inventaire_Pieces_Lignes:100]ID:1)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="ipl_id_"+String:C10($piece_id)
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="id_piece_"+String:C10($cpt_pieces)
	$TB_HTML{$o}{4}:=String:C10([Inventaire_Pieces_Lignes:100]ID:1)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="id_piece_"+String:C10($cpt_pieces)
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	//***********************************
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_resp_table  iw-alternance-only etl_table\" >"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row header\">"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell \">Elément</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell \">État</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell \">Commentaires</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	C_TEXT:C284(WEB_CHAMP_Titre)
	
	FIRST RECORD:C50([Pieces_Elements:98])
	$element_cpt:=0
	
	While (Not:C34(End selection:C36([Pieces_Elements:98])))
		$element_cpt:=$element_cpt+1
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row body \">"
		
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
		$HTML_CONTENT:=$HTML_CONTENT+[Pieces_Elements:98]PEL_Libelle:2
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
		
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell iw_padding_right_5px\">"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="PCE"+String:C10($piece_id)+"_"+String:C10($element_cpt)
		$TB_HTML{$o}{4}:=$enum_etat
		$TB_HTML{$o}{5}:="Durée de location (années)"
		$TB_HTML{$o}{6}:="PCE"+String:C10($piece_id)+"_"+String:C10($element_cpt)
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
		$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
		
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"cell\">"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="PCC"+String:C10($piece_id)+"_"+String:C10($element_cpt)
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Durée de location (années)"
		$TB_HTML{$o}{6}:="PCC"+String:C10($piece_id)+"_"+String:C10($element_cpt)
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"
		$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
		
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
		
		
		NEXT RECORD:C51([Pieces_Elements:98])
	End while 
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="textarea"
	$TB_HTML{$o}{3}:="eli_commentaires_p"+String:C10($piece_id)
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Autres commentaires"
	$TB_HTML{$o}{6}:="eli_commentaires_p"+String:C10($piece_id)
	$TB_HTML{$o}{7}:="fdp_placeholder"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	NEXT RECORD:C51([Inventaire_Pieces_Lignes:100])
End while 

//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// SECTION : SIGNATURE DU BAILLEUR
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content rowB\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre col-12 d-none\">"
$HTML_CONTENT:=$HTML_CONTENT+"SIGNATURE DES PARTIES :"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_half col-6\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre_1\">"
$HTML_CONTENT:=$HTML_CONTENT+"LE BAILLEUR"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"js-signature\"></div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_half col-6\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"section_titre_1\">"
$HTML_CONTENT:=$HTML_CONTENT+"LE LOCATAIRE PRINCIPAL"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"js-signature\"></div>"
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
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="etl_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_id"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cpt_pieces"
$TB_HTML{$o}{4}:=String:C10($cpt_pieces)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cpt_pieces"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cpt_chambres"
$TB_HTML{$o}{4}:=String:C10([Inventaire_Pieces:96]INV_Chambres:2)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cpt_chambres"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cpt_salle_de_bain"
$TB_HTML{$o}{4}:=String:C10([Inventaire_Pieces:96]INV_Salle_de_bain:4)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cpt_salle_de_bain"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected_etl"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected_etl"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_etl"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_etl"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id_etl"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id_etl"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_etl"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_etl"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="etl_post_action"
$TB_HTML{$o}{4}:=$post_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_post_action"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="etl_get_action"
$TB_HTML{$o}{4}:=$get_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_get_action"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="etl_signature"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_signature"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="etl_entree_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="etl_entree_id"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</form>"
$0:=$HTML_CONTENT