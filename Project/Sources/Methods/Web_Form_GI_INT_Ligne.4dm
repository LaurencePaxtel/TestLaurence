//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 04/06/2020, 15:34:27
// ----------------------------------------------------
// Method: Web_Form_GI_INT_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(SCRIPT; $1; $type; $prefixe)
C_LONGINT:C283($o; $i)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$type:=$1
$prefixe:=""
$o:=0

RECORD_ACT_EDIT:=True:C214
FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="form_intl_"+$type
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="form_intl_"+$type
$TB_FORM{0}{6}:="iw_piece_ligne"

C_TEXT:C284($disabled)
$disabled:=""

Case of 
	: ($type="equipement")
		
		$prefixe:=""
		PARAM_MANDATORY_FIELDS:=""
		
		C_TEXT:C284($enum_values)
		ARRAY TEXT:C222($tb_enum_values; 0)
		
		READ ONLY:C145([Equipement:107])
		ALL RECORDS:C47([Equipement:107])
		MultiSoc_Filter(->[Equipement:107])
		
		$enum_values:=";;"
		
		While (Not:C34(End selection:C36([Equipement:107])))
			$enum_values:=$enum_values+"|"+String:C10([Equipement:107]ID:1)+"_"+[Equipement:107]EQU_Nom:4
			NEXT RECORD:C51([Equipement:107])
		End while 
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention_Lignes:109]INTL_EQU_ID:4)
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="Équipement"
		$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention_Lignes:109]INTL_EQU_ID:4)
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
		ARRAY TEXT:C222($tb_enum_values; 0)
		$enum_values:=";;"
		
		$enum_values:=$enum_values+"|"+"Changement"+"_"+"Changement"
		$enum_values:=$enum_values+"|"+"Mettre au rebut"+"_"+"Mettre au rebut"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention_Lignes:109]INTL_Operation:12)
		$TB_HTML{$o}{4}:=$enum_values
		$TB_HTML{$o}{5}:="Type d'opération"
		$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention_Lignes:109]INTL_Operation:12)
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_half "
		
		
	Else 
		
		$prefixe:="p_"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:=UTL_Field_Name(->[Intervention_Lignes:109]INTL_Prestation:13)
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Prestation"
		$TB_HTML{$o}{6}:=UTL_Field_Name(->[Intervention_Lignes:109]INTL_Prestation:13)
		$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_full fdp_row_start"
		
End case 


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_Montant_HT:7)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant HT"
$TB_HTML{$o}{6}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_Montant_HT:7)
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_quarte fdp_row_start"

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
$TB_HTML{$o}{3}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_TVA_Taux:8)
$TB_HTML{$o}{4}:=$enum_values
$TB_HTML{$o}{5}:="Taux TVA"
$TB_HTML{$o}{6}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_TVA_Taux:8)
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_quarte "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_Montant_TVA:9)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant TVA"
$TB_HTML{$o}{6}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_Montant_TVA:9)
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_Montant_TTC:10)
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant TTC"
$TB_HTML{$o}{6}:=$prefixe+UTL_Field_Name(->[Intervention_Lignes:109]INTL_Montant_TTC:10)
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte  "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:=$prefixe+"mandatory_ligne"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:=$prefixe+"mandatory_ligne"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)


