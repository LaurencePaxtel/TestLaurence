//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/04/20, 10:37:31
// ----------------------------------------------------
// Method: Web_Form_Recherche_Event
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($type_filters; $UID; $types_rdv; $presence; $granted_users)
C_LONGINT:C283($o)

ARRAY TEXT:C222($tb_enum_values; 0)
ARRAY TEXT:C222($TB_FORM; 0; 6)
ARRAY TEXT:C222($TB_HTML; 100; 15)

ARRAY LONGINT:C221($tb_granted_users; 0)
ARRAY OBJECT:C1221($tb_privileges_config; 0)

$type_filters:="liste"

If (Count parameters:C259>0)
	$type_filters:=$1
End if 

RECORD_ACT_EDIT:=True:C214

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=events-list"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="events_filters_"+$type_filters
$TB_FORM{0}{4}:=FIX_PARAM_ACTION
$TB_FORM{0}{5}:="events_filters_"+$type_filters
$TB_FORM{0}{6}:=LANG_TXT_CREATE_ACCCOUNT

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="filtre_date_du"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date du"
$TB_HTML{$o}{6}:="filtre_date_du"
$TB_HTML{$o}{7}:="fdp_span3  search span7 datepicker  iw_cg_width_sextuplet iw_data_column_4"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="filtre_date_au"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date au"
$TB_HTML{$o}{6}:="filtre_date_au"
$TB_HTML{$o}{7}:="fdp_span3  search span7 datepicker  iw_cg_width_sextuplet iw_data_column_5"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="filtre_nom_heberge"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom usager"
$TB_HTML{$o}{6}:="filtre_nom_heberge"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  iw_cg_width_sextuplet iw_data_column_0 "

$values_c:=UTL_Web_Get_Enumeration_Values("Planning: Types RDV")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 
$types_rdv:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$types_rdv:=$types_rdv+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="filtre_type"
$TB_HTML{$o}{4}:=$types_rdv
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="filtre_type"
$TB_HTML{$o}{7}:="fdp_span3  search span7 iw_cg_width_sextuplet iw_data_column_1"

CLEAR VARIABLE:C89($tb_enum_values)
$values_c:=UTL_Web_Get_Enumeration_Values("Planning: Présence")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$presence:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$presence:=$presence+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="filtre_presence"
$TB_HTML{$o}{4}:=$presence
$TB_HTML{$o}{5}:="Présence"
$TB_HTML{$o}{6}:="filtre_presence"
$TB_HTML{$o}{7}:="fdp_span3  search span7 iw_cg_width_sextuplet iw_data_column_2"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="filtre_titre"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Titre"
$TB_HTML{$o}{6}:="filtre_titre"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  iw_cg_width_sextuplet iw_data_column_3"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_button_icon"
$TB_HTML{$o}{2}:="search"
$TB_HTML{$o}{3}:="iw_btn_plan_search"
$TB_HTML{$o}{4}:="<i class=\"fa fa-search\"></i>"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="iw_btn_plan_search"
$TB_HTML{$o}{7}:="iw_cg_btn_icon  iw_btn_icon_only iw_btn_icon fdp_Button  fdp_btn_top iw_float_left btn_pla_search iw_cg_width_5percent"

If ($type_filters="liste")
	
	//==========================================//
	// Privilèges : utilisateurs autorisés
	//==========================================//
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=w_userUID; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
	MultiSoc_Filter(->[Preferences:81])
	
	If (Records in selection:C76([Preferences:81])=1)
		OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
	End if 
	
	For ($i; 1; Size of array:C274($tb_privileges_config))
		APPEND TO ARRAY:C911($tb_granted_users; Num:C11($tb_privileges_config{$i}.id))
	End for 
	
	$granted_users:=w_userNom+";"+String:C10(w_userUID)+";"
	$granted_users:=$granted_users+"|"+"-1"+"_Tous"
	
	For ($i; 1; Size of array:C274($tb_granted_users))
		QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$tb_granted_users{$i})
		MultiSoc_Filter(->[INtervenants:10])
		
		If (Records in selection:C76([INtervenants:10])=1)
			$granted_users:=$granted_users+"|"+String:C10($tb_granted_users{$i})+"_"+[INtervenants:10]IN_NomPrénom:8
		End if 
		
	End for 
	
	$TB_HTML{$o}{1}:="select"
	$TB_HTML{$o}{2}:=""
	$TB_HTML{$o}{3}:="filtre_proprietaire"
	$TB_HTML{$o}{4}:=$granted_users
	$TB_HTML{$o}{5}:="Propriétaire"
	$TB_HTML{$o}{6}:="filtre_proprietaire"
	$TB_HTML{$o}{7}:="fdp_span3  search span7  iw_cg_width_sextuplet iw_data_column_10 fdp_row_start"
End if 

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)