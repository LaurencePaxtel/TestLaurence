//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/03/20, 10:22:48
// ----------------------------------------------------
// Method: Web_Form_Event_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($types_rdv; $presence; $rappel; $recurrence)
C_LONGINT:C283($o; $i; $Ecran_Saisie_STR_No)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_FORM; 0; 6)
ARRAY TEXT:C222($tb_enum_values; 0)
ARRAY TEXT:C222($TB_HTML; 100; 15)

RECORD_ACT_EDIT:=True:C214
$Ecran_Saisie_STR_No:=30112

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="event_ligne"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="event_ligne"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:="eve_date_du;eve_date_au;eve_heure_du;eve_heure_au"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="eve_date_du"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date du"
$TB_HTML{$o}{6}:="eve_date_du"
$TB_HTML{$o}{7}:="fdp_span3 span7 datepicker iw_cg_width_quarte"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="eve_heure_du"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Heure de début"
$TB_HTML{$o}{6}:="eve_heure_du"
$TB_HTML{$o}{7}:="fdp_span3  span7 timepicker iw_cg_width_quarte"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="eve_date_au"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date au"
$TB_HTML{$o}{6}:="eve_date_au"
$TB_HTML{$o}{7}:="fdp_span3 span7 datepicker iw_cg_width_quarte"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="eve_heure_au"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Heure de fin"
$TB_HTML{$o}{6}:="eve_heure_au"
$TB_HTML{$o}{7}:="fdp_span3 span7 timepicker iw_cg_width_quarte"

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
$TB_HTML{$o}{3}:="eve_type"
$TB_HTML{$o}{4}:=$types_rdv
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="eve_type"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_quarte"

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
$TB_HTML{$o}{3}:="eve_presence"
$TB_HTML{$o}{4}:=$presence
$TB_HTML{$o}{5}:="Présence"
$TB_HTML{$o}{6}:="eve_presence"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte"

CLEAR VARIABLE:C89($tb_enum_values)
$values_c:=UTL_Web_Get_Enumeration_Values("Planning: Rappel")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

// Modifié par : Scanu Rémy (09/09/2022)
If (Find in array:C230($tb_enum_values; "1j")=-1)
	APPEND TO ARRAY:C911($tb_enum_values; "2j")
End if 

If (Find in array:C230($tb_enum_values; "2j")=-1)
	APPEND TO ARRAY:C911($tb_enum_values; "2j")
End if 

If (Find in array:C230($tb_enum_values; "5j")=-1)
	APPEND TO ARRAY:C911($tb_enum_values; "5j")
End if 

If (Find in array:C230($tb_enum_values; "7j")=-1)
	APPEND TO ARRAY:C911($tb_enum_values; "7j")
End if 

If (Find in array:C230($tb_enum_values; "15j")=-1)
	APPEND TO ARRAY:C911($tb_enum_values; "15j")
End if 

$rappel:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$rappel:=$rappel+"|"+$tb_enum_values{$i}+";"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox"
$TB_HTML{$o}{3}:="eve_rappel"
$TB_HTML{$o}{4}:=$rappel
$TB_HTML{$o}{5}:="Rappel"
$TB_HTML{$o}{6}:="eve_rappel"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte"

CLEAR VARIABLE:C89($tb_enum_values)

APPEND TO ARRAY:C911($tb_enum_values; "Quotidienne")
APPEND TO ARRAY:C911($tb_enum_values; "Hebdomadaire")
APPEND TO ARRAY:C911($tb_enum_values; "Mensuel")
APPEND TO ARRAY:C911($tb_enum_values; "Annuel")
$recurrence:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$recurrence:=$recurrence+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="eve_recurrence"
$TB_HTML{$o}{4}:=$recurrence
$TB_HTML{$o}{5}:="Récurrence"
$TB_HTML{$o}{6}:="eve_recurrence"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_quarte"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="eve_titre"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Titre"
$TB_HTML{$o}{6}:="eve_titre"
$TB_HTML{$o}{7}:="fdp_span3 span7 fdp_row_start iw_cg_width_half iw_cg_test"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="eve_usager_nom"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom usager"
$TB_HTML{$o}{6}:="eve_usager_nom"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_half"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="filter_usager"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Choix des participants (filtre)"
$TB_HTML{$o}{6}:="filter_usager"
$TB_HTML{$o}{7}:="fdp_span3 span7 fdp_row_start iw_cg_pla_participants"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="multiple"
$TB_HTML{$o}{3}:="eve_participants_ids"
$TB_HTML{$o}{4}:=WEB_UTL_SET_Choix_Champ(->[INtervenants:10]; ->[INtervenants:10]IN_NomPrénom:8; "UID"; "")
$TB_HTML{$o}{5}:="Choix des participants"
$TB_HTML{$o}{6}:="eve_participants_ids"
$TB_HTML{$o}{7}:="span3 multiSelectRecherche fdp_placeholder fdp_row_start iw_cg_width_two_thirds iw_start_div_parent iw_stype_groupe iw_cg_pla_participants"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="button"
$TB_HTML{$o}{3}:="btn_email_participant"
$TB_HTML{$o}{4}:="E-mail Participant"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_email_participant"
$TB_HTML{$o}{7}:="iw_tag_one_groupe_start iw_cg_width_one_third btn iw_icon_email iw_form_btns"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="button"
$TB_HTML{$o}{3}:="btn_sms_participant"
$TB_HTML{$o}{4}:="SMS Participant"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_sms_participant"
$TB_HTML{$o}{7}:=" btn  iw_icon_sms iw_form_btns "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="button"
$TB_HTML{$o}{3}:="btn_email_usager"
$TB_HTML{$o}{4}:="E-mail Usager"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_email_usager"
$TB_HTML{$o}{7}:=" iw_icon_email btn iw_form_btns"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="button"
$TB_HTML{$o}{3}:="btn_sms_usager"
$TB_HTML{$o}{4}:="SMS Usager"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="btn_sms_usager"
$TB_HTML{$o}{7}:="iw_end_div_parent iw_cg_one_groupe_end iw_cg_width_one_third btn iw_icon_new iw_form_btns"  //" iw_icon_sms btn iw_form_btns"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="eve_notes"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Notes"
$TB_HTML{$o}{6}:="eve_notes"
$TB_HTML{$o}{7}:="iw_cg_width_full iw_margin_bottom_10px"  //iw_textarea_rows_10

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="eve_hb_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="eve_hb_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)