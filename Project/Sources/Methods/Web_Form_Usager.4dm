//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 02/12/18, 22:38:17
// ----------------------------------------------------
// Méthode : Web_Form_Usager
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($UID; $type_locataire; $destination_facture)
C_LONGINT:C283($o)

C_TEXT:C284(SCRIPT; class_invalid_password; class_invalid_email; class_invalid_first_name; class_invalid_last_name; class_invalid_communication; class_invalid_email; class_invalid_lien_famille)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

RECORD_ACT_EDIT:=True:C214

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")
$actionm:=WEB_UTL_GET_PARAMS("actionm")

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="usager"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="usager"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=LANG_TXT_LAST_NAME
$TB_HTML{$o}{6}:="hb_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_cg_width_half"

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

$destination_facture:=";;|Centre_Centre|Locataire_Locataire|Propriétaire_Propriétaire"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="hb_fac_destation"
$TB_HTML{$o}{4}:=$destination_facture
$TB_HTML{$o}{5}:="Facturer à l'adresse du"
$TB_HTML{$o}{6}:="hb_fac_destation"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="HB_FAC_Dette_Initiale"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Dette initiale"
$TB_HTML{$o}{6}:="HB_FAC_Dette_Initiale"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_compte_comptable"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Compte comptable"
$TB_HTML{$o}{6}:="hb_compte_comptable"
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