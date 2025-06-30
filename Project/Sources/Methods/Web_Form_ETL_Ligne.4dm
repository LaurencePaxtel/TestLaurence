//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-05-19, 08:55:18
// ----------------------------------------------------
// Method: Web_Form_ETL_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $section; SCRIPT)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

$section:=$1

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="etl_ligne_"+$section
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="etl_ligne_"+$section
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

PARAM_MANDATORY_FIELDS:=""

C_TEXT:C284($libelle)
ARRAY TEXT:C222($tb_enum_values; 0)


Case of 
	: ($section="section_1")
		
		ARRAY TEXT:C222($tb_enum_values; 0)
		APPEND TO ARRAY:C911($tb_enum_values; "Entrée")
		APPEND TO ARRAY:C911($tb_enum_values; "Sortie")
		$libelle:=";;"
		
		For ($i; 1; Size of array:C274($tb_enum_values))
			$libelle:=$libelle+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
		End for 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="etl_type"
		$TB_HTML{$o}{4}:=$libelle
		$TB_HTML{$o}{5}:="Type de l'état des lieux"
		$TB_HTML{$o}{6}:="etl_type"
		$TB_HTML{$o}{7}:="fdp_span3  span7 fdp_row_start iw_cg_width_third"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_date"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Date"
		$TB_HTML{$o}{6}:="etl_date"
		$TB_HTML{$o}{7}:="span7 search  datepicker  iw_cg_width_third "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_bien_type"
		$TB_HTML{$o}{4}:=[Inventaire_Pieces:96]INV_Type:6
		$TB_HTML{$o}{5}:="Type du bien"
		$TB_HTML{$o}{6}:="etl_bien_type"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third readonly"
		
		
	: ($section="section_2")
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_electricite_no_compteur"
		$TB_HTML{$o}{4}:=[Inventaire_Pieces:96]INV_Electricite_No_Compteur:11
		$TB_HTML{$o}{5}:="Numéro du compteur"
		$TB_HTML{$o}{6}:="etl_electricite_no_compteur"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third readonly"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_electricite_releve_hp"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Relevé HP"
		$TB_HTML{$o}{6}:="etl_electricite_releve_hp"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_electricite_releve_hc"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Relevé HC"
		$TB_HTML{$o}{6}:="etl_electricite_releve_hc"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third "
		
	: ($section="section_3")
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_gaz_naturel_no_compteur"
		$TB_HTML{$o}{4}:=[Inventaire_Pieces:96]INV_Gaz_Naturel_No_Compteur:12
		$TB_HTML{$o}{5}:="Numéro du compteur"
		$TB_HTML{$o}{6}:="etl_gaz_naturel_no_compteur"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half readonly"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_gaz_naturel_releve"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Relevé du compteur"
		$TB_HTML{$o}{6}:="etl_gaz_naturel_releve"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
	: ($section="section_4")
		
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_eau_froide_releve"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Eau froide (relévé m3)"
		$TB_HTML{$o}{6}:="etl_eau_froide_releve"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="etl_eau_chaude_releve"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Eau chaude (relévé m3)"
		$TB_HTML{$o}{6}:="etl_eau_chaude_releve"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
	: ($section="section_5")
		C_TEXT:C284($radio_options)
		$radio_options:="etl_chauffage;Électricité;Électricité|etl_chauffage;Gaz naturel;Gaz naturel|etl_chauffage;Collectif;Collectif|etl_chauffage;Autre;Autre"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="iw_radio_group"
		$TB_HTML{$o}{3}:="etl_chauffage"
		$TB_HTML{$o}{4}:=$radio_options
		$TB_HTML{$o}{5}:="Chauffage :"
		$TB_HTML{$o}{6}:="etl_chauffage"
		$TB_HTML{$o}{7}:="fdp_span3 fdp_placeholder iw_cg_width_half"
		
		$radio_options:="etl_eau_chaude;Électricité;Électricité|etl_eau_chaude;Gaz naturel;Gaz naturel|etl_eau_chaude;Collectif;Collectif|etl_eau_chaude;Autre;Autre"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="iw_radio_group"
		$TB_HTML{$o}{3}:="etl_eau_chaude"
		$TB_HTML{$o}{4}:=$radio_options
		$TB_HTML{$o}{5}:="Eau chaude :"
		$TB_HTML{$o}{6}:="etl_eau_chaude"
		$TB_HTML{$o}{7}:="fdp_span3 fdp_placeholder iw_cg_width_half"
End case 

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)