//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-02-19, 17:22:05
// ----------------------------------------------------
// Method: Web_Form_Reglement
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type; $HTML_CONTENT; $disabled)
C_LONGINT:C283($o)

C_TEXT:C284(FIX_DATE_FORMAT)

ARRAY TEXT:C222($TB_HTML; 150; 15)

$type:=$1

WEB_CHAMP_Saisissable:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:="reg_date_piece;reg_mode_reglement;reg_montant;ids_factures_putes"
WEB_CHAMP_Saisissable:=""

If ([Reglements:93]REG_No_Piece:3#"")
	$disabled:="readonly"
	WEB_CHAMP_Saisissable:="readonly"
	//OBJET FIXER ACTIVATION(*; reg_date_piece; Vrai)
	//OBJET FIXER ACTIVATION(*; reg_mode_reglement; Vrai)
	//OBJET FIXER ACTIVATION(*; reg_montant; Faux)
	//OBJET FIXER ACTIVATION(*; ids_factures_putes; Faux)
End if 



UTL_Add_Script("gl_fiche_reglement")

Web_UTL_Add_CSS("recherche_usager")
Web_UTL_Add_CSS("fiche_usager")
Web_UTL_Add_CSS("fiche_facture")
Web_UTL_Add_CSS("gl_liste_usagers")

// Modifié par : Scanu Rémy - remy@connect-io.fr (14/06/2022)
// Web_UTL_Add_CSS("gl_liste_reglements")
Web_UTL_Add_CSS("form_list")

Web_UTL_Add_CSS("gl_fiche_reglement")

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=reglement_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Boutons("reglement_fiche_top")
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

If ([Reglements:93]REG_Bien_Nom:26#"")
	WEB_CHAMP_Saisissable:="readonly"
	$disabled_destinataire:=WEB_CHAMP_Saisissable
End if 


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_div_half \">"
$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Centre"
$TB_HTML{$o}{6}:="Centre"
$TB_HTML{$o}{7}:="fdp_width100 search "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_bien_nom"
$TB_HTML{$o}{4}:=[Reglements:93]REG_Bien_Nom:26
$TB_HTML{$o}{5}:="Centre"
$TB_HTML{$o}{6}:="reg_bien_nom"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

WEB_CHAMP_Saisissable:=""

If ([Reglements:93]REG_Locataire_Nom:27#"")
	WEB_CHAMP_Saisissable:="readonly"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_div_half \">"
$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Locataire"
$TB_HTML{$o}{6}:="Locataire"
$TB_HTML{$o}{7}:="fdp_width100 search "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_locataire_nom"
$TB_HTML{$o}{4}:=[Reglements:93]REG_Locataire_Nom:27
$TB_HTML{$o}{5}:="Locataire"
$TB_HTML{$o}{6}:="reg_locataire_nom"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

WEB_CHAMP_Saisissable:=""


If ([Reglements:93]REG_No_Piece:3#"")
	$disabled:="readonly"
	WEB_CHAMP_Saisissable:="readonly"
	//OBJET FIXER ACTIVATION(*; reg_date_piece; Vrai)
	//OBJET FIXER ACTIVATION(*; reg_mode_reglement; Vrai)
	//OBJET FIXER ACTIVATION(*; reg_montant; Faux)
	//OBJET FIXER ACTIVATION(*; ids_factures_putes; Faux)
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half\">"
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
$TB_HTML{$o}{3}:="reg_date_piece"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Date_Piece:4)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_date_piece"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

C_TEXT:C284($modes_reglements)
ARRAY TEXT:C222($tb_enum_values; 0)

$values_c:=UTL_Web_Get_Enumeration_Values("Modes de règlements")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$modes_reglements:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	If ([Reglements:93]REG_Mode_Reglement:7=$tb_enum_values{$i})
		$modes_reglements:=$modes_reglements+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}+"_s"
	Else 
		$modes_reglements:=$modes_reglements+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
	End if 
End for 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half\">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Mode de règlement"
$TB_HTML{$o}{6}:="Mode de règlement"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="reg_mode_reglement"
$TB_HTML{$o}{4}:=$modes_reglements
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_mode_reglement"
$TB_HTML{$o}{7}:="fdp_span3  span7"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

C_TEXT:C284($banques)
$banques:=""

ARRAY TEXT:C222($tb_enum_values; 0)

$values_c:=UTL_Web_Get_Enumeration_Values("Banques")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 

$banques:=";;"

For ($i; 1; Size of array:C274($tb_enum_values))
	$banques:=$banques+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_div_half  \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Banque"
$TB_HTML{$o}{6}:="Banque"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="reg_bqe_nom"
$TB_HTML{$o}{4}:=$banques
$TB_HTML{$o}{5}:="reg_bqe_nom"
$TB_HTML{$o}{6}:="reg_bqe_nom"
$TB_HTML{$o}{7}:="span7"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   iw_div_half  \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="IBAN"
$TB_HTML{$o}{6}:="IBAN"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_no_piece"
$TB_HTML{$o}{4}:=[Reglements:93]REG_BQE_IBAN:23
$TB_HTML{$o}{5}:="reg_no_piece"
$TB_HTML{$o}{6}:="reg_no_piece"
$TB_HTML{$o}{7}:="span7"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"


//$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start  \">"
//$o:=$o+1
//$TB_HTML{$o}{1}:="label"
//$TB_HTML{$o}{2}:="label"
//$TB_HTML{$o}{3}:=""
//$TB_HTML{$o}{4}:=""
//$TB_HTML{$o}{5}:="Banque"
//$TB_HTML{$o}{6}:="Banque"
//$TB_HTML{$o}{7}:="fdp_width100 search "
//$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML ($TB_HTML{$o}{1};$TB_HTML{$o}{2};$TB_HTML{$o}{3};$TB_HTML{$o}{4};$TB_HTML{$o}{5};$TB_HTML{$o}{6};$TB_HTML{$o}{7})
//$o:=$o+1
//$TB_HTML{$o}{1}:="input"
//$TB_HTML{$o}{2}:="text"
//$TB_HTML{$o}{3}:="reg_banque_domiciliation"
//$TB_HTML{$o}{4}:=[Reglements]REG_Banque_Domiciliation
//$TB_HTML{$o}{5}:="Banque"
//$TB_HTML{$o}{6}:="reg_banque_domiciliation"
//$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable+" "+$disabled_destinataire
//$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML ($TB_HTML{$o}{1};$TB_HTML{$o}{2};$TB_HTML{$o}{3};$TB_HTML{$o}{4};$TB_HTML{$o}{5};$TB_HTML{$o}{6};$TB_HTML{$o}{7})
//$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_div_half \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Montant"
$TB_HTML{$o}{6}:="Montant"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_montant"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Montant:5)
$TB_HTML{$o}{5}:="Montant"
$TB_HTML{$o}{6}:="reg_montant"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half   \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date d'échéance"
$TB_HTML{$o}{6}:="Date d'échéance"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_date_echeance"
If ([Reglements:93]REG_Date_Echeance:8#!00-00-00!)
	$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Date_Echeance:8)
Else 
	$TB_HTML{$o}{4}:=String:C10(Add to date:C393(Current date:C33(*); 0; 0; 10))
End if 
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_date_echeance"
$TB_HTML{$o}{7}:="span7 search datepicker"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

READ ONLY:C145([Factures:86])
QUERY:C277([Factures:86]; [Factures:86]ID:1=[Reglements:93]REG_Origine_ID:18)


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


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start   \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Référence"
$TB_HTML{$o}{6}:="Référence"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_no_reglement"
$TB_HTML{$o}{4}:=[Reglements:93]REG_No_Reglement:20
$TB_HTML{$o}{5}:="reg_no_reglement"
$TB_HTML{$o}{6}:="reg_no_reglement"
$TB_HTML{$o}{7}:="span7"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group   fdp_row_start  \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="N° Pièce"
$TB_HTML{$o}{6}:="N° Pièce"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="reg_no_piece"
$TB_HTML{$o}{4}:=[Reglements:93]REG_No_Piece:3
$TB_HTML{$o}{5}:="reg_no_piece"
$TB_HTML{$o}{6}:="reg_no_piece"
$TB_HTML{$o}{7}:="span7  disabled"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"



$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start  \">"
$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Notes"
$TB_HTML{$o}{6}:="Notes"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="reg_notes"
$TB_HTML{$o}{4}:=[Reglements:93]REG_Notes:14
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_notes"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"





$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin entete

//===========================================================================//
// LIGNES
//===========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"iw_factures_non_soldees\" class=\"iw_width_full\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"iw_titre_lignes_1\" class=\"iw_titre_liste iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"FACTURES NON SOLDÉES"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_factures_ns\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//==========================END LIGNES=======================================//


$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied iw_display_none\">"
//=========================================================================//
// COL LEFT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_third\">"




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
$TB_HTML{$o}{3}:="ids_factures_putes"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Origine_IDS:21)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ids_factures_putes"
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
$TB_HTML{$o}{3}:="reg_nopiece"
$TB_HTML{$o}{4}:=[Reglements:93]REG_No_Piece:3
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_nopiece"
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


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="reg_bien_id"
$TB_HTML{$o}{4}:=String:C10([Reglements:93]REG_Bien_ID:24)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_bien_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

C_LONGINT:C283($REG_Locataire_ID)
$REG_Locataire_ID:=[Reglements:93]REG_Locataire_ID:25
If ($REG_Locataire_ID=0)
	$REG_Locataire_ID:=-1
End if 

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="reg_locataire_id"
$TB_HTML{$o}{4}:=String:C10($REG_Locataire_ID)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_locataire_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="reg_origine_ids"
$TB_HTML{$o}{4}:=[Reglements:93]REG_Origine_IDS:21
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="reg_origine_ids"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})



$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</form>"



$0:=$HTML_CONTENT