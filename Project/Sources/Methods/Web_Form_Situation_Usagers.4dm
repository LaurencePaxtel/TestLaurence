//%attributes = {}
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 24/12/20, 16:18:22
// ----------------------------------------------------
// Method: Web_Form_Situation_Usagers
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284(SCRIPT; $UID; $disabled)
C_LONGINT:C283($o)
C_POINTER:C301($user_type)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1
$disabled:=""
RECORD_ACT_EDIT:=True:C214

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")
$actionm:=WEB_UTL_GET_PARAMS("actionm")

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="INT?action=situation-financiere-usagers"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="situation-financiere-usagers"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="situation-financiere-usagers"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date_facture_debut"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date du (facture)"
$TB_HTML{$o}{6}:="search_date_facture_debut"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_data_column_0"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_date_facture_fin"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date au (facture)"
$TB_HTML{$o}{6}:="search_date_facture_fin"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_data_column_1"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom de la personne"
$TB_HTML{$o}{6}:="search_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_2"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox"
$TB_HTML{$o}{3}:="search_location_participation_hebergement"
$TB_HTML{$o}{4}:="search_location_participation_hebergement;Location;Location|search_location_participation_hebergement;Hébergement;Hébergement|search_location_participation_hebergement;Participation;Participation"
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="search_location_participation_hebergement"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_num_facture"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="N° facture"
$TB_HTML{$o}{6}:="search_num_facture"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_data_column_4"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_net_a_payer"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Net à payer"
$TB_HTML{$o}{6}:="search_net_a_payer"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_5"

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

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	COPY ARRAY:C226($TB_HTML; $2->)
End if 