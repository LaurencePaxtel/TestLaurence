//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 08:32:50
// ----------------------------------------------------
// Method: Web_Form_Event_HG
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($o; $Ecran_Saisie_STR_No)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

//TRACE
//Debut_DecVarChampAttribut 
RECORD_ACT_EDIT:=True:C214
$Ecran_Saisie_STR_No:=30112

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="event_ligne_hg"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="event_ligne_hg"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:=""

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Centre d'hébergement")

$o:=$o+1
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
$TB_HTML{$o}{3}:="eve_centre_hg"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="eve_centre_hg"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half"+WEB_CHAMP_Saisissable

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Groupe")

$o:=$o+1
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
$TB_HTML{$o}{3}:="eve_groupe_hg"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="eve_groupe_hg"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half"+WEB_CHAMP_Saisissable
//end fiche

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_line_hg"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_line_hg"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)