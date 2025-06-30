//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 10-01-19, 18:47:12
// ----------------------------------------------------
// Method: Web_Form_GL_Biens
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($o)
C_POINTER:C301($user_type)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$user_type:=$1

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=biens"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="biens"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="biens"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom du bien"
$TB_HTML{$o}{6}:="search_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_0"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="search_proprietaire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom du propriétaire"
$TB_HTML{$o}{6}:="search_proprietaire"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_1"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox"
$TB_HTML{$o}{3}:="search_bien_statut"
$TB_HTML{$o}{4}:="search_bien_statut;Actif;true|search_bien_statut;Inactif;Inactif|search_bien_statut;Tous;Tous"
$TB_HTML{$o}{5}:="Statut"
$TB_HTML{$o}{6}:="search_bien_statut"
$TB_HTML{$o}{7}:="span7 fdp_placeholder iw_data_column_2"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_proprietaire_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_proprietaire_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="search_bien_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="search_bien_id"
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

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	COPY ARRAY:C226($TB_HTML; $2->)
End if 