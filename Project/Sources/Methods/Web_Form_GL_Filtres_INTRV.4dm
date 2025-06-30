//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20-05-28, 14:36:23
// ----------------------------------------------------
// Method: Web_Form_GL_Filtres_INTRV
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SCRIPT; $disabled)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

$disabled:=""
RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=interventions"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="interventions"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="interventions"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_0"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom immeuble"
$TB_HTML{$o}{6}:="search_filtre_0"
$TB_HTML{$o}{7}:="span7 search  iw_cg_width_sextuplet iw_data_column_0"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_1"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom logement"
$TB_HTML{$o}{6}:="search_filtre_1"
$TB_HTML{$o}{7}:="span7 search  iw_cg_width_sextuplet iw_data_column_1"

C_TEXT:C284($enum_values)
ARRAY TEXT:C222($tb_enum_values; 0)

$values_c:=UTL_Web_Get_Enumeration_Values("GI: Types interventions")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$enum_values:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="search_filtre_2"
$TB_HTML{$o}{4}:=$enum_values
$TB_HTML{$o}{5}:="Type  d'intervention"
$TB_HTML{$o}{6}:="search_filtre_2"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_sextuplet search iw_data_column_2 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_3"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom intervenant"
$TB_HTML{$o}{6}:="search_filtre_3"
$TB_HTML{$o}{7}:="span7 search  iw_cg_width_sextuplet iw_data_column_3 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_4"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date de début"
$TB_HTML{$o}{6}:="search_filtre_4"
$TB_HTML{$o}{7}:="span7 search datepicker iw_cg_width_sextuplet iw_data_column_4 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_5"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date de début"
$TB_HTML{$o}{6}:="search_filtre_5"
$TB_HTML{$o}{7}:="span7 search datepicker iw_cg_width_sextuplet iw_data_column_5 "

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

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)





