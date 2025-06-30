//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07-02-19, 05:36:39
// ----------------------------------------------------
// Method: Web_Form_Relance
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $type; $HTML_CONTENT; FIX_DATE_FORMAT)
ARRAY TEXT:C222($TB_HTML; 150; 15)
C_LONGINT:C283($o)
$o:=0

$type:=$1

WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:=""

$disabled:=""
WEB_CHAMP_Saisissable:=""

If (False:C215)
	$disabled:="readonly"
	WEB_CHAMP_Saisissable:="readonly"
End if 

UTL_Add_Script("gl_fiche_relance")

Web_UTL_Add_CSS("recherche_usager")
Web_UTL_Add_CSS("fiche_usager")
Web_UTL_Add_CSS("gl_fiche_relance")
Web_UTL_Add_CSS("gl_liste_usagers")
Web_UTL_Add_CSS("gl_liste_relances")
Web_UTL_Add_CSS("form_list")


$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=relance_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Boutons("regular_fiche_top")

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_entete\">"

//=========================================================================//
// COL LEFT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"



//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"




$disabled_destinataire:=""
If ([Reglements:93]REG_Destinataire_Nom:11#"")
	$disabled_destinataire:="readonly"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_div_half \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Libellé"
$TB_HTML{$o}{6}:="Libellé"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="rlc_libelle"
$TB_HTML{$o}{4}:=[Relances:94]RLC_Libelle:4
$TB_HTML{$o}{5}:="Libellé"
$TB_HTML{$o}{6}:="rlc_libelle"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable+" "+$disabled_destinataire
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_third\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date"
$TB_HTML{$o}{6}:="Date"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="rlc_date"
$TB_HTML{$o}{4}:=String:C10([Relances:94]RLC_Date:11)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="rlc_date"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker fdp_row_start"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_width_full  \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Texte du haut"
$TB_HTML{$o}{6}:="Texte du haut"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="rlc_texte_haut"
$TB_HTML{$o}{4}:=[Relances:94]RLC_Texte_Haut:6
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="rlc_texte_haut"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"



$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//
















$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
//=========================================================================//


//=========================================================================//
// COL RIGHT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"









$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin entete

//===========================================================================//
// LIGNES
//===========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"iw_factures_non_soldees\" class=\"iw_width_full\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_titre_liste iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"FACTURES NON SOLDÉES"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_factures_ns\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//==========================END LIGNES=======================================//


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied \">"
//=========================================================================//
// COL LEFT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content \">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_div_third \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Total"
$TB_HTML{$o}{6}:="Total"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="rlc_libelle"
$TB_HTML{$o}{4}:=[Relances:94]RLC_Libelle:4
$TB_HTML{$o}{5}:="Libellé"
$TB_HTML{$o}{6}:="rlc_libelle"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable+" "+$disabled_destinataire
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_width_full \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Texte du bas"
$TB_HTML{$o}{6}:="Texte du bas"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="rlc_texte_bas"
$TB_HTML{$o}{4}:=[Relances:94]RLC_Texte_Bas:7
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="rlc_texte_bas"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"



$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//



$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
//=========================================================================//


//=========================================================================//
// COL RIGHT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"










$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=========================================================================//


//=========================================================================//
// Hidden 
//=========================================================================//

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="reg_destinataire_id"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Destinataire_ID:9)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_destinataire_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]ID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="ref_structure"
$TB_HTML{$o}{4}:=[Reglements:93]Ref_Structure:2
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ref_structure"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})



$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Origine_ID:18)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})



$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</form>"



$0:=$HTML_CONTENT