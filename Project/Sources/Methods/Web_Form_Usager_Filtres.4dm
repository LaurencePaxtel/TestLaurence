//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 23/10/19, 07:43:21
// ----------------------------------------------------
// Method: Web_Form_Usager_Filtres
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $html)
ARRAY TEXT:C222($TB_HTML; 150; 15)
C_LONGINT:C283($o)

$o:=0
$html:=$1

$html->:=$html->+"<div id=\"usager-btns\" class=\"span12 fdp_boutons iw_btns_usager_filtres\" style=\"display: none;\">"
$html->:=$html->+"<div class=\"btn-wrapper\">"

$html->:=$html->+"<div class=\"control-group iw_filtres\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Jour"
$TB_HTML{$o}{6}:="Jour"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_famchef"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamChef:103)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famchef"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_read_only  "
$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html->:=$html->+"</div>"

$html->:=$html->+"<div class=\"control-group iw_filtres\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Prestations"
$TB_HTML{$o}{6}:="Prestations"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_famchef"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamChef:103)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famchef"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres  "
$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html->:=$html->+"</div>"


$html->:=$html->+"<div class=\"control-group iw_filtres\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Jour + Prestation"
$TB_HTML{$o}{6}:="Jour + Prestation"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_famchef"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamChef:103)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famchef"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_read_only  "
$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html->:=$html->+"</div>"


$html->:=$html->+"</div>"
$html->:=$html->+"</div>"