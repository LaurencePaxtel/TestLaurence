//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 03:26:58
// ----------------------------------------------------
// Méthode : WEB_UTL_TAG_HTML
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_TEXT:C284($SCRIPT; $HTML; $begin_groupe; $end_groupe; $invisible; $mode; $class_fdp; $css_class_groupe; $refresh_img; $hide; $strg; $Methode; $event; \
$refresh; $object; $ELEM_10; $groupe_invisible)
C_LONGINT:C283($NB_BTN)
C_BOOLEAN:C305($col2; typehead; datepicker; timepicker)
C_POINTER:C301($TB_HTML; $TB_FORM)

ARRAY TEXT:C222($tb_legende; 0)
ARRAY TEXT:C222($tb_titre; 0)

ARRAY TEXT:C222($TB_ELEM_10; 0)

$TB_HTML:=$1
$TB_FORM:=$2

If (Count parameters:C259=3)
	$mode:=$3
End if 

$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "-"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; " "; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "'"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "/"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "\\"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "*"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "+"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "%"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "#"; "_")
$TB_FORM->{0}{5}:=Replace string:C233($TB_FORM->{0}{5}; "&"; "_")

If ($TB_FORM->{0}{3}="")
	$TB_FORM->{0}{3}:=$TB_FORM->{0}{5}
End if 

$HTML:="<div class=\"row\">"

If ($mode#"content")
	$HTML:=$HTML+"\t<form action=\""+$TB_FORM->{0}{1}+"\" name=\""+$TB_FORM->{0}{3}+"\" id=\""+$TB_FORM->{0}{5}+"\" method=\""+$TB_FORM->{0}{2}+"\" class=\"collectable form-horizontal well "+$TB_FORM->{0}{4}+"\" enctype=\"multipart/form-data\" >\n"
End if 

$HTML:=$HTML+"<div id=\""+$TB_FORM->{0}{5}+"_content\" class=\"row\">"

If (MESSAGE_ETAT="warning")
	$HTML:=$HTML+"\t\t\t\t<div class=\"fdp_message alert alert-"+MESSAGE_ETAT+"\">\n"
	$HTML:=$HTML+"<a class=\"close\" data-dismiss=\"alert\" href=\"#\">x</a>"
	$HTML:=$HTML+MESSAGE_INFO
	$HTML:=$HTML+"</div>"
End if 

$HTML:=$HTML+"\t\t<fieldset>\n"

For ($i; 1; Size of array:C274($TB_HTML->))
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "-"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; " "; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "'"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "/"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "\\"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "*"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "+"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "%"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "#"; "_")
	$TB_HTML->{$i}{6}:=Replace string:C233($TB_HTML->{$i}{6}; "&"; "_")
	
	If ($TB_HTML->{$i}{7}="@fdp_width100@")
		$class_fdp:=" fdp_width100 "
	End if 
	
	If ($TB_HTML->{$i}{7}="@fdp_width40@")
		$class_fdp:=" fdp_width40 "
	End if 
	
	If ($TB_HTML->{$i}{7}="@fdp_width45@")
		$class_fdp:=" fdp_width45 "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_sg@")
		$css_class_groupe:=" iw_sg "
	End if 
	
	If ($TB_HTML->{$i}{7}="@fdp_width50@")
		$class_fdp:=" fdp_width50 "
	End if 
	
	If ($TB_HTML->{$i}{7}="@fdp_row_start@")
		$class_fdp:=$class_fdp+" fdp_row_start "
	End if 
	
	If ($TB_HTML->{$i}{7}="@fdp_margin-top-15px@")
		$class_fdp:=$class_fdp+" fdp_margin-top-15px "
	End if 
	
	If ($TB_HTML->{$i}{7}="@fdp_margin-bottom-15px@")
		$class_fdp:=$class_fdp+" fdp_margin-bottom-15px "
	End if 
	
	If ($TB_HTML->{$i}{7}="@adresse_ligne@")
		$class_fdp:=$class_fdp+" adresse_ligne "
	End if 
	
	If ($TB_HTML->{$i}{7}="@adresse_ligne_autre@")
		$class_fdp:=$class_fdp+" adresse_ligne_autre "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_full@")
		$class_fdp:=$class_fdp+" iw_cg_width_full "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_half@")
		$class_fdp:=$class_fdp+" iw_cg_width_half "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_half@")
		$class_fdp:=$class_fdp+" iw_cg_width_half "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_third@")
		$class_fdp:=$class_fdp+" iw_cg_width_third "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_quarte@")
		$class_fdp:=$class_fdp+" iw_cg_width_quarte "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_display_none@")
		$class_fdp:=$class_fdp+" iw_cg_display_none "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_btn_icon@")
		$class_fdp:=$class_fdp+" iw_cg_btn_icon "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_filtres@")
		$class_fdp:=$class_fdp+" iw_filtres "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_stype_groupe@")
		$class_fdp:=$class_fdp+" iw_stype_groupe "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_test@")
		$class_fdp:=$class_fdp+" iw_cg_test "
	End if 
	
	If ($TB_HTML->{$i}{7}="@cg_iw_confirm_buttons@")
		$class_fdp:=$class_fdp+" iw_confirm_buttons "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_pla_participants@")
		$class_fdp:=$class_fdp+" iw_cg_pla_participants "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_sextuplet@")
		$class_fdp:=$class_fdp+" iw_cg_width_sextuplet "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_5percent@")
		$class_fdp:=$class_fdp+" iw_cg_width_5percent "
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_two_thirds@")
		$class_fdp:=$class_fdp+" iw_cg_width_two_thirds "
		$TB_HTML->{$i}{7}:=Replace string:C233($TB_HTML->{$i}{7}; "iw_cg_width_two_thirds"; "")
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_width_one_third@")
		//$class_fdp:=$class_fdp+" iw_cg_width_one_third "
		//$TB_HTML->{$i}{7}:=Replace string($TB_HTML->{$i}{7};"iw_cg_width_one_third";"")
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_one_groupe_start@")
		$class_fdp:=$class_fdp+" iw_cg_one_groupe_start "
		//$TB_HTML->{$i}{7}:=Replace string($TB_HTML->{$i}{7};"iw_tag_one_groupe_start";"")
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_cg_one_groupe_end@")
		$class_fdp:=$class_fdp+" iw_cg_one_groupe_end "
		//$TB_HTML->{$i}{7}:=Replace string($TB_HTML->{$i}{7};"iw_tag_one_groupe_end";"")
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_mb3_add@")
		$class_fdp:=$class_fdp+" input-group-mb3 mb-3 iw_mb3_add"
		$TB_HTML->{$i}{7}:=Replace string:C233($TB_HTML->{$i}{7}; "input-group-mb3"; "")
	End if 
	
	If ($TB_HTML->{$i}{7}="@iw_mb3_add_updt@")
		$class_fdp:=$class_fdp+" input-group-mb3 mb-3 iw_mb3_add_updt"
		$TB_HTML->{$i}{7}:=Replace string:C233($TB_HTML->{$i}{7}; "input-group-mb3"; "")
	End if 
	
	$TB_HTML->{$i}{7}:=Replace string:C233($TB_HTML->{$i}{7}; "iw_cg"; "iw_tag")
	
	If ($TB_HTML->{$i}{7}="@autocomplete@")
		$SCRIPT:=$SCRIPT+"\t\t$(\"#"+Lowercase:C14($TB_HTML->{$i}{6}; *)+"\").autocomplete({minLength: 2,source: '/"+w_action+"?action=auto&c="+$TB_HTML->{$i}{6}+"'});\n"
	End if 
	
	$TB_HTML->{$i}{5}:=UTL_Traduire($TB_HTML->{$i}{5}; "Formulaire web")
	
	If ($TB_HTML->{$i}{7}="@tags@")
		$SCRIPT:=$SCRIPT+"$('#"+Lowercase:C14($TB_HTML->{$i}{6}; *)+"').tagsManager({"
		$SCRIPT:=$SCRIPT+"preventSubmitOnEnter: true,"
		$SCRIPT:=$SCRIPT+"typeahead: true,"
		$SCRIPT:=$SCRIPT+"blinkBGColor_1: '#FFFF9C',"
		$SCRIPT:=$SCRIPT+"blinkBGColor_2: '#CDE69C'"
		$SCRIPT:=$SCRIPT+"});"
	End if 
	
	// Méthode à rechercher
	If ($TB_HTML->{$i}{7}="@datepicker@")
		datepicker:=True:C214
	End if 
	
	If ($TB_HTML->{$i}{7}="@timepicker@")
		timepicker:=True:C214
	End if 
	
	If ($TB_HTML->{$i}{7}="@col2@")
		$col2:=True:C214
	End if 
	
	If ($TB_HTML->{$i}{7}="@invisible@")
		$invisible:="invisible"
	End if 
	
	If ($TB_HTML->{$i}{10}#"")
		$TB_HTML->{$i}{10}:=Replace string:C233($TB_HTML->{$i}{10}; "\""; "{")
		$TB_HTML->{$i}{10}:=Replace string:C233($TB_HTML->{$i}{10}; "\""; "}")
	End if 
	
	If ($TB_HTML->{$i}{2}="warning")
		$HTML:=$HTML+"\t\t\t\t<div class=\"fdp_message alert alert-"+MESSAGE_ETAT+"\">\n"
		$HTML:=$HTML+"<a class=\"close\" data-dismiss=\"alert\" href=\"#\">x</a>"
		$HTML:=$HTML+MESSAGE_INFO
		$HTML:=$HTML+"</div>"
	End if 
	
	If ($TB_HTML->{$i}{2}#"hidden")
		
		Case of 
			: ($TB_HTML->{$i}{2}="file")
				$HTML:=$HTML+"\t\t\t<div class=\"control-group "+$invisible+"\">\n\t\t\t\t"
				$HTML:=$HTML+"<label class=\"control-label\">"+$TB_HTML->{$i}{5}+" : </label>\n"
				
				$HTML:=$HTML+"\t\t\t\t<div class=\"controls input-append\">\n"
				$HTML:=$HTML+"<input id=\"fakepath\" type=\"text\" class=\" iw_input_browse "+WEB_UTL_VERIFIER_CONTROLE($TB_HTML->{$i}{7})+"\" disabled>"
				
				$HTML:=$HTML+"<script type=\"text/javascript\">"
				$HTML:=$HTML+"function openFileOption()"
				$HTML:=$HTML+"{"
				$HTML:=$HTML+"document.getElementById(\"doc_document\").click();"
				$HTML:=$HTML+"}"
				
				$HTML:=$HTML+"</script>"
				$HTML:=$HTML+"<button class=\"btn btn-file iw_btn_browse\" onclick=\"openFileOption();return false;\">Parcourir...</button>"
			: ((($TB_HTML->{$i}{1}="button") | ($TB_HTML->{$i}{3}="btnannuler")) & ($NB_BTN=0))
				$HTML:=$HTML+"\t\t\t<div class=\"form-actions-\">\n"
			: (($TB_HTML->{$i}{1}#"button") & ($TB_HTML->{$i}{3}#"btnannuler"))
				
				If ($TB_HTML->{$i}{1}="a")
					$label:=$TB_HTML->{$i}{3}
				Else 
					$label:=$TB_HTML->{$i}{5}
				End if 
				
				If ($TB_HTML->{$i}{7}="@DEBUT_GROUPE@")
					$strg:=$TB_HTML->{$i}{7}
					UTL_Decoupe_texte(->$strg; ->$tb_legende; "DEBUT_GROUPE[")
					
					UTL_Decoupe_texte(->$tb_legende{2}; ->$tb_titre; "]")
					$titre:=$tb_titre{1}
					
					If ($TB_HTML->{$i}{7}="@groupe_invisible@")
						$groupe_invisible:="invisible"
					End if 
					
					$begin_groupe:="<div class=\"form-horizontal "+$groupe_invisible+" groupe\"><legend>"+UTL_Traduire($tb_titre{1}; "Formulaire web")+"</legend>"
					$end_groupe:=""
				Else 
					$begin_groupe:=""
					
					If ($TB_HTML->{$i}{7}="@FIN_GROUPE@")
						$end_groupe:="</div>"
					Else 
						$end_groupe:=""
					End if 
					
				End if 
				
				///-- fin code legend ->
				$create_div_html:=True:C214
				
				If ($TB_HTML->{$i}{7}="@iw_start_div_parent@")
					
					If ($TB_HTML->{$i}{7}="@iw_start_div_parent@")
						$HTML:=$HTML+$begin_groupe+"\t\t\t<div class=\"iw_groupe_parent \">\n\t\t\t\t"
					End if 
					
				End if 
				
				If ($TB_HTML->{$i}{7}="@iw_tag_one_groupe_start@")
					$HTML:=$HTML+$begin_groupe+"\t\t\t<div class=\"iw_tag_one_groupe_start iw_cg_width_one_third "+$class_fdp+$invisible+"\">\n\t\t\t\t"
				End if 
				
				$HTML:=$HTML+$begin_groupe+"\t\t\t<div class=\"control-group "+$class_fdp+$invisible+"\">\n\t\t\t\t"
				
				//If ((($TB_HTML->{$i}{7}="@fdp_placeholder@") & ($TB_HTML->{$i}{4}#"")) | (Not($TB_HTML->{$i}{7}="@fdp_select@")))
				
				// Modified by: Kevin HASSAL (2017-06-20)
				If ((Not:C34($TB_HTML->{$i}{7}="@fdp_select@")) & (RECORD_ACT_EDIT))
					$HTML:=$HTML+"<label class=\"control-label-group\">"+$label+"</label>\n"
				End if 
				
				$HTML:=$HTML+"\t\t\t\t<div class=\"controls "+$css_class_groupe+"\">\n"
				$invisible:=""
		End case 
		
	End if 
	
	$TB_HTML->{$i}{7}:=WEB_UTL_VERIFIER_CONTROLE($TB_HTML->{$i}{7})
	
	// Manipulation de la méthode 4D refresh
	If ($TB_HTML->{$i}{10}#"")
		$ELEM_10:=$TB_HTML->{$i}{10}
		UTL_Decoupe_texte(->$ELEM_10; ->$TB_ELEM_10; ";")
		
		If (Size of array:C274($TB_ELEM_10)>=2)
			$Methode:=$TB_ELEM_10{1}
			$event:=";"+$TB_ELEM_10{2}
			
			If (Size of array:C274($TB_ELEM_10)>=3)
				$refresh:=";"+$TB_ELEM_10{3}
			End if 
			
			If (Size of array:C274($TB_ELEM_10)=4)
				$object:=";"+$TB_ELEM_10{4}
			End if 
			
			$TB_HTML->{$i}{7}:=$TB_HTML->{$i}{7}+" Methode["+$Methode+$event+$refresh+$object+"]"
		End if 
		
	End if 
	
	// manipulation du methode 4d rechercher
	If (($TB_HTML->{$i}{8}#"") & ($TB_HTML->{$i}{8}#"@|@"))
		C_TEXT:C284(MethodeRechercher)
		
		MethodeRechercher:=$TB_HTML->{$i}{8}
		MethodeRechercher:=Replace string:C233(MethodeRechercher; "{}"; "")
		MethodeRechercher:=Replace string:C233(MethodeRechercher; "()"; "")
		MethodeRechercher:=" data-MethodeRechercher="+MethodeRechercher
		//$TB_HTML->{$i}{7}:=$TB_HTML->{$i}{7}+" MethodeRechercher["+$MethodeRechercher+"]"
	End if 
	
	If ($TB_HTML->{$i}{7}="@uneditable@")
		$TB_HTML->{$i}{7}:=Replace string:C233($TB_HTML->{$i}{7}; "uneditable"; "uneditable-input")
	End if 
	
	If ($TB_HTML->{$i}{10}="@refresh_object@")
		$refresh_img:="<img class=\"refresh-load hide\" src=\""+HTML_LAYOUT_PATH+"img/refresh-load.gif\" style=\"margin-left: 5px;\" />"
	End if 
	
	// Création des tags html
	$HTML:=$HTML+WebAGL_Create_Tag_HTML($TB_HTML->{$i}{1}; $TB_HTML->{$i}{2}; $TB_HTML->{$i}{3}; $TB_HTML->{$i}{4}; $TB_HTML->{$i}{5}; $TB_HTML->{$i}{6}; $TB_HTML->{$i}{7})+$refresh_img+$end_groupe
	
	If ($TB_HTML->{$i}{2}#"hidden") & ($TB_HTML->{$i}{1}#"button") & ($TB_HTML->{$i}{3}#"btnannuler")
		$HTML:=$HTML+"\t\t\t\t</div>\n"
	End if 
	
	If ($TB_HTML->{$i}{2}#"hidden")
		
		Case of 
			: (($TB_HTML->{$i}{1}="button") & ($i=Size of array:C274($TB_HTML->))) | ($TB_HTML->{$i}{1}#"button")
				
				If ($TB_HTML->{$i}{7}="@iw_tag_one_groupe@")
					
					If ($TB_HTML->{$i}{7}="@iw_tag_one_groupe_end@")
						$HTML:=$HTML+"\t\t\t</div>\n"
					End if 
					
				End if 
				
				$HTML:=$HTML+"\t\t\t</div>\n"
				
				If ($TB_HTML->{$i}{7}="@iw_end_div_parent@")
					
					If ($TB_HTML->{$i}{7}="@iw_end_div_parent@")
						$HTML:=$HTML+"\t\t\t</div>\n"
					End if 
					
				End if 
				
			: ($TB_HTML->{$i}{1}="button")
				$NB_BTN:=$NB_BTN+1
		End case 
		
	End if 
	
	outilsCleanVariable(->$class_fdp; ->$refresh_img; ->$hide; ->$strg; ->$Methode; ->$event; ->$refresh; ->$object; ->$ELEM_10; ->$groupe_invisible; \
		->$tb_legende; ->$tb_titre; ->$TB_ELEM_10)
End for 

$HTML:=$HTML+"\t\t</fieldset>\n"
$HTML:=$HTML+BTN_LISTE
$HTML:=$HTML+"</div>"

If ($mode#"content")
	$HTML:=$HTML+"\t</form>\n"
End if 

$HTML:=$HTML+"\t</div>\n"

SCRIPT:=SCRIPT+$SCRIPT
$0:=$HTML