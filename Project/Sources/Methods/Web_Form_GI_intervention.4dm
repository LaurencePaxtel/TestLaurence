//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 2020-05-29, 11:42:59
// ----------------------------------------------------
// Method: Web_Form_GI_intervention
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($HTML_CONTENT; $value; $enum_values; $readonly)

C_TEXT:C284(FIX_DATE_FORMAT)

ARRAY TEXT:C222($tb_enum_values; 0)

WEB_CHAMP_Saisissable:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"
PARAM_MANDATORY_FIELDS:="int_type;int_nom;int_date_debut"

RECORD_ACT_EDIT:=True:C214

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=bien_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_entete\">"

//=========================================================================//
// COL LEFT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

$values_c:=UTL_Web_Get_Enumeration_Values("GI: Types interventions")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$value:=outilsWebSelectGetOptionHTML(->$tb_enum_values; [Intervention:108]INT_Type:3)
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "select"; ""; "int_type"; "Type d'intervention"; ->$value; "iw_cg_width_half "; "fdp_span3 span7")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; "int_nom"; "Nom intervention"; ->[Intervention:108]INT_Nom:12; "iw_cg_width_half "; "fdp_span3 span7")

WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; UTL_Field_Name(->[Intervention:108]INT_Immeuble_Nom:19); "Immeuble"; ->[Intervention:108]INT_Immeuble_Nom:19; "iw_cg_width_half fdp_row_start"; "fdp_span3 span7"+$readonly)
CLEAR VARIABLE:C89($readonly)

If ([Intervention:108]INT_LC_ReferenceID:16#0)
	$readonly:=" readonly "
End if 

WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; UTL_Field_Name(->[Intervention:108]INT_LC_Nom:17); "Logement"; ->[Intervention:108]INT_LC_Nom:17; "iw_cg_width_half"; "fdp_span3 span7")

$value:=String:C10([Intervention:108]INT_PEE:21)
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "iw_radio"; "iw_radio"; "int_pee"; "Prise en charge externe"; ->$value; "iw_cg_width_half"; "fdp_span3 span7")

CLEAR VARIABLE:C89($readonly)

$value:=String:C10(Round:C94([Intervention:108]INT_PEE_Montant:22; 2))
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; UTL_Field_Name(->[Intervention:108]INT_PEE_Montant:22); "Montant"; ->$value; "iw_cg_width_half"; "fdp_span3 span7")

// Modifié par : Scanu Rémy (13/03/2023)
$value:=String:C10([Intervention:108]INT_AutorisationAbsence:23)
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "iw_radio"; "iw_radio"; "int_autorisationAbsence"; "Autorisation d’accès en son absence"; ->$value; "fdp_row_start iw_cg_width_half"; "fdp_span3 span7")

// Modifié par : Scanu Rémy (21/03/2023)
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"rowB control-group iw_cg_width_half\">"

$heberge_es:=ds:C1482.HeberGement.query("Ref_Structure = :1"; Session:C1714.storage.intervenant.Ref_Structure).HG_HB_ID_1_HB_ReferenceID.orderBy("HB_Nom asc, HB_Prénom asc")
$value:="Aucun"+";0;"

For each ($heberge_e; $heberge_es)
	$value:=$value+"|"+String:C10($heberge_e.ID)+"_"+String:C10($heberge_e.HB_Nom)+" "+String:C10($heberge_e.HB_Prénom)
	
	If ($heberge_e.ID=[Intervention:108]hebergeID:25)
		$value:=$value+"_s"
	End if 
	
End for each 

WebAGL_Create_Group_HTML(->$HTML_CONTENT; "select"; ""; "hebergeID"; "Occupant"; ->$value; "col-6"; "fdp_span3 span7 select2")

// Modifié par : Scanu Rémy (17/03/2023)
ARRAY TEXT:C222($ta_InPerm_t; 0)
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=4)
MultiSoc_Filter(->[INtervenants:10])

SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $ta_InPerm_t)
SORT ARRAY:C229($ta_InPerm_t; >)

$value:=outilsWebSelectGetOptionHTML(->$ta_InPerm_t; [Intervention:108]INT_Referent:24)
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "select"; ""; "int_referent"; "Référent"; ->$value; "col-6"; "fdp_span3 span7")

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

CLEAR VARIABLE:C89($value)
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; "filtre_intervenants"; "Choix des intervenants (filtre)"; ->$value; "iw_cg_width_half input-group-mb3 mb-3 iw_mb3_add fdp_row_start"; "fdp_span3 span7 fdp_row_start iw_cg_pla_participants iw_mb3_add form-control-mb3 iw_btns_add")

$value:=WEB_UTL_SET_Choix_Champ(->[GI_Intervenants:110]; ->[GI_Intervenants:110]GII_NomPrenom:6; "UID"; "")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "select"; "multiple"; "int_intervenants_ids"; "Choix des intervenants"; ->$value; "iw_cg_width_full"; "span3 multiSelectRecherche fdp_placeholder iw_stype_groupe iw_cg_pla_participants")

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // row
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
//=========================================================================//

//=========================================================================//
// COL RIGHT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

CLEAR VARIABLE:C89($tb_enum_values)

APPEND TO ARRAY:C911($tb_enum_values; "En attente")
APPEND TO ARRAY:C911($tb_enum_values; "En cours")
APPEND TO ARRAY:C911($tb_enum_values; "Terminé")

$enum_values:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	
	If ([Intervention:108]INT_Etape:11=$tb_enum_values{$i})
		$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}+"_s"
	Else 
		$enum_values:=$enum_values+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
	End if 
	
End for 

WebAGL_Create_Group_HTML(->$HTML_CONTENT; "select"; ""; "int_etape"; "Étape"; ->$enum_values; "iw_cg_width_half "; "fdp_span3 span7 ")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; "int_numero"; "Numéro"; ->[Intervention:108]INT_Numero:13; "iw_cg_width_half "; "fdp_span3 span7  readonly ")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; "int_date_debut"; "Date de début"; ->[Intervention:108]INT_Date_debut:5; "iw_cg_width_half "; "fdp_span3  span7 datepicker ")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "text"; "int_date_fin"; "Date de fin"; ->[Intervention:108]INT_Date_Fin:6; "iw_cg_width_half "; "fdp_span3  span7 datepicker ")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "textarea"; "int_notes"; "Commentaires"; ->[Intervention:108]INT_Notes:20; "iw_cg_width_full "; "iw_margin_bottom_10px iw_textarea_rows_10 iw_cg_width_full ")

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_hidden\">"

WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "hidden"; UTL_Field_Name(->[Intervention:108]INT_Immeuble_ID:18); ""; ->[Intervention:108]INT_Immeuble_ID:18; ""; "")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "hidden"; UTL_Field_Name(->[Intervention:108]INT_LC_ReferenceID:16); ""; ->[Intervention:108]INT_LC_ReferenceID:16; ""; "")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "hidden"; "mandatory"; ""; ->PARAM_MANDATORY_FIELDS; ""; "")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "hidden"; "record_id"; ""; ->[Intervention:108]ID:1; ""; "")
WebAGL_Create_Group_HTML(->$HTML_CONTENT; "input"; "hidden"; "id_selected"; ""; ->[Intervention:108]ID:1; ""; "")

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</form>"

$0:=$HTML_CONTENT