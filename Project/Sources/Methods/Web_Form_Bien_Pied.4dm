//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20/05/27, 18:53:50
// ----------------------------------------------------
// Method: Web_Form_Bien_Pied
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($HTML_CONTENT; FIX_DATE_FORMAT)

ARRAY TEXT:C222($TB_HTML; 150; 15)
C_LONGINT:C283($o)
$o:=0

WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:=""

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_third\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_third  iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant HT"
$TB_HTML{$o}{6}:="Montant HT"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bien_montant_ht"
$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Taux_Remise:4)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="bien_montant_ht"
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_third  iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant TVA"
$TB_HTML{$o}{6}:="Montant TVA"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bien_montant_ht"
$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Taux_Remise:4)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="bien_montant_ht"
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group    iw_third iw_side_by_side\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant TTC"
$TB_HTML{$o}{6}:="Montant TTC"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bien_montant_ht"
$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Taux_Remise:4)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="bien_montant_ht"
$TB_HTML{$o}{7}:="span7 search readonly"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$0:=$HTML_CONTENT