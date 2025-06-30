//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-01-19, 08:41:12
// ----------------------------------------------------
// Method: Web_Form_Recherche_Sinistres
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($disabled; SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=sinistres"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="sinistres"
$TB_FORM{0}{4}:="POST"
$TB_FORM{0}{5}:="sinistres"
$TB_FORM{0}{6}:=""

$disabled:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_0"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Immeuble"
$TB_HTML{$o}{6}:="search_filtre_0"
$TB_HTML{$o}{7}:="fdp_span3 search span7 iw_cg_width_quarte iw_data_column_0 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_1"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Logement"
$TB_HTML{$o}{6}:="search_filtre_1"
$TB_HTML{$o}{7}:="fdp_span3  search span7 iw_cg_width_quarte  iw_data_column_1 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_filtre_0_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_filtre_0_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_filtre_1_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_filtre_1_id"
$TB_HTML{$o}{7}:=""


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)



