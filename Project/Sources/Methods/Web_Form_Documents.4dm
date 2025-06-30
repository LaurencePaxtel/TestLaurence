//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-04-19, 13:34:01
// ----------------------------------------------------
// Method: Web_Form_Documents
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($document_type)
C_LONGINT:C283($o)
C_POINTER:C301($user_type)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($tb_enum_values; 0)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=base_documentaire"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="base_documentaire"
$TB_FORM{0}{4}:="iw_form_medium"
$TB_FORM{0}{5}:="base_documentaire"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_0"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Titre du document"
$TB_HTML{$o}{6}:="search_filtre_0"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_quarte iw_data_column_0 "

$values_c:=UTL_Web_Get_Enumeration_Values("Locations: types des documents")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 


$document_type:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$document_type:=$document_type+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="search_filtre_1"
$TB_HTML{$o}{4}:=$document_type
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="search_filtre_1"
$TB_HTML{$o}{7}:="fdp_span3  search span7  iw_cg_width_quarte iw_data_column_1 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_2"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Immeuble"
$TB_HTML{$o}{6}:="search_filtre_2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_quarte iw_data_column_2 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_3"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Logement"
$TB_HTML{$o}{6}:="search_filtre_3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_quarte iw_data_column_3 "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_filtre_4"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Intervention"
$TB_HTML{$o}{6}:="search_filtre_4"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_quarte iw_data_column_4 "

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

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	COPY ARRAY:C226($TB_HTML; $2->)
End if 