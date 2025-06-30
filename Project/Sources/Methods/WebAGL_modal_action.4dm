//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : root
// Date et heure : 21/10/18, 09:07:47
// ----------------------------------------------------
// Method: WebAGL_modal_action
// Description
// 
//
// Paramètres : ---> $1 : actions  ---> chaine qui contient les actions  (ex:'AMS')
//                                'A' : Ajout
//                                'M' : Modification
//                                'S' : Suppression
//
//              <--- $0 : modal
// ----------------------------------------------------

C_TEXT:C284($1; $actions; $modal; FIX_PARAM_ACTION; Titre; FIX_POPOUP_TAILLE_X; $HTML)
C_BOOLEAN:C305(FIX_PARAM_FORM_AVN)
$actions:=$1
$actionm:=WEB_UTL_GET_PARAMS("actionm")

If ($actionm="")
	$actionm:=w_action
End if 

If (FIX_PARAM_ACTION_M#"")
	$actionm:=FIX_PARAM_ACTION_M
End if 


//$script:="<script type=\"text/javascript\">"
//$script:=$script+"$(function(){"
//$script:=$script+"<!--4Dhtmlvar SCRIPT-->"
//$script:=$script+"});"
//$script:=$script+"</script>"

If (Count parameters:C259=2)
	$HTML:=$2
	//$ACTION_DEVR:=$3
End if 

If ($actions#"")
	
	If ($actions="@A@")
		$modal:=$modal+"<div class=\"modal hide\" id=\""+$actionm+"_"+FIX_PARAM_ACTION+"_modal_add\">"
		$modal:=$modal+"<div class=\"modal-header\">"
		$modal:=$modal+"<button type=\"button\" class=\"close hide\" data-dismiss=\"modal\">x</button>"
		$modal:=$modal+"<h4 style=\"float:left;\">"+UTL_Traduire(Titre; "Modal")+"</h4>"
		$modal:=$modal+"<div class=\"btns\"><a href=\"#\" class=\"btn-annuler-ligne btn-close\" ><span class=\"link\">"+UTL_Traduire("Annuler"; "Bouton")+"</span></a></div>"
		$modal:=$modal+"<div class=\"btns\"><a href=\"#\" class=\""+FIX_PARAM_ACTION+" btn-valider-ligne wait\" ><span class=\"link\">"+UTL_Traduire("Valider"; "Bouton")+"</span></a></div>"
		//Si (FIX_PARAM_FORM_AVN)
		//$modal:=$modal+"<div class=\"btns\"><a href=\"/"+FIX_PARAM_ACTION+"?action=add&uidm=\" class=\""+FIX_PARAM_ACTION+" btn-form-avance\"><span class=\"link\">Form. Avancée</span></a></div>"
		//Fin de si 
		$modal:=$modal+"</div>"
		
		$modal:=$modal+"<div class=\"modal-body\">"  //$modal:=$modal+"<div class=\"modal-body "+FIX_POPOUP_TAILLE_X+"\">"
		$modal:=$modal+"<div class=\""+FIX_POPOUP_TAILLE_X+"\">"
		$modal:=$modal+"<div class=\"progress progress-striped active\"><div class=\"bar\" style=\"width: 100%;\"></div></div>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"<div class=\"modal-footer\">"
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
	End if 
	
	If (($actions="@M@") | ($actions="@V@"))
		$modal:=$modal+"<div class=\"modal hide\" id=\""+$actionm+"_"+FIX_PARAM_ACTION+"_modal_edit\">"
		$modal:=$modal+"<div class=\"modal-header\">"
		$modal:=$modal+"<button type=\"button\" class=\"close hide\" data-dismiss=\"modal\">x</button>"
		$modal:=$modal+"<h4 style=\"float:left;\">"+UTL_Traduire(Titre; "Modal")+"</h4>"
		$modal:=$modal+"<div class=\"btns\"><a href=\"#\" class=\"btn-annuler-ligne btn-close\"><span class=\"link\">"+UTL_Traduire("Annuler"; "Bouton")+"</span></a></div>"
		If ($actions="@M@")
			$modal:=$modal+"<div class=\"btns\"><a href=\"#\" class=\""+FIX_PARAM_ACTION+" btn-valider-ligne wait\"><span class=\"link\">"+UTL_Traduire("Valider"; "Bouton")+"</span></a></div>"
		End if 
		//Si (FIX_PARAM_FORM_AVN)
		//$modal:=$modal+"<div class=\"btns\"><a href=\"/"+FIX_PARAM_ACTION+"?action=edit&uid=\" class=\""+FIX_PARAM_ACTION+" btn-form-avance\"><span class=\"link\">Form. Avancée</span></a></div>"
		//Fin de si 
		$modal:=$modal+"</div>"
		
		$modal:=$modal+"<div class=\"modal-body\">"
		$modal:=$modal+"<div class=\""+FIX_POPOUP_TAILLE_X+"\">"
		$modal:=$modal+"<div class=\"progress progress-striped active\"><div class=\"bar\" style=\"width: 100%;\"></div></div>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"<div class=\"modal-footer\">"
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
	End if 
	
	If (FIX_PARAM_ACTION#$actionm)
		$sup_class:="sup_ligne"
	Else 
		$sup_class:="sup_enrg"
	End if 
	
	If ($actions="@S@")
		$modal:=$modal+"<div class=\"modal hide\" id=\""+$actionm+"_"+FIX_PARAM_ACTION+"_modal_del\">"
		$modal:=$modal+"<div class=\"modal-header\">"
		$modal:=$modal+"<button type=\"button\" class=\"close hide\" >x</button>"  //data-dismiss=\"modal\"
		$modal:=$modal+"<h4>"+UTL_Traduire(Titre; "Modal")+"</h4>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"<div class=\"modal-body\">"
		$modal:=$modal+"<p>"+UTL_Traduire("Voulez-vous vraiment supprimer cet enregistrement ?"; "Modal")+"</p>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"<div class=\"modal-footer\">"
		$modal:=$modal+"<a href=\"#\" class=\"btn btn-close\" >"+UTL_Traduire("Annuler"; "Bouton")+"</a>"  //data-dismiss=\"modal\"
		$modal:=$modal+"<a href=\"#\" class=\""+FIX_PARAM_ACTION+" "+$sup_class+" btn btn-danger\">"+UTL_Traduire("Supprimer"; "Bouton")+"</a>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
		
	End if 
	
	If ($actions="@D@")  // deversement
		$modal:=$modal+"<div class=\"modal-deversement modal hide\" id=\""+$actionm+"_Web_Deversement_"+FIX_PARAM_ACTION+"\">"
		$modal:=$modal+"<div class=\"modal-header\">"
		$modal:=$modal+"<button type=\"button\" class=\"close hide\" data-dismiss=\"modal\">x</button>"
		$modal:=$modal+"<h4 style=\"float:left;\">"+Titre+"</h4>"
		$modal:=$modal+"<div class=\"btns\"><a href=\"#\" class=\"btn-annuler btn-close\" ><span class=\"link\">Annuler</span></a></div>"
		$modal:=$modal+"<div class=\"btns\"><a href=\"\" class=\""+FIX_PARAM_ACTION+" btn-deverser\" ><span class=\"link\">Valider</span></a></div>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"<div class=\"modal-body\">"
		$modal:=$modal+"<div class=\""+FIX_POPOUP_TAILLE_X+"\">"
		$modal:=$modal+$HTML
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
		$modal:=$modal+"<div class=\"modal-footer\">"
		$modal:=$modal+"</div>"
		$modal:=$modal+"</div>"
		
		$modal:="<div class=\""+FIX_PARAM_ACTION+" block\">"+$modals+"</div>"
	End if 
	
	
End if 


FIX_PARAM_FORM_AVN:=False:C215
FIX_POPOUP_TAILLE_X:="span6"
$0:=$modal