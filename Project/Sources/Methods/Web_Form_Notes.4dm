//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 14/11/18, 03:49:51
// ----------------------------------------------------
// Méthode : Web_Form_Notes
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($html; $note_disabled; $note_maraude_disabled; $note_fvv_disabled)
C_BOOLEAN:C305($note_maraude_visible; $note_fvv_visible; $vb_OK)


$vb_OK:=Web_User_Check_Privilege("Notes modife")

$note_disabled:="disabled"

If ($vb_OK)
	CLEAR VARIABLE:C89($note_disabled)
End if 

$note_maraude_visible:=Web_User_Check_Privilege("MARAUDE")
$note_fvv_visible:=Web_User_Check_Privilege("Notes FVV")

$note_maraude_disabled:="disabled"

If (Web_User_Check_Privilege("Notes MAR modife"))
	CLEAR VARIABLE:C89($note_maraude_disabled)
End if 

$note_fvv_disabled:="disabled"

If (Web_User_Check_Privilege("Notes FVV modife"))
	CLEAR VARIABLE:C89($note_fvv_disabled)
End if 

$html:=$html+"<div id=\"iw_notes\">"
$html:=$html+"<div class=\"portlet box blue tabbable\" >"
$html:=$html+"<div class=\"portlet-title\">"

// Modifié par : Scanu Rémy (22/04/2022)
$html:=$html+"<div class=\"row overflowOverlay\">"
$html:=$html+"<div class=\"span12\">"
$html:=$html+"<ul class=\"nav nav-tabs\">"

/*
Si ($note_fvv_visible)
$html:=$html+"<li class=\"\"><a href=\"#tab-note-8\" data-toggle=\"tab\">"+va_T_Onglet10Note+"</a></li>"  //FVV
Fin de si 

Si ($note_maraude_visible)
$html:=$html+"<li class=\"\"><a href=\"#tab-note-7\" data-toggle=\"tab\">"+va_T_Onglet9Note+"</a></li>"  // Maraude 2
$html:=$html+"<li class=\"\"><a href=\"#tab-note-6\" data-toggle=\"tab\">"+va_T_Onglet8Note+"</a></li>"  // Maraude
Fin de si 

$html:=$html+"<li class=\"\"><a href=\"#tab-note-5\" data-toggle=\"tab\">"+va_T_Onglet5Note+"</a></li>"  // Note Transfert
$html:=$html+"<li class=\"\"><a href=\"#tab-note-4\" data-toggle=\"tab\">"+va_T_Onglet4Note+"</a></li>"  // Suivi

$html:=$html+"<li class=\"\"><a href=\"#tab-note-3\" data-toggle=\"tab\">"+va_T_Onglet7Note+"</a></li>"  // Note 3
$html:=$html+"<li class=\"\"><a href=\"#tab-note-2\" data-toggle=\"tab\">"+va_T_Onglet3Note+"</a></li>"  // Note 2
$html:=$html+"<li class=\"active\"><a href=\"#tab-note-1\" data-toggle=\"tab\">"+va_T_Onglet6Note+"</a></li>"  // Note 1
*/

$html:=$html+"<li class=\"active\"><a href=\"#tab-note-1\" data-toggle=\"tab\">Coordonnées</a></li>"
$html:=$html+"<li><a href=\"#tab-note-2\" data-toggle=\"tab\">Autre</a></li>"
$html:=$html+"</ul>"

$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"portlet-body form\">"
$html:=$html+"<form enctype=\"multipart/form-data\" action=\"#\" method=\"post\" name=\"form_notes\" id=\"form_notes\" class=\"fdp_form\">"

$html:=$html+"<div class=\"tabbable portlet-tabs\">"
$html:=$html+"<div class=\"tab-content\">"
$html:=$html+"<div class=\"tab-pane active\" id=\"tab-note-1\">"
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"</div>"

$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+"<div class=\"rowB g-mb-20\">"
// Modifié par : Scanu Rémy  (10/04/2024)
$disabled_b:=Not:C34(outilsManagePrivilege(1; "Modification_Heberge"; w_userUID))

$html:=$html+"<div class=\"col-6 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Nom</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"nomHB\" name=\"nomHB\" value=\"\" class=\"span7 search fdp_placeholder\" disabled=\"disabled\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-6 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Prénom</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"prenomHB\" name=\"prenomHB\" value=\"\" class=\"span7 search fdp_placeholder\" disabled=\"disabled\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Date de naissance</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"date\" id=\"dateNaissanceHB\" name=\"dateNaissanceHB\" value=\"\" class=\"span7 search fdp_placeholder\" disabled=\"disabled\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

If ($disabled_b=False:C215)
	$html:=$html+"<div class=\"col-12 g-mb-10\">"
	
	$html:=$html+"<div class=\"controls\">"
	$html:=$html+"<input type=\"checkbox\" id=\"modifDemandeur\" name=\"modifDemandeur\" value=\"\" class=\"d-inline-block\" style=\"margin-right: 10px!important\" />"
	$html:=$html+"<label class=\"control-label-group\" for=\"modifDemandeur\">Modifier le demandeur</label>"
	$html:=$html+"</div>"
	
	$html:=$html+"</div>"
End if 

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Adresse</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"adresse1\" name=\"adresse1\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"adresse2\" name=\"adresse2\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"adresse3\" name=\"adresse3\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-6 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Code postal</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"codePostal\" name=\"codePostal\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-6 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Ville</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"ville\" name=\"ville\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Adresse E-mail</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"emailHB\" name=\"emailHB\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">Téléphone</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"telephoneHB\" name=\"telephoneHB\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

// Modifié par : Scanu Rémy (22/05/2024)
$html:=$html+"<div class=\"tab-pane\" id=\"tab-note-2\">"
$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"col100\">"
$html:=$html+"</div>"

$html:=$html+"<div class=\"fdp_line\">"
$html:=$html+"<div class=\"rowB g-mb-20\">"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">"+String:C10(w_visiteur.societe.SO_PieceChamp1)+"</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"lieuNaissanceHB\" name=\"lieuNaissanceHB\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

If (w_visiteur=Null:C1517)
	w_visiteur:=New object:C1471("societe"; New object:C1471)
End if 

If (w_visiteur.societe=Null:C1517)
	w_visiteur.societe:=New object:C1471
End if 

$html:=$html+"<label class=\"control-label-group\">"+String:C10(w_visiteur.societe.SO_PieceChamp2)+"</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"nationaliteHB\" name=\"nationaliteHB\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">"+String:C10(w_visiteur.societe.SO_PieceChamp3)+"</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"numCNIHB\" name=\"numCNIHB\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"<div class=\"col-12 g-mb-10\">"

$html:=$html+"<label class=\"control-label-group\">"+String:C10(w_visiteur.societe.SO_PieceChamp4)+"</label>"
$html:=$html+"<div class=\"controls\">"
$html:=$html+"<input type=\"text\" id=\"numPassportHB\" name=\"numPassportHB\" value=\"\" class=\"span7 search fdp_placeholder\" />"
$html:=$html+"</div>"

$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</form>"
$html:=$html+"</div>"
$html:=$html+"</div>"

$html:=$html+"</div>"

$0:=$html