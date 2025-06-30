//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 11/06/2020, 17:46:32
// ----------------------------------------------------
// Method: Web_Form_GI_Intervenant
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284(SCRIPT; $type)
C_LONGINT:C283($o)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$type:=$1

FIX_DATE_FORMAT:="dd/mm/yyyy"
PARAM_MANDATORY_FIELDS:=UTL_Field_Name(->[GI_Intervenants:110]GII_Nom:3)+";"+UTL_Field_Name(->[GI_Intervenants:110]GII_Prenom:4)

RECORD_ACT_EDIT:=True:C214

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="form_intn"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="form_intn"
$TB_FORM{0}{6}:="iw_piece_ligne"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[GI_Intervenants:110]GII_Nom:3)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[GI_Intervenants:110]GII_Nom:3)
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third fdp_row_start"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[GI_Intervenants:110]GII_Prenom:4)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Prénom"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[GI_Intervenants:110]GII_Prenom:4)
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_Field_Name(->[GI_Intervenants:110]GII_Societe:5)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Société"
$TB_HTML{$o}{6}:=UTL_Field_Name(->[GI_Intervenants:110]GII_Societe:5)
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne_intervenant"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne_intervenant"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)