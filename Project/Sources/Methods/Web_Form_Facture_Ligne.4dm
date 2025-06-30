//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 23-12-18, 10:41:23
// ----------------------------------------------------
// Method: Web_Form_Facture_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($type_popup; $disabled)
C_LONGINT:C283($o)
C_POINTER:C301($id)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$type_popup:=$2
$id:=$1

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

//$privileges_facturation:=Web_User_Check_Privilege("Privilege Facturation Web")

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="facture_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="facture_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:=""

//Si ($privileges_facturation)

If ([Factures:86]FAC_Cloture:10=False:C215)
	PARAM_MANDATORY_FIELDS:="facl_titre;facl_quantite;facl_montant_ttc"
Else 
	$disabled:="readonly"
End if 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="facl_titre"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML("Produits")
$TB_HTML{$o}{5}:="Titre"
$TB_HTML{$o}{6}:="facl_titre"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_full "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_libelle"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Description"
$TB_HTML{$o}{6}:="facl_libelle"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_full "+$disabled

If ($type_popup="")
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="facl_date_du"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Du"
	$TB_HTML{$o}{6}:="facl_date_du"
	$TB_HTML{$o}{7}:="fdp_span3  span7 datepicker readonly"+$disabled
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="facl_date_au"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Au"
	$TB_HTML{$o}{6}:="facl_date_au"
	$TB_HTML{$o}{7}:="fdp_span3  span7 datepicker readonly"+$disabled
End if 

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_quantite"
$TB_HTML{$o}{4}:=""

If ($type_popup="")
	$TB_HTML{$o}{5}:="Quantité (nombre de jours)"
	$TB_HTML{$o}{6}:="facl_quantite"
	$TB_HTML{$o}{7}:="fdp_span3 span7 readonly "+$disabled
Else 
	$TB_HTML{$o}{5}:="Quantité"
	$TB_HTML{$o}{6}:="facl_quantite"
	$TB_HTML{$o}{7}:="fdp_span3 span7"
End if 

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_prix_unit_ht"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Prix Unitaire HT"
$TB_HTML{$o}{6}:="facl_prix_unit_ht"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_remise_taux"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="% de remise"
$TB_HTML{$o}{6}:="facl_remise_taux"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_prix_unit_net"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Prix Unitaire Net"
$TB_HTML{$o}{6}:="facl_prix_unit_net"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_remise_montant"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant remise"
$TB_HTML{$o}{6}:="facl_remise_montant"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_montant_ht"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant HT"
$TB_HTML{$o}{6}:="facl_montant_ht"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_taux_tva"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Taux TVA"
$TB_HTML{$o}{6}:="facl_taux_tva"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_display_none iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_montant_tva"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant TVA"
$TB_HTML{$o}{6}:="facl_montant_tva"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_display_none iw_number "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_acompte"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Acompte (Mt. dépôt de garantie encaissé)"
$TB_HTML{$o}{6}:="facl_acompte"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="facl_montant_ttc"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant TTC"
$TB_HTML{$o}{6}:="facl_montant_ttc"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="loc_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="facl_service_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="facl_service_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="facl_type"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="facl_type"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)