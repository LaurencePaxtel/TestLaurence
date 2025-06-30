//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/04/20, 09:43:43
// ----------------------------------------------------
// Method: Web_Form_PLA_Privileges_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="event_ligne_privileges"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="event_ligne_privileges"
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:="pla_priv_usr_nom"


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pla_priv_usr_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom de l'utilisateur"
$TB_HTML{$o}{6}:="pla_priv_usr_nom"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half "


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="filter_utilisateur"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Choix des utilisateurs (filtre)"
$TB_HTML{$o}{6}:="filter_utilisateur"
$TB_HTML{$o}{7}:="fdp_span3  span7 fdp_row_start  "

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="multiple"
$TB_HTML{$o}{3}:="pla_priv_usr_ids"
$TB_HTML{$o}{4}:=WEB_UTL_SET_Choix_Champ(->[INtervenants:10]; ->[INtervenants:10]IN_NomPrénom:8; "UID"; "")
$TB_HTML{$o}{5}:="Choix des utilisateurs"
$TB_HTML{$o}{6}:="pla_priv_usr_ids"
$TB_HTML{$o}{7}:="span3 multiSelectRecherche fdp_placeholder fdp_width100 fdp_row_start iw_cg_width_full iw_stype_groupe"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="pref_readonly"
$TB_HTML{$o}{4}:="Consultation uniqument"
$TB_HTML{$o}{5}:="Consultation uniquement"
$TB_HTML{$o}{6}:="pref_readonly"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="pref_readwrite"
$TB_HTML{$o}{4}:="Consultation et modification"
$TB_HTML{$o}{5}:="Consultation et modification"
$TB_HTML{$o}{6}:="pref_readwrite"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_filtres"


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_privileges"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_privileges"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="pla_priv_usr_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="pla_priv_usr_id"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)

