//%attributes = {}
// ----------------------------------------------------
// User name (OS): KEVIN HASSAL
// Date and time: 20/05/26, 16:45:35
// ----------------------------------------------------
// Method: Web_Form_Pieces_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $post_action; $2; $get_action; SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

$post_action:=$1
$get_action:=$2

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="bien_pieces_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="bien_pieces_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pie_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom"
$TB_HTML{$o}{6}:="pie_nom"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pie_capacite"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Capacité"
$TB_HTML{$o}{6}:="pie_capacite"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pie_superficie"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Superficie"
$TB_HTML{$o}{6}:="pie_superficie"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="ligne_id_bien_piece"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ligne_id_bien_piece"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_pieces"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_pieces"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="pieces_post_action"
$TB_HTML{$o}{4}:=$post_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="pieces_post_action"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="pieces_get_action"
$TB_HTML{$o}{4}:=$get_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="pieces_get_action"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)

