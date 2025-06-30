//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 10-01-19, 22:09:28
// ----------------------------------------------------
// Method: Web_Form_Sinistre_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $post_action; $2; $get_action; SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)
C_BOOLEAN:C305($lk_gb)

$post_action:=$1
$get_action:=$2
$lk_gb:=$3

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="sinistre_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="sinistre_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:=""


If ($lk_gb)
	
	PARAM_MANDATORY_FIELDS:=PARAM_MANDATORY_FIELDS+"field_immeuble_nom;field_immeuble_id;field_bien_nom;field_bien_id"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="field_immeuble_nom"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Immeuble"
	$TB_HTML{$o}{6}:="field_immeuble_nom"
	$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="field_bien_nom"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Logement"
	$TB_HTML{$o}{6}:="field_bien_nom"
	$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half  "
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="field_immeuble_id"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="field_immeuble_id"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="field_bien_id"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="field_bien_id"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="id_selected"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="id_selected"
	$TB_HTML{$o}{7}:=""
	
End if 

C_TEXT:C284($libelle_sinistre)
ARRAY TEXT:C222($tb_enum_values; 0)

$values_c:=UTL_Web_Get_Enumeration_Values("Locations: Sinistres")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$libelle_sinistre:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$libelle_sinistre:=$libelle_sinistre+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="sin_libelle"
$TB_HTML{$o}{4}:=$libelle_sinistre
$TB_HTML{$o}{5}:="Libellé du sinistre"
$TB_HTML{$o}{6}:="sin_libelle"
$TB_HTML{$o}{7}:="fdp_span3  span7 fdp_row_start iw_cg_width_full"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="sin_date"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date sinistre"
$TB_HTML{$o}{6}:="sin_date"
$TB_HTML{$o}{7}:="span7 search  datepicker  iw_cg_width_third "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="sin_cout"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Coût"
$TB_HTML{$o}{6}:="sin_cout"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox_simple"
$TB_HTML{$o}{3}:="sin_assurance_pe"
$TB_HTML{$o}{4}:="sin_assurance_pe;Prise en charge d'assurance;"+String:C10([Sinistres:89]SIN_Assurance_PE:6)+"|"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="sin_assurance_pe"
$TB_HTML{$o}{7}:="iw_label iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="sin_assurance_montant"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant de remboursement"  // d'assurance
$TB_HTML{$o}{6}:="sin_assurance_montant"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third fdp_row_start  "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="sin_assurance_contrat_no"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Numéro du sinistre"
$TB_HTML{$o}{6}:="sin_assurance_contrat_no"
$TB_HTML{$o}{7}:="span7 search  iw_cg_width_third "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox_simple"
$TB_HTML{$o}{3}:="sin_travaux_cloture"
$TB_HTML{$o}{4}:="sin_travaux_cloture;Travaux clôturés;"+String:C10([Sinistres:89]SIN_Assurance_PE:6)+"|"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="sin_travaux_cloture"
$TB_HTML{$o}{7}:="iw_label iw_cg_width_third "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="sin_assurance_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom d'assurance"
$TB_HTML{$o}{6}:="sin_assurance_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_full "+$disabled

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="ad_adresse1"
$TB_HTML{$o}{4}:=[Adresses:53]AD_Adresse1:16
$TB_HTML{$o}{5}:="Adresse"
$TB_HTML{$o}{6}:="ad_adresse1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="ad_adresse2"
$TB_HTML{$o}{4}:=[Adresses:53]AD_Adresse2:17
$TB_HTML{$o}{5}:="Adresse ligne 2"
$TB_HTML{$o}{6}:="ad_adresse2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="ad_adresse3"
$TB_HTML{$o}{4}:=[Adresses:53]AD_Adresse3:18
$TB_HTML{$o}{5}:="Adresse ligne 3"
$TB_HTML{$o}{6}:="ad_adresse3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="ad_code_postal"
$TB_HTML{$o}{4}:=[Adresses:53]AD_Code_postal:19
$TB_HTML{$o}{5}:="Code postal"
$TB_HTML{$o}{6}:="ad_code_postal"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="ad_ville"
$TB_HTML{$o}{4}:=[Adresses:53]AD_Ville:20
$TB_HTML{$o}{5}:="Ville"
$TB_HTML{$o}{6}:="ad_ville"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_half"

// Modifié par : Scanu Rémy (29/06/2023)
// Ajout bloc commentaire
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="sin_commentaire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Commentaire"
$TB_HTML{$o}{6}:="sin_commentaire"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_full fdp_row_start "

//--------------------**
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="adr_uid_origine"
$TB_HTML{$o}{4}:=String:C10([Sinistres:89]ID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="adr_uid_origine"
$TB_HTML{$o}{7}:=""

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
$TB_HTML{$o}{3}:="sin_post_action"
$TB_HTML{$o}{4}:=$post_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="sin_post_action"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="sin_get_action"
$TB_HTML{$o}{4}:=$get_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="sin_get_action"
$TB_HTML{$o}{7}:=""


ARRAY TEXT:C222($TB_HTML; $o; 15)


$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
