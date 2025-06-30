//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04-02-19, 12:23:25
// ----------------------------------------------------
// Method: Web_Form_Relances_Parametrage
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="relances"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="relances"
$TB_FORM{0}{6}:=""

C_TEXT:C284($disabled)
$disabled:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox_simple"
$TB_HTML{$o}{3}:="hb_nom"
$TB_HTML{$o}{4}:="sin_assurance_pe;Relance sur date d'échéance;"+String:C10([Sinistres:89]SIN_Assurance_PE:6)+"|"
$TB_HTML{$o}{5}:="Relance sur date d'échéance"
$TB_HTML{$o}{6}:="hb_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_cg_width_third"


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_prenom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_FIRST_NAME
$TB_HTML{$o}{6}:="hb_prenom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_datenele"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_DATE_NAISSANCE
$TB_HTML{$o}{6}:="hb_datenele"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7 iw_cg_width_half"



C_TEXT:C284($type_locataire)
$type_locataire:=""

Case of 
	: ([HeBerge:4]HB_Type_Locataire:70="locataire")
		$type_locataire:=";;|locataire_Locataire_s|colocataire_Colocataire"
	: ([HeBerge:4]HB_Type_Locataire:70="colocataire")
		$type_locataire:=";;|Locataire_Locataire|Colocataire_Colocataire_s"
	Else 
		$type_locataire:=";;|Locataire_Locataire|Colocataire_Colocataire"
End case 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="hb_type_locataire"
$TB_HTML{$o}{4}:=$type_locataire
$TB_HTML{$o}{5}:="Type locataire"
$TB_HTML{$o}{6}:="hb_type_locataire"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_email"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Email"
$TB_HTML{$o}{6}:="hb_email"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_telephone"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Téléphone"
$TB_HTML{$o}{6}:="hb_telephone"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hb_locataire"
$TB_HTML{$o}{4}:="true"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_locataire"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:="hb_nom;hb_prenom;hb_datenele"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""



ARRAY TEXT:C222($TB_HTML; $o; 15)


$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)



