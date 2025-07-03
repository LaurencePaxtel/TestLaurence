//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 29/10/18, 18:03:40
// ----------------------------------------------------
// Méthode : Web_Form_Usager_Fiche
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($HTML_CONTENT; FIX_DATE_FORMAT; $date_fin_inclue; $fiche_type)
C_LONGINT:C283($o; $Ecran_Saisie_STR_No)
C_BOOLEAN:C305($label_element_1; $label_element_1_2)

ARRAY TEXT:C222($TB_HTML; 152; 15)

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

$fiche_type:=WEB_UTL_GET_PARAMS("type")

// Modifié par : Scanu Rémy (07/06/2023)
Case of 
	: (Records in selection:C76([HeberGement:5])=1) & ($fiche_type="")
		
		If ([HeberGement:5]HG_Nuit:2)
			$fiche_type:="N"
		Else 
			$fiche_type:="J"
		End if 
		
	: ($fiche_type="prestation")
		$fiche_type:="N"
	Else 
		$fiche_type:="J"
End case 

PARAM_MANDATORY_FIELDS:=""

If (ds:C1482.HeberGement.get([HeberGement:5]ID:168)#Null:C1517)
	w_visiteur.entity:=ds:C1482.HeberGement.get([HeberGement:5]ID:168).toObject()
Else 
	w_visiteur.entity:=ds:C1482.HeberGement.new().toObject()
End if 

Web_UTL_Add_CSS("fiche_usager")

//$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"INT?action=usager_fiche_valider\" name=\"usager_form\" id=\"usager_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"home_fiche_valider\" name=\"usager_form\" id=\"usager_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Usager_Fiche_Boutons("top")

//=========================================================================//
// COL LEFT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_bg_content_blue\">"

$Ecran_Saisie_STR_No:=30108

If ($fiche_type="N")
	$Ecran_Saisie_STR_No:=30112
End if 

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Coordinateur")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_input_blue"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start iw_bg_content_blue_label"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_coordinateur"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Coordinateur:7
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_coordinateur"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Régulateur")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_input_blue\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_bg_content_blue_label"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_regulateur"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Régulateur:8
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_regulateur"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Permanencier")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_input_blue\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_bg_content_blue_label"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_permanencier"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Permanencier:9
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_permanencier"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//================================
// LABEL
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 1")
$label_element_1:=WEB_CHAMP_Invisible_Boolean

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 1_2")
$label_element_1_2:=WEB_CHAMP_Invisible_Boolean

WEB_CHAMP_Visible:=""

If ($label_element_1=True:C214) & ($label_element_1_2=True:C214)
	WEB_CHAMP_Visible:="iw_display_none"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 1")

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre  //"Maraude/Rel/Durée/EG"
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre  //"Maraude/Rel/Durée/EG"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_margin_top_15px iw_bg_content_blue_label"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_maraude1_1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Maraude1_1:10
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_maraude1_1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_margin_bottom_none"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 1_2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

// Modifié par : Scanu Rémy (07/06/2022)
/*Si (WEB_CHAMP_Modifiable)
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
Sinon 
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
Fin de si */

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"

$TB_HTML{$o}{3}:="HG_DateEntree"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_DateEntree:186)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="HG_DateEntree"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_margin_bottom_none"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//================================
// LABEL
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 2")
$label_element_1:=WEB_CHAMP_Invisible_Boolean

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 2_2")
$label_element_1_2:=WEB_CHAMP_Invisible_Boolean

WEB_CHAMP_Visible:=""

If ($label_element_1 & $label_element_1_2)
	WEB_CHAMP_Visible:="iw_display_none"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 2")

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre  //Relation"
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre  //Relation"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_margin_top_15px iw_bg_content_blue_label "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_maraude2_1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Maraude2_1:98
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_maraude2_1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_margin_bottom_none"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+"<label>"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</label>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 2_2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

// Modifié par : Scanu Rémy (07/06/2022)
/*Si (WEB_CHAMP_Modifiable)
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
Sinon 
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
Fin de si */

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"

$TB_HTML{$o}{3}:="hg_maraude2_2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Maraude2_2:99
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_maraude2_2"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_margin_bottom_none"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//================================
// LABEL
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 3")
$label_element_1:=WEB_CHAMP_Invisible_Boolean

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 3_2")
$label_element_1_2:=WEB_CHAMP_Invisible_Boolean

WEB_CHAMP_Visible:=""

If ($label_element_1 & $label_element_1_2)
	WEB_CHAMP_Visible:="iw_display_none"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 3")

$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre  //"Etat général"
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre  //"Etat général"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_margin_top_15px iw_bg_content_blue_label"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_maraude3_1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Maraude3_1:100
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_maraude3_1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_margin_bottom_none"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Maraude 3_2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

// Modifié par : Scanu Rémy (07/06/2022)
/*Si (WEB_CHAMP_Modifiable)
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
Sinon 
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
Fin de si */
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"

$TB_HTML{$o}{3}:="HG_DateSortie"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_DateSortie:185)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="HG_DateSortie"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_margin_bottom_none"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//End iw_bg_content_blue
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_quart\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Signalement")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_signalement"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Signalement:12
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_signalement"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw-popup-btn-delete"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

// Ville rencontre maraude
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Code postal")  //Non trouve
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_codepostal"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_CodePostal:14
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_codepostal"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Gare")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_gare"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Gare:15
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_gare"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

// Provenance
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Métro")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_metro"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Métro:16
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_metro"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_half\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Emplacement")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_emplacement"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Emplacement:17
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_emplacement"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Cas spécifique")

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"
$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

// Modifié par : Scanu Rémy (22/08/2023)
If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famcasspec"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamCasSpéc:111
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famcasspec"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// DIV CONTENT 2
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_quart\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Lien")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

// Modifié par : Rémy Scanu (13/06/2022)
If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_lien"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Lien:18
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_lien"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Nationalité")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_nationalite"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Nationalité:25
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_nationalite"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Situation de Famille")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_situfamille"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_SituFamille:29
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_situfamille"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Temps d'Errance")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_tempserrance"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_TempsErrance:34
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_tempserrance"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 2
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_quart \">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Dernier hébergement")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_dernierheber"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_DernierHéber:35
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_dernierheber"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Situation professionnelle")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_situprofess"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_SituProfess:36
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_situprofess"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Dernier Emploi")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_dernieremploi"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_DernierEmplo:37
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_dernieremploi"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Durée sans emploi")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_duresanemploi"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_DuréSanEmplo:38
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_duresanemploi"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//


//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE BLUE 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Pièce d'identité 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_piecesidte1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_PiècesIdté1:31
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_piecesidte1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Rupture majeure 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_rupmajeur1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_RupMajeur1:40
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_rupmajeur1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Ressources 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_ressources1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Ressources1:45
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_ressources1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Pièce d'identité 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_piecesidte2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_PiècesIdté2:32
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_piecesidte2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Rupture majeure 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw-popup-simple"
$TB_HTML{$o}{2}:="iw-popup-simple"
$TB_HTML{$o}{3}:="hg_rupmajeur2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_RupMajeur2:41
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_rupmajeur2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Ressources 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_ressources2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Ressources2:46
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_ressources2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Pièce d'identité 3")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_piecesidte3"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_PiècesIdté3:33
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_piecesidte3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Rupture majeure 3")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_rupmajeur3"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_RupMajeur3:42
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_rupmajeur3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Ressources 3")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_ressources3"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Ressources3:47
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_ressources3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//===========================================================================//
// DIV CONTENT ALTERNATE BLUE 2
//===========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third\">"

//-------------------------------------------------------------------------------------------------------
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_group_rows\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Suivi social 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_suivisocial1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_SuiviSocial1:49
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_suivisocial1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Suivi social 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_suivisocial2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_SuiviSocial2:50
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_suivisocial2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Suivi social 3")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_suivisocial3"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_SuiviSocial3:51
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_suivisocial3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin de iw_group_rows

//-------------------------------------------------------------------------------------------------------

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_group_rows\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Couverture sociale 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_couvsocial1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_CouvSocial1:53
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_couvsocial1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Couverture sociale 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_couvsocial2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_CouvSocial2:54
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_couvsocial2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Couverture sociale 3")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_couvsocial3"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_CouvSocial3:55
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_couvsocial3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin de iw_group_rows

//----------------------------------------debut iw_group_rows---------------------------------------------------------------
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_group_rows iw_100p\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Etat civil")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_etatcivil"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_EtatCivil:20
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_etatcivil"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Niveau d'étude")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_niveauetude"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_NiveauEtude:43
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_niveauetude"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//----------------------------------------fin de iw_group_rows---------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//END DIV CONTENT ALTERNATE BLUE 2
//===========================================================================//

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 3
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third iw_p100\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_group_third_db\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_group_rows iw_100p\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Centre d'hébergement")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_centrenom"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_CentreNom:62
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_centrenom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "HG_montant")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_content_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="number"
$TB_HTML{$o}{3}:="hg_montant"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_Montant:179)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_montant"
$TB_HTML{$o}{7}:="span7 search text-right fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Commentaires")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Commentaires"
$TB_HTML{$o}{6}:="Commentaires"
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="textarea"
End if 

$TB_HTML{$o}{3}:="hg_commentaires"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Commentaires:181
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_commentaires"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_content_dark_blue\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Réservation active")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_reservation"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_Réservation:91)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_reservation"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Hébergement clôturé")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_cloturee"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_Cloturée:67)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_cloturee"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Nuit en cours")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_nuitencours"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_NuitenCours:92)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_nuitencours"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Nuits totales")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_nuittotal"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_NuitTOTAL:93)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_nuittotal"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder readonly"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Etat du report")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="nuits_encours"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="nuits_encours"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

If ([HeberGement:5]HG_RéservationDateFin:134#!00-00-00!)
	$date_fin_inclue:=String:C10([HeberGement:5]HG_RéservationDateFin:134; Interne date long:K1:5)
End if 

If ($date_fin_inclue#"")
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_row_start \">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Date de fin (inclue)"
	$TB_HTML{$o}{6}:="Date de fin (inclue)"
	$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder  "
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=$date_fin_inclue
	$TB_HTML{$o}{6}:="date_fin_inclue"
	$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_color_blue "
	
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
End if 

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_row_start \">"
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Usager_Fiche_Boutons("GHGPT")
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 3
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third iw_p100\">"

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 4
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third iw_p100 iw_bg_dark_blue\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Orientation 1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_content_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_orientation1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Orientation1:58
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_orientation1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Orientation1Suite")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_content_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_orientation1suite"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Orientation1Suite:59
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_orientation1suite"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 5
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third iw_p100\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Orientation 2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_orientation2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Orientation2:60
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_orientation2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

//-------------------------------------------------------------------------//
// DIV CONTENT ALTERNATE 6
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content_alternate iw_third iw_p100 iw_bg_dark_blue\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Autre solution")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_content_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_autresolutio"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_AutreSolutio:88
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_autresolutio"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "HG_AutreSolSuite")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_content_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_autresolsuite"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_AutreSolSuite:123
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_autresolsuite"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // row
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
//=========================================================================//

//=========================================================================//
// COL RIGHT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Groupe")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famgroupe"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamGroupe:102
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famgroupe"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

// Modifié par : Scanu Rémy (13/06/2023)
// Ajout HG_plateforme
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Plateforme")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_plateforme"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_Plateforme:139
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_plateforme"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Clé lien")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_famcle"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamClé:104
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famcle"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"rowB\">"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fami chef")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group col-12"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre

$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_famchef"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamChef:103)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famchef"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "DossierSIAO")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group col-12"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$o:=$o+1

$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_dossiersiao"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_DossierSIAO:164
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_dossiersiao"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder iw_bold"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Gere_Famille_Composition("get")

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition H")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_famh"
$TB_HTML{$o}{4}:=String:C10(ve_FamH)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_famh"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Nb Personnes")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="hg_famnbpers"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamNbPers:106)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_famnbpers"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition F")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_famf"
$TB_HTML{$o}{4}:=String:C10(ve_FamF)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_famf"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Nb Jours")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="hg_famnbjour"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamNbJour:107)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_famnbjour"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition F Enceinte")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_famfe"
$TB_HTML{$o}{4}:=String:C10(ve_FamFe)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_famfe"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Nb Chambres")

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"
$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="hg_famnbchambre"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamNbChambre:108)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_famnbchambre"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition E mineur")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_famemi"
$TB_HTML{$o}{4}:=String:C10(ve_FamEMi)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_famemi"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition E majeur")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_famema"
$TB_HTML{$o}{4}:=String:C10(ve_FamEMa)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_famema"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Prix par jour")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="hg_famprixjour"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamPrixJour:109)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_famprixjour"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition P mineur")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_fampmi"
$TB_HTML{$o}{4}:=String:C10(ve_FamPMi)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_fampmi"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Composition P majeur")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="ve_fampma"
$TB_HTML{$o}{4}:=String:C10(ve_FamPMa)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="ve_fampma"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Fam Prix total")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half fdp_row_start"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="hg_famtotal"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamTotal:110)
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_famtotal"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//-----------------------------------------------------------------------------------------------//
// Table participation
//-----------------------------------------------------------------------------------------------//
Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Participation")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox_simple"
$TB_HTML{$o}{3}:="hg_participation"
$TB_HTML{$o}{4}:="hg_participation;"+WEB_CHAMP_Titre+";"+String:C10([HeberGement:5]HG_Participation:138)+"|"
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:="hg_participation"
$TB_HTML{$o}{7}:="iw_bold"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM Distri1")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famdistri1"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamDistri1:112
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Visible+""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM Distri1M")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half \">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_famdistri1m"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamDistri1M:118)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri1m"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"+WEB_CHAMP_Visible+""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM Distri2")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famdistri2"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamDistri2:113
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM  Distri2M")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_famdistri2m"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamDistri2M:119)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri2m"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM Distri3")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famdistri3"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamDistri3:114
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM  Distri3M")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_famdistri3m"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamDistri3M:120)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri3m"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM Distri4")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famdistri4"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamDistri4:115
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri4"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM  Distri4M")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_famdistri4m"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamDistri4M:121)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri4m"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM Distri5")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1

If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_famdistri5"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FamDistri5:116
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri5"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "FAM  Distri5M")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hg_famdistri5m"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_FamDistri5M:122)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_famdistri5m"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start "

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

// End table participation
//-----------------------------------------------------------------------------------------------//

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Assistante sociale")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_100p iw_group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1

// Modifié par : Scanu Rémy (22/08/2023)
If (WEB_CHAMP_Modifiable)
	$TB_HTML{$o}{1}:="iw-popup-simple"
	$TB_HTML{$o}{2}:="iw-popup-simple"
Else 
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
End if 

$TB_HTML{$o}{3}:="hg_assistsocial"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_AssistSocial:87
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_assistsocial"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Hébergement en attente")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_100p iw_group"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_enattente"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_EnAttente:64)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_enattente"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Hébergement transmission")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_100p"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_transmis"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_Transmis:65)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_transmis"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

Web_Champs_Ecran_Saisie($Ecran_Saisie_STR_No; "Hébergement prise en chage")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_100p"+WEB_CHAMP_Visible+"\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=WEB_CHAMP_Titre
$TB_HTML{$o}{6}:=WEB_CHAMP_Titre
$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="hg_prisecharge"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_PriseCharge:66)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_prisecharge"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_read_only"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"</form>"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hg_referenceid"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_ReferenceID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_referenceid"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hb_cle"
$TB_HTML{$o}{4}:=String:C10([HeBerge:4]HB_Clé:2)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_cle"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]ID:168)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hg_hb_id"
$TB_HTML{$o}{4}:=String:C10([HeBerge:4]HB_ReferenceID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_hb_id"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

// Modifié par : Scanu Rémy <remy@connect-io.fr> (01/03/2024)
// Duplication de cet input car sinon la modification ou l'ajout de note ne fonctionne pas comme ce "bloc" était dans la liste des hébergés
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id"
$TB_HTML{$o}{4}:=String:C10([HeBerge:4]HB_ReferenceID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="hg_lc_id"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_LC_ID:61)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hg_lc_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="type_fiche"
$TB_HTML{$o}{4}:=$fiche_type
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="type_fiche"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="fiche_type_action"
$TB_HTML{$o}{4}:=fiche_type_action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="fiche_type_action"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="fiche_numero"
$TB_HTML{$o}{4}:=[HeberGement:5]HG_FicheNuméro:3
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="fiche_numero"
$TB_HTML{$o}{7}:=""
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="ref_structure"
$TB_HTML{$o}{4}:=[HeBerge:4]Ref_Structure:67
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ref_structure"
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
$TB_HTML{$o}{3}:="utilisateur"
$TB_HTML{$o}{4}:=w_userNom
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="utilisateur"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

// Modifié par : Scanu Rémy (26/09/2023)
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="forceSetDate"
$TB_HTML{$o}{4}:=String:C10([HeberGement:5]HG_Date:4)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="forceSetDate"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="action"
$TB_HTML{$o}{4}:=$action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="action"
$TB_HTML{$o}{7}:=""

//=========================================================================//
// Popups 
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Notes
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_SP
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Note_Actions
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Usager_Note_AF

$0:=$HTML_CONTENT