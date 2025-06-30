//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 05-05-19, 08:13:32
// ----------------------------------------------------
// Method: Web_Form_Pieces_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($post_action; $get_action)
C_LONGINT:C283($o)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($tb_enum_values; 0)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$post_action:=$1
$get_action:=$2

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="pieces_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="pieces_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:=""

//=========================================//
// Type du bien
//=========================================//
$values_c:=UTL_Web_Get_Enumeration_Values("Locations: Type du bien")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="inv_type"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$tb_enum_values)
$TB_HTML{$o}{5}:="Type du bien"
$TB_HTML{$o}{6}:="inv_type"
$TB_HTML{$o}{7}:="fdp_span3  span7 fdp_row_start iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="inv_surface"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Surface (m²)"
$TB_HTML{$o}{6}:="inv_surface"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="inv_pieces_principales"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nombre des pièces principales"
$TB_HTML{$o}{6}:="inv_pieces_principales"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

//=========================================//
// Nbre des chambres
//=========================================//
CLEAR VARIABLE:C89($tb_enum_values)
outilsAddToArray(->$tb_enum_values; "1"; "2"; "3"; "4"; "5")

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="inv_chambres"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$tb_enum_values)
$TB_HTML{$o}{5}:="Nombre des chambres"
$TB_HTML{$o}{6}:="inv_chambres"
$TB_HTML{$o}{7}:="fdp_span3  span7 fdp_row_start iw_cg_width_third"

//=========================================//
// Nbre des salles de bain
//=========================================//
CLEAR VARIABLE:C89($tb_enum_values)
outilsAddToArray(->$tb_enum_values; "1"; "2")

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="inv_salle_de_bain"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$tb_enum_values)
$TB_HTML{$o}{5}:="Nombre des salles de bain"
$TB_HTML{$o}{6}:="inv_salle_de_bain"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

//=========================================//
// Nbre des WC
//=========================================//
CLEAR VARIABLE:C89($tb_enum_values)
outilsAddToArray(->$tb_enum_values; "1"; "2")

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="inv_wc"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$tb_enum_values)
$TB_HTML{$o}{5}:="Nombre des WC"
$TB_HTML{$o}{6}:="inv_wc"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="inv_electricite_no_compteur"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Numéro du compteur électrique"
$TB_HTML{$o}{6}:="inv_electricite_no_compteur"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="inv_gaz_naturel_no_compteur"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Numéro du compteur du gaz naturel"
$TB_HTML{$o}{6}:="inv_gaz_naturel_no_compteur"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="inv_eau_no_compteur"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Numéro du compteur d'eau"
$TB_HTML{$o}{6}:="inv_eau_no_compteur"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="ligne_id_inventaire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ligne_id_inventaire"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_inventaire"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_inventaire"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="inventaire_post_action"
$TB_HTML{$o}{4}:=$post_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="inventaire_post_action"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="inventaire_get_action"
$TB_HTML{$o}{4}:=$get_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="inventaire_get_action"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)