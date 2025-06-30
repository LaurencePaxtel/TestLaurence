//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): KEVIN HASSAL
// Date and time: 20/05/27, 12:10:39
// ----------------------------------------------------
// Method: Web_Form_GI_Equipement
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $type_form; SCRIPT; $enum_values : Text
var $o; $i : Integer

var $equipement_es : cs:C1710.EquipementSelection

ARRAY TEXT:C222($TB_FORM; 0; 6)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($tb_enum_values; 0)

If (Count parameters:C259>0)
	$type_form:=$1
End if 

RECORD_ACT_EDIT:=True:C214
FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="gl_equipement"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="gl_equipement"
$TB_FORM{0}{6}:="iw_piece_ligne"

Case of 
	: ($type_form="")
		PARAM_MANDATORY_FIELDS:="equ_type;equ_nom"
		
		$values_c:=UTL_Web_Get_Enumeration_Values("GI: Types des équipements")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
		End if 
		
		$enum_values:=";;"
		
		For ($i; 1; Size of array:C274($tb_enum_values))
			$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
		End for 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="equ_type"
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="Type"
		$TB_HTML{$o}{6}:="equ_type"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_nom"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Nom"
		$TB_HTML{$o}{6}:="equ_nom"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_reference_fabricant"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Référence fabricant"
		$TB_HTML{$o}{6}:="equ_reference_fabricant"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third fdp_row_start "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_reference_structure"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Référence structure"
		$TB_HTML{$o}{6}:="equ_reference_structure"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third "
		
		ARRAY TEXT:C222($tb_enum_values; 0)
		$values_c:=UTL_Web_Get_Enumeration_Values("GI: Garantie")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
		End if 
		
		
		$enum_values:=";;"
		
		For ($i; 1; Size of array:C274($tb_enum_values))
			$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
		End for 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="equ_garantie"
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="Garantie"
		$TB_HTML{$o}{6}:="equ_garantie"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third  "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_date_achat"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Date d'achat"
		$TB_HTML{$o}{6}:="equ_date_achat"
		$TB_HTML{$o}{7}:="fdp_span3  span7 datepicker  iw_cg_width_quarte  fdp_row_start"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_prix_achat_ht"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Prix d'achat HT"
		$TB_HTML{$o}{6}:="equ_prix_achat_ht"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte "
		
		ARRAY TEXT:C222($tb_enum_values; 0)
		$values_c:=UTL_Web_Get_Enumeration_Values("TVA")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
		End if 
		
		$enum_values:=";;"
		
		For ($i; 1; Size of array:C274($tb_enum_values))
			$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
		End for 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="equ_tva"
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="TVA"
		$TB_HTML{$o}{6}:="equ_tva"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_quarte "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_prix_achat_ttc"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Prix d'achat TTC"
		$TB_HTML{$o}{6}:="equ_prix_achat_ttc"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte "
		
		$values_c:=UTL_Web_Get_Enumeration_Values("GI: Quantité initiale")
		If ($values_c.length#0)
			COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
		End if 
		
		
		$enum_values:=";;"
		
		For ($i; 1; Size of array:C274($tb_enum_values))
			$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
		End for 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="equ_quantite_initiale"
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="Quantité initiale"
		$TB_HTML{$o}{6}:="equ_quantite_initiale"
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_quarte fdp_row_start"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="var_quantite_encours"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Quantité en cours"
		$TB_HTML{$o}{6}:="var_quantite_encours"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte readonly"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="var_quantite_sortie"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Quantité sortie"
		$TB_HTML{$o}{6}:="var_quantite_sortie"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte readonly "
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="equ_stock_min"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Le stock minimum"
		$TB_HTML{$o}{6}:="equ_stock_min"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte "
	: ($type_form="LK") | ($type_form="LK_GB")
		PARAM_MANDATORY_FIELDS:="equ_type;equ_id;quantite;dateinstallation"
		
		If ($type_form="LK_GB")
			$o:=$o+1
			$TB_HTML{$o}{1}:="input"
			$TB_HTML{$o}{2}:="text"
			$TB_HTML{$o}{3}:="field_immeuble_nom"
			$TB_HTML{$o}{4}:=""
			$TB_HTML{$o}{5}:="Immeuble"
			$TB_HTML{$o}{6}:="field_immeuble_nom"
			$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half"
			
			$o:=$o+1
			$TB_HTML{$o}{1}:="input"
			$TB_HTML{$o}{2}:="text"
			$TB_HTML{$o}{3}:="field_bien_nom"
			$TB_HTML{$o}{4}:=""
			$TB_HTML{$o}{5}:="Logement"
			$TB_HTML{$o}{6}:="field_bien_nom"
			$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half"
			
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
		End if 
		
		// Modifié par : Scanu Rémy (27/07/2022)
		// On ne prends plus en compte la table Piece mais on a un lien directement entre [Equipement] et Bien ([LesCentres])
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="equ_type"
		$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML("GI: Types des équipements")
		$TB_HTML{$o}{5}:="Type de l'équipement"
		$TB_HTML{$o}{6}:="equ_type"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half fdp_row_start"
		
		READ ONLY:C145([Equipement:107])
		
		QUERY:C277([Equipement:107]; [Equipement:107]EQU_Nom:4#"")
		MultiSoc_Filter(->[Equipement:107])
		
		$enum_values:=";;"
		
		While (Not:C34(End selection:C36([Equipement:107])))
			// Modifié par : Scanu Rémy (02/08/2022)
			//$enum_values:=$enum_values+"|"+Chaîne([Equipement]ID)+"_"+[Equipement]EQU_Nom
			$enum_values:=$enum_values+"|"+String:C10([Equipement:107]EQU_Nom:4)+"_"+[Equipement:107]EQU_Nom:4
			
			NEXT RECORD:C51([Equipement:107])
		End while 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="equ_id"
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="Nom de l'équipement"
		$TB_HTML{$o}{6}:="equ_id"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half"
		
		// Modifié par : Scanu Rémy (03/07/2024)
		$equipement_es:=Create entity selection:C1512([Equipement:107])
		w_visiteur.equipement:=$equipement_es.toCollection()
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="hidden"
		$TB_HTML{$o}{3}:="equipementID"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:=""
		$TB_HTML{$o}{6}:="equipementID"
		$TB_HTML{$o}{7}:=""
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="dateInstallation"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Date d'installation"
		$TB_HTML{$o}{6}:="dateInstallation"
		$TB_HTML{$o}{7}:="fdp_span3 span7 datepicker iw_cg_width_half fdp_row_start"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="quantite"
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Quantité"
		$TB_HTML{$o}{6}:="quantite"
		$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half"
End case 

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_equipement"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_equipement"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)