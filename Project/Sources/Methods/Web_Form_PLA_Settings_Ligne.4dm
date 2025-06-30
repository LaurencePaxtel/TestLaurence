//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 15:14:51
// ----------------------------------------------------
// Method: Web_Form_PLA_Settings_Ligne
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
$TB_FORM{0}{3}:="psettings_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="settings_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:="pref_sms_token;pref_sms_sender;pref_sms_message"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pref_sms_token"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Token"
$TB_HTML{$o}{6}:="pref_sms_token"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_full"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="pref_sms_sender"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Émetteur"
$TB_HTML{$o}{6}:="pref_sms_sender"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="pref_sms_message"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Message"
$TB_HTML{$o}{6}:="pref_sms_message"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_full"



$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_config"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_config"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)

