//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18-12-18, 08:59:05
// ----------------------------------------------------
// Method: Web_Form_Factures
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284(SCRIPT)
C_LONGINT:C283($o)
C_POINTER:C301($user_type)

ARRAY TEXT:C222($value_at; 0)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1
RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=factures"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="factures"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="factures"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date_du"
$TB_HTML{$o}{4}:=""  //String(Current date(*))
$TB_HTML{$o}{5}:="Date du"
$TB_HTML{$o}{6}:="search_date_du"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker iw_data_column_1"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date_au"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date au"
$TB_HTML{$o}{6}:="search_date_au"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker iw_data_column_2"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_button_icon"
$TB_HTML{$o}{2}:="reset"
$TB_HTML{$o}{3}:="btn_left"
$TB_HTML{$o}{4}:="<i class=\"fa fa-arrow-circle-left\"></i>"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_left"
$TB_HTML{$o}{7}:="iw_cg_btn_icon fdp_Button iw_btn_icon_only fdp-btn-green iw_margin_left_5px iw_btn_icon icon_next"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_button_icon"
$TB_HTML{$o}{2}:="reset"
$TB_HTML{$o}{3}:="btn_next"
$TB_HTML{$o}{4}:="<i class=\"fa fa-arrow-circle-right\"></i>"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_next"
$TB_HTML{$o}{7}:="iw_cg_btn_icon fdp_Button iw_btn_icon_only fdp-btn-green iw_margin_left_5px iw_btn_icon icon_next"

$o:=$o+1
$TB_HTML{$o}{1}:="iw-datepicker"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_mois"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Période"
$TB_HTML{$o}{6}:="search_mois"
$TB_HTML{$o}{7}:="span7 search iw_data_column_3 iw_sg"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_locataire_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Locataire"
$TB_HTML{$o}{6}:="search_locataire_nom"
$TB_HTML{$o}{7}:="span7 search iw_data_column_4"

/*
$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="search_type_facture"

outilsAddToArray(->$value_at; "Tous"; "Facture"; "Avoir")
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$value_at)
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="search_type_facture"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_5"
*/

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="search_export"

outilsAddToArray(->$value_at; "Oui"; "Non")
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$value_at)
$TB_HTML{$o}{5}:="Facture exportée"
$TB_HTML{$o}{6}:="search_export"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_6"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="search_categorie"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML("Catégorie facture")
$TB_HTML{$o}{5}:="Catégorie facture"
$TB_HTML{$o}{6}:="search_categorie"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_locataire_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_locataire_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_destinataire_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_destinataire_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="records_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="records_selected"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	C_POINTER:C301($1)
	COPY ARRAY:C226($TB_HTML; $2->)
End if 