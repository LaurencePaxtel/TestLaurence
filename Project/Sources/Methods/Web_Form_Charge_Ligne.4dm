//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30-01-19, 27:10:43
// ----------------------------------------------------
// Method: Web_Form_Charge_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($post_action; $get_action; SCRIPT; $disabled)
C_LONGINT:C283($o)
C_BOOLEAN:C305($lk_gb)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
ARRAY TEXT:C222($tb_enum_values; 0)

$post_action:=$1
$get_action:=$2
$lk_gb:=$3

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="charge_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="charge_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:="cha_libelle;cha_montant;cha_periode;cha_periode_fin"

If ($lk_gb)
	PARAM_MANDATORY_FIELDS:=PARAM_MANDATORY_FIELDS+"field_immeuble_nom;field_immeuble_id;field_bien_nom;field_bien_id"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="field_immeuble_nom"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Immeuble"
	$TB_HTML{$o}{6}:="field_immeuble_nom"
	$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="field_bien_nom"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Logement"
	$TB_HTML{$o}{6}:="field_bien_nom"
	$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half  "
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="field_immeuble_id"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="field_immeuble_id"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="field_bien_id"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="field_bien_id"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="id_selected"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="id_selected"
	$TB_HTML{$o}{7}:=""
End if 

$values_c:=UTL_Web_Get_Enumeration_Values("Locations: Charges")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 


outilsAddToArray(->$tb_enum_values; "Régularisation des charges"; "Assurance logement"; "Régularisation assurance logement"; "Autres")
outilsArrayDistinct(->$tb_enum_values)

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="cha_libelle"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$tb_enum_values)
$TB_HTML{$o}{5}:="Type de la charge"
$TB_HTML{$o}{6}:="cha_libelle"
$TB_HTML{$o}{7}:="fdp_span3  span7 fdp_row_start iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="cha_montant"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant"
$TB_HTML{$o}{6}:="cha_montant"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="iw-datepicker"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="cha_periode"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Veuillez choisir le mois de début"
$TB_HTML{$o}{6}:="cha_periode"
$TB_HTML{$o}{7}:="span7 search iw_cg_width_half fdp_row_start datepicker"

$o:=$o+1
$TB_HTML{$o}{1}:="iw-datepicker"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="cha_periode_fin"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Veuillez choisir le mois de fin"
$TB_HTML{$o}{6}:="cha_periode_fin"
$TB_HTML{$o}{7}:="fdp_span3 span7 search iw_cg_width_half datepicker"

// Modifié par : Scanu Rémy (04/04/2023)
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="number"
$TB_HTML{$o}{3}:="cha_account_product"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Compte comptable"
$TB_HTML{$o}{6}:="cha_account_product"
$TB_HTML{$o}{7}:="fdp_row_start fdp_span3 span7 iw_cg_width_half disabled"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_charge"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_charge"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cha_post_action"
$TB_HTML{$o}{4}:=$post_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cha_post_action"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="cha_get_action"
$TB_HTML{$o}{4}:=$get_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="cha_get_action"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)