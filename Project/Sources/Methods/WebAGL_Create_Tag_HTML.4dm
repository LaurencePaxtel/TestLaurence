//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 03:43:32
// ----------------------------------------------------
// Méthode : WebAGL_Create_Tag_HTML
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
C_TEXT:C284($7)

C_TEXT:C284($selected; $output; $data; $placeholder; $icon; MethodeRechercher; $disabled; $iw_btn_delete; $checked_status; $checkbox_value; $data_column_value; $output_tmp; $output_custom; $autocompleteOn; \
$date_converti; $value; $data_value; $checked_fdp_checkbox; $dataval; $label; $width; $height; $lien; $value_checkbox; $captcha; $html_tag; $multiple)
C_BOOLEAN:C305($continu)

ARRAY TEXT:C222($valeurs; 0)
ARRAY TEXT:C222($key_val; 0)
ARRAY TEXT:C222($tb_elem; 0)
ARRAY TEXT:C222($tb_tmp; 0)

$tag:=$1
$type:=$2
$name:=$3
$value:=String:C10($4)

$label:=$5
$id:=Lowercase:C14($6; *)
$class:=Lowercase:C14($7; *)

$continu:=True:C214

FIX_TIME_FORMAT:="hh:mm"

Case of 
	: ($class="@iw_data_column_0@")
		$data_column_value:="0"
	: ($class="@iw_data_column_1@")
		$data_column_value:="1"
	: ($class="@iw_data_column_2@")
		$data_column_value:="2"
	: ($class="@iw_data_column_3@")
		$data_column_value:="3"
	: ($class="@iw_data_column_4@")
		$data_column_value:="4"
	: ($class="@iw_data_column_5@")
		$data_column_value:="5"
	: ($class="@iw_data_column_6@")
		$data_column_value:="6"
	: ($class="@iw_data_column_7@")
		$data_column_value:="7"
	: ($class="@iw_data_column_8@")
		$data_column_value:="8"
	: ($class="@iw_data_column_9@")
		$data_column_value:="9"
	: ($class="@iw_data_column_10@")
		$data_column_value:="10"
	: ($class="@iw_data_column_all@")
		$data_column_value:="all"
End case 

If ($class="@disabled@")
	$disabled:="disabled=disabled"
End if 

If ($class="@fdp_placeholder@")
	$placeholder:="placeholder=\""+$label+"\""
End if 

Case of 
	: ($class="@readonly@") | ($class="@read_only@")
		$disabled:="readonly"
	: ($tag="iw-popup@")
		$tag:="input"
		$type:="text"
		
		CLEAR VARIABLE:C89($placeholder)
End case 

datepicker:=($class="@datepicker@")

Case of 
	: ($tag="paragraph")
		$0:="<p class=\""+$class+"\" >"+$value+"</p>"
	: ($tag="img")  //-------------------IMG------------------------------///
		
		If ($type#"")
			UTL_Decoupe_texte(->$type; ->$tb_elem; "*")
			
			$width:=$tb_elem{1}
			$height:=$tb_elem{2}
		Else 
			$width:="150"
			$height:="150"
		End if 
		
		$lab_button:="Parcourir ..."
		
		If ($name="")
			$lien:="/GetImage?uid="+$value
		Else 
			$lien:="/GetImage?uid="+$value+"&CT="+$name
		End if 
		
		///--- FIN traitement image ------------------------------------------------------------
		$lab:="<label for=\"image\" class=\"btn\">"+$lab_button+"</label><input type=\"file\" name=\"image\" id=\"image\"/><br>"
		
		$0:="<img src=\""+$lien+"\" id=\""+$id+"\" width=\""+$width+"\" height=\""+$height+"\" class=\""+$class+"\" /><br>"+$lab+"\n"
	: ($tag="label")  //-------------------LABEL------------------------------///
		$0:="<label id=\""+$id+"\" "+Choose:C955($name#""; "for=\""+$name+"\" "; "")+"class=\""+$class+"\"/>"+$label+"</label>\n"
	: ($tag="link")  //-------------------LINK------------------------------///
		$0:="<a href=\"\" id=\""+$id+"\" for=\""+$name+"\" class=\""+$class+"\"/>"+$label+"</a>\n"
	: ($tag="a")  //-------------------LINK------------------------------///
		$0:="\t\t\t\t<a id=\""+$id+"\" target=\""+$type+"\" name=\""+$name+"\" href=\""+$value+"\" class=\""+$class+"\">"+$label+"</a>\n"
	: ($tag="iw_search")
		$0:="\t\t\t\t\t<input data-val=\""+$value+"\" data-column=\""+$data_column_value+"\" type=\""+$type+"\" id=\""+$id+"\" name=\""+$name+"\" value=\""+$value+"\" class=\""+$class+"\" "+$data+" "+$placeholder+"  />\n"
	: ($tag="input")  //-------------------INPUT------------------------------///
		
		Case of 
			: ($type="radio") | ($type="checkbox")
				$output:="<div class=\"small-12 medium-6 column fillable add-auction-column\">"
				$output:=$output+"<div class=\"small-12 medium-6 column fillable add-auction-column\">"
				$output:=$output+"<div class=\"fdp-border\">"
				$output:=$output+"<label class=\"checkbox_list-label\" for=\"services\">"+$label+"</label>"
				$output:=$output+"<ul class=\"checkbox-list checkbox-list--services clearfix\">"
				
				UTL_Decoupe_texte(->$value; ->$valeurs; "|")
				
				For ($i; 1; Size of array:C274($valeurs))
					outilsCleanVariable(->$tb_tmp; ->$checked_fdp_checkbox)
					UTL_Decoupe_texte(->$valeurs{$i}; ->$tb_tmp; ";")
					
					// Modifié par : Scanu Rémy (09/09/2022)
					If (Size of array:C274($tb_tmp)=3)
						
						If ($tb_tmp{3}="true")
							$checked_fdp_checkbox:="checked"
						End if 
						
					End if 
					
					// Modifié par : Scanu Rémy (09/09/2022)
					If ($tb_tmp{2}#"")
						$output:=$output+"<li class=\"checkbox-item checkbox-list-item checkbox-item--services\">"
						$output:=$output+"<label class=\"checkbox-label checkbox-list-label checkbox-label--services\">"
						$output:=$output+"<input id=\"checkbox"+String:C10($i)+"\" class=\"checkbox-input checkbox-list-input checkbox-input--services search "+$name+"\" type=\"checkbox\" name=\""+$tb_tmp{1}+"\" value=\""+$tb_tmp{2}+"\" data-column=\""+$data_column_value+"\" "+$checked_fdp_checkbox+"/>"
						$output:=$output+"<span class=\"checkbox-span checkbox-list-span checkbox-span--services\">"+$tb_tmp{2}+"</span>"
						$output:=$output+"</label>"
						$output:=$output+"</li>"
					End if 
					
				End for 
				
				$output:=$output+"</ul>"
				$output:=$output+"</div>"
				$output:=$output+"</div>"
				$output:=$output+"</div>"
			: ($type="iw_radio_group")
				$output:="<div class=\"small-12 medium-6 column fillable add-auction-column\">"
				$output:=$output+"<div class=\"small-12 medium-6 column fillable add-auction-column\">"
				$output:=$output+"<div class=\"fdp-border iw_radio_group\">"
				$output:=$output+"<ul class=\"checkbox-list checkbox-list--services clearfix\">"
				
				UTL_Decoupe_texte(->$value; ->$valeurs; "|")
				
				For ($i; 1; Size of array:C274($valeurs))
					outilsCleanVariable(->$tb_tmp; ->$checked_fdp_checkbox)
					UTL_Decoupe_texte(->$valeurs{$i}; ->$tb_tmp; ";")
					
					$dataval:=Replace string:C233($tb_tmp{2}; " "; "")
					$output:=$output+"<li class=\"checkbox-item checkbox-list-item checkbox-item--services\">"
					$output:=$output+"<label class=\"checkbox-label checkbox-list-label checkbox-label--services\">"
					$output:=$output+"<input class=\"checkbox-input checkbox-list-input checkbox-input--services\" type=\"checkbox\" id=\""+$tb_tmp{1}+"\"  name=\""+$tb_tmp{1}+"\" onclick=\"\" value=\""+$tb_tmp{2}+"\" dataval=\""+$dataval+"\" "+$checked_fdp_checkbox+" >"
					$output:=$output+"<span class=\"checkbox-span checkbox-list-span checkbox-span--services\">"+$tb_tmp{2}+"</span>"
					$output:=$output+"</label>"
					$output:=$output+"</li>"
				End for 
				
				$output:=$output+"</ul>"
				$output:=$output+"<input type=\"hidden\"id=\""+$tb_tmp{1}+"_checked_value\" value=\"\">"
				$output:=$output+"</div>"
				$output:=$output+"</div>"
				$output:=$output+"</div>"
			: ($type="checkbox_simple")
				$output:="<div class=\"checkbox_simple\">"
				$output:=$output+"<ul class=\"\">"
				
				UTL_Decoupe_texte(->$value; ->$valeurs; "|")
				
				For ($i; 1; Size of array:C274($valeurs))
					outilsCleanVariable(->$tb_tmp; ->$checked_fdp_checkbox)
					UTL_Decoupe_texte(->$valeurs{$i}; ->$tb_tmp; ";")
					
					If (($tb_tmp{3}="true") | ($tb_tmp{3}="vrai"))
						$checked_fdp_checkbox:="checked"
					End if 
					
					$output:=$output+"<li class=\"\">"
					$output:=$output+"<input class=\"\" Type=\"checkbox\" id=\""+$tb_tmp{1}+"\"  id=\""+$tb_tmp{1}+"\" onclick=\"\" value=\""+$tb_tmp{3}+"\" "+$checked_fdp_checkbox+" >"
					$output:=$output+"<span class=\""+$class+"\">"+$tb_tmp{2}+"</span>"
					$output:=$output+"</li>"
				End for 
				
				$output:=$output+"</ul>"
				$output:=$output+"</div>"
			: ($type="iw_checkbox_wt")
				$value_checkbox:="false"
				UTL_Decoupe_texte(->$value; ->$valeurs; "|")
				
				For ($i; 1; Size of array:C274($valeurs))
					outilsCleanVariable(->$tb_tmp; ->$checked_fdp_checkbox)
					UTL_Decoupe_texte(->$valeurs{$i}; ->$tb_tmp; ";")
					
					If (($tb_tmp{3}="true") | ($tb_tmp{3}="vrai"))
						$checked_fdp_checkbox:="checked"
						$value_checkbox:="true"
					End if 
					
					$output:=$output+"<input class=\"iw_checkbox_wt\" Type=\"checkbox\" id=\""+$tb_tmp{1}+"\"  id=\""+$tb_tmp{1}+"\" onclick=\"\" value=\""+$value_checkbox+"\" "+$checked_fdp_checkbox+" >"
				End for 
				
			Else 
				
				Case of 
					: (typehead)
						$data:="data-provide=\"typeahead\""
					: (datepicker)
						$date_converti:=Replace string:C233(FIX_DATE_FORMAT; "jj"; "dd")
						$date_converti:=Replace string:C233($date_converti; "aaaa"; "yyyy")
						
						$data:="data-date-format="+$date_converti
						$placeholder:="placeholder=\""+FIX_DATE_FORMAT+"\""
						
						$value:=Replace string:C233($value; "-"; "/")
					: (timepicker)
						$date_converti:=Replace string:C233(FIX_TIME_FORMAT; "jj"; "dd")
						$date_converti:=Replace string:C233($date_converti; "aaaa"; "yyyy")
						
						$data:="data-format="+$date_converti
						$placeholder:="placeholder=\""+FIX_TIME_FORMAT+"\""
				End case 
				
				$autocompleteOn:="off"
				
				If (($class="@fdp_adress_autocomplete@") | ($class="@fdp_captcha@"))
					
					If ($class="@fdp_adress_autocomplete@")
						UTL_Add_Script("adress_autocomplete")
						
						$output:="\t\t\t\t\t <input id=\"autocomplete\" placeholder=\""+$label+"\" onFocus=\"geolocate()\" type=\"text\" class=\""+$class+"\">"+$icon+"\n"
					Else 
						
						If (Undefined:C82(fdp_captcha))
							C_PICTURE:C286(fdp_captcha)
						End if 
						
						$captcha:="<div class=\"fdp_captcha\">"
						$captcha:=$captcha+"<img src=\"/captcha\" style=\"margin: 5px 0px 7px 11px;display:none !important;\" /><br/>"
						$captcha:=$captcha+"<!--4Dvar fdp_captcha--><br/>"
						$captcha:=$captcha+"<input type=\"text\" class=\"span7 search fdp_adress_field captcha\" name=\"captcha\"/>"
						
						$captcha:=$captcha+"<span style=\"color:#8a8a8a;padding-left:5px;font-size:12px;padding-top:2px;\">* "+LANG_TXT_CAPTCHA+"</span>"
						$captcha:=$captcha+"</div>"
						
						$output:=$captcha
					End if 
					
				Else 
					$textarea_rows:="8"
					
					If ($class="@iw_textarea_rows_10@")
						$textarea_rows:="10"
					End if 
					
					If ($class="@iw_textarea_rows_5@")
						$textarea_rows:="5"
					End if 
					
					Case of 
						: ($type="textarea")
							$output:="\t\t\t\t\t<textarea "+$disabled+" id=\""+$id+"\" name=\""+$name+"\"  class=\""+$class+"\" "+$placeholder+" rows=\""+$textarea_rows+"\" rows=\"10\">"+$value+"</textarea>\n"
						: ($type="button") & ($class="@iw_icon@")
							$icon:=Web_UTL_HTML_Icon_Get($class)
							$output:="\t\t\t\t\t<button "+$disabled+" id=\""+$id+"\" name=\""+$name+"\"  class=\""+$class+"\" "+$placeholder+" >"+$icon+$value+"</button>\n"
						Else 
							$output:="\t\t\t\t\t<input "+$disabled+" "+MethodeRechercher+" data-val=\""+$value+"\" data-column=\""+$data_column_value+"\" type=\""+$type+"\" id=\""+$id+"\" name=\""+$name+"\" value=\""+$value+"\" class=\""+$class+"\" "+$data+" "+$placeholder+" autocomplete=\""+$autocompleteOn+"\" />"+$icon+"\n"
					End case 
					
				End if 
				
		End case 
		
		If (WEB_CHAMP_Obligatoire)
			PARAM_MANDATORY_FIELDS:=PARAM_MANDATORY_FIELDS+$id+";"
		End if 
		
		WEB_CHAMP_Obligatoire:=False:C215
		
		If ($class="@iw_btns_add@")
			$output:=$output+"<div class=\"input-group-append-mb3\">"
			$output:=$output+"<button class=\"btn btn-warning iw_btn_add\"  id=\"btn_add_"+$id+"\"  type=\"button\"><i class=\"fa fa-plus\"></i></button>"
			
			If ($class="@iw_btns_add_update@")
				$output:=$output+"<button class=\"btn btn-info iw_btn_updt\"  id=\"btn_updt_"+$id+"\"  type=\"button\"><i class=\"fa fa-pencil\"></i></button>"
			End if 
			
			$output:=$output+"</div>"
		End if 
		
		$0:=$output
	: ($tag="iw-datepicker")
		$icon:="<span class=\"fa fa-calendar\"></span>"
		
		$html_tag:="<li class=\"iw-icon\">"
		$html_tag:=$html_tag+"\t\t\t\t\t<input "+$disabled+"  data-val=\""+$value+"\" data-column=\""+$data_column_value+"\" type=\""+$type+"\" id=\""+$id+"\" name=\""+$name+"\" value=\""+$value+"\" class=\""+$class+"\" "+$data+" "+$placeholder+" autocomplete=\"off\" />"+$icon+"\n"
		$html_tag:=$html_tag+"</li>"
		
		$0:=$html_tag
	: ($tag="iw-popup")
		$iw_btn_delete:="btn-delete=\"true\""
		
		$tag_html:="<div class=\"iw-popups\">"
		$tag_html:=$tag_html+"<div modal-list name=\""+$id+"\" json=\"autres_criteres\" "+$iw_btn_delete+" ></div>"
		$tag_html:=$tag_html+"</div>"
		
		$0:=$tag_html
	: ($tag="iw-popup-simple-")
		$iw_btn_delete:="btn-delete=\"true\""
		
		$tag_html:="<div class=\"iw-popups\">"
		$tag_html:=$tag_html+"<div modal-list name=\""+$id+"\" json=\""+$id+"\" "+$iw_btn_delete+"></div>"
		$tag_html:=$tag_html+"</div>"
		
		$0:=$tag_html
	: ($tag="iw-popup-simple")
		
		If (WEB_CHAMP_Obligatoire)
			PARAM_MANDATORY_FIELDS:=PARAM_MANDATORY_FIELDS+$id+";"
		End if 
		
		WEB_CHAMP_Obligatoire:=False:C215
		$iw_btn_delete:="btn-delete=\"true\""
		
		$tag_html:="<div class=\"iw-popups\">"
		$tag_html:=$tag_html+"<div modal-list name=\""+$id+"\" json=\""+$id+"\" "+$iw_btn_delete+" values=\""+$value+"\"></div>"
		$tag_html:=$tag_html+"</div>"
		
		$0:=$tag_html
	: ($tag="iw_radio")
		$checkbox_value:="False"
		
		If (($value="Vrai") | ($value="True"))
			$checked_status:="checked"
			$checkbox_value:="True"
		End if 
		
		If ($disabled="readonly")
			$disabled:="disabled"
		End if 
		
		$tag_html:="<div class=\"radio-list\">"
		$tag_html:=$tag_html+"<input name=\""+$name+"\" id=\""+$id+"\" type=\"checkbox\" "+$checked_status+" value=\""+$checkbox_value+"\" data-size=\"normal\" "+$disabled+">"
		$tag_html:=$tag_html+"</div>"
		
		$0:=$tag_html
	: ($tag="iw_radio_2")
		
		If ($value="@checked")
			$checked_status:="checked"
		End if 
		
		$value:=Replace string:C233($value; "checked"; "")
		
		If ($disabled="readonly")
			$disabled:="disabled"
		End if 
		
		$tag_html:="<div class=\"radio-list\">"
		$tag_html:=$tag_html+"<input name=\""+$name+"\" id=\""+$id+"\" type=\"radio\" "+$checked_status+" value=\""+$value+"\" data-size=\"normal\" "+$disabled+">"
		$tag_html:=$tag_html+"</div>"
		
		$0:=$tag_html
	: ($tag="iw_input_small")
		$tag_html:="<label class=\"iw_input_small\">"
		$tag_html:=$tag_html+"<input name=\""+$name+"\" id=\""+$id+"\" Type=\"number\" value=\""+$value+"\" min=\"0\">"
		$tag_html:=$tag_html+"<div>"+$label+"</div>"
		$tag_html:=$tag_html+"</label>"
		
		$0:=$tag_html
	: ($tag="textarea")  //-------------------TEXTAREA------------------------------///
		$0:="\t\t\t\t\t<textarea "+$disabled+" id=\""+$id+"\" name=\""+$name+"\" class=\""+$class+"\">"+$value+"</textarea>\n"
	: ($tag="select")  //-------------------SELECT------------------------------///
		
		If ($type="multiple")
			$multiple:="multiple=\"multiple\""
		End if 
		
		If ($class="@fdp_multiselect_single@")
			UTL_Add_Script("fdp_multiselect_single")
		End if 
		
		If ($type="@fdp_stars@")
			UTL_Add_Script("fdp_stars")
			$class:="star "
			
			If ($class#"@fdp_stars_readonly@")
				$output:="<label id=\""+$id+"lbl\" for=\""+$name+"\"  style=\"display:block !important; font-weight:normal !important;\"/>"+$label+"</label>\n"
			Else 
				$class:="star fdp_stars_readonly"
			End if 
			
		End if 
		
		UTL_Decoupe_texte(->$value; ->$valeurs; "|")
		
		If ($type="@fdp_stars@")
			$output_tmp:=$output_tmp+"\t\t\t\t\t<select "+$disabled+" id=\""+$id+"\" class=\""+$class+"\" name=\""+$name+"\" "+$multiple+" default-data-rating=\""+$data_value+"\" data-column=\""+$data_column_value+"\" >\n"
		Else 
			$output_tmp:=$output_tmp+"\t\t\t\t\t<select "+$disabled+" id=\""+$id+"\" class=\""+$class+"\" name=\""+$name+"\" "+$multiple+"  data-column=\""+$data_column_value+"\" >\n"
		End if 
		
		For ($i; 1; Size of array:C274($valeurs))
			
			If ($i=1)
				UTL_Decoupe_texte(->$valeurs{$i}; ->$key_val; ";")
			Else 
				UTL_Decoupe_texte(->$valeurs{$i}; ->$key_val; "_")
			End if 
			
			If (Size of array:C274($key_val)=3)
				
				If ($key_val{3}="s")
					$selected:="selected=\"selected\""
				End if 
				
			End if 
			
			If ($i=1)
				
				If (Size of array:C274($key_val)<1)
					$continu:=False:C215
				End if 
				
			Else 
				
				If (Size of array:C274($key_val)<2)
					$continu:=False:C215
				End if 
				
			End if 
			
			If ($continu)
				
				Case of 
					: ($type="@fdp_stars@")
						$output:=$output+"\t\t\t\t\t\t<option value=\""+$key_val{1}+"\" "+$selected+" data-rating=\""+$data_value+"\" >"+$key_val{2}+"</option>\n"
					: ($i=1)
						$output_custom:="\t\t\t\t\t\t<option value=\""+Choose:C955($key_val{1}="Sélection d'un élément"; ""; $key_val{1})+"\" "+$selected+">"+UTL_Traduire($key_val{1})+"</option>\n"
					Else 
						$output:=$output+"\t\t\t\t\t\t<option value=\""+$key_val{1}+"\" "+$selected+"  >"+UTL_Traduire($key_val{2})+"</option>\n"
				End case 
				
			End if 
			
			outilsCleanVariable(->$selected; ->$key_val)
		End for 
		
		$output:=$output_tmp+$output_custom+$output+"\t\t\t\t\t</select>\n"
		$0:=$output
	: ($tag="iw_select")
		
		If ($type="multiple")
			$multiple:="multiple=\"multiple\""
		Else 
			$multiple:=""
		End if 
		
		If ($class="@fdp_multiselect_single@")
			UTL_Add_Script("fdp_multiselect_single")
		End if 
		
		If ($type="@fdp_stars@")
			UTL_Add_Script("fdp_stars")
			$class:="star "
			
			If ($class#"@fdp_stars_readonly@")
				$output:="<label id=\""+$id+"lbl\" for=\""+$name+"\"  style=\"display:block !important; font-weight:normal !important;\"/>"+$label+"</label>\n"
			Else 
				$class:="star fdp_stars_readonly"
			End if 
			
		End if 
		
		UTL_Decoupe_texte(->$value; ->$valeurs; "|")
		
		If ($type="@fdp_stars@")
			$output_tmp:=$output_tmp+"\t\t\t\t\t<select "+$disabled+" id=\""+$id+"\" class=\""+$class+"\" name=\""+$name+"\" "+$multiple+" default-data-rating=\""+$data_value+"\" data-column=\""+$data_column_value+"\" >\n"
		Else 
			$output_tmp:=$output_tmp+"\t\t\t\t\t<select "+$disabled+" id=\""+$id+"\" class=\""+$class+"\" name=\""+$name+"\" "+$multiple+"  data-column=\""+$data_column_value+"\" >\n"
		End if 
		
		For ($i; 1; Size of array:C274($valeurs))
			
			If ($i=1)
				UTL_Decoupe_texte(->$valeurs{$i}; ->$key_val; ";")
			Else 
				UTL_Decoupe_texte(->$valeurs{$i}; ->$key_val; "_")
			End if 
			
			If (Size of array:C274($key_val)=3)
				
				If ($key_val{3}="s")
					$selected:="selected=\"selected\""
				End if 
				
			End if 
			
			If (Size of array:C274($key_val)<2)
				$continu:=False:C215
			End if 
			
			If ($continu)
				
				If ($type="@fdp_stars@")
					$output:=$output+"\t\t\t\t\t\t<option value=\""+$key_val{1}+"\" "+$selected+" data-rating=\""+$data_value+"\">"+$key_val{2}+"</option>\n"
				Else 
					$output:=$output+"\t\t\t\t\t\t<option value=\""+$key_val{1}+"\" "+$selected+">"+UTL_Traduire($key_val{2})+"</option>\n"
				End if 
				
			End if 
			
			outilsCleanVariable(->$key_val; ->$selected)
		End for 
		
		$output:=$output_tmp+$output_custom+$output+"\t\t\t\t\t</select>\n"
		$0:=$output
	: ($tag="iw_select_btn")
		$output_tmp:=$output_tmp+"\t\t\t\t\t<select "+$disabled+" id=\""+$id+"\" class=\"form-control-mb3 "+$class+"\" name=\""+$name+"\"   data-column=\"\" >\n"
		UTL_Decoupe_texte(->$value; ->$valeurs; "|")
		
		For ($i; 1; Size of array:C274($valeurs))
			
			If ($i=1)
				UTL_Decoupe_texte(->$valeurs{$i}; ->$key_val; ";")
			Else 
				UTL_Decoupe_texte(->$valeurs{$i}; ->$key_val; "_")
			End if 
			
			If (Size of array:C274($key_val)=3)
				
				If ($key_val{3}="s")
					$selected:="selected=\"selected\""
				End if 
				
			End if 
			
			If (Size of array:C274($key_val)<2)
				$continu:=False:C215
			End if 
			
			If ($continu)
				
				If ($type="@fdp_stars@")
					$output:=$output+"\t\t\t\t\t\t<option value=\""+$key_val{1}+"\" "+$selected+" data-rating=\""+$data_value+"\" >"+$key_val{2}+"</option>\n"
				Else 
					$output:=$output+"\t\t\t\t\t\t<option value=\""+$key_val{1}+"\" "+$selected+"  >"+UTL_Traduire($key_val{2})+"</option>\n"
				End if 
				
			End if 
			
		End for 
		
		$output:=$output_tmp+$output_custom+$output+"\t\t\t\t\t</select>\n"
		
		$output:=$output+"<div class=\"iw_margin_left_5px iw_margin_left_5px\">"
		$output:=$output+"<button class=\"btn btn-warning\"  id=\"btn_add_"+$id+"\"  type=\"button\"><i class=\"fa fa-plus\"></i></button>"
		$output:=$output+"<button class=\"btn btn-info iw_margin_left_5px\"  id=\"btn_updt_"+$id+"\"  type=\"button\"><i class=\"fa fa-pencil\"></i></button>"
		$output:=$output+"</div>"
		
		$0:=$output
	: ($tag="button") | ($tag="iw_button_icon")  //-------------------BUTTON------------------------------///
		$0:="\t\t\t\t<button "+$disabled+" data-val=\"\" id=\""+$id+"\" name=\""+$name+"\" type=\""+$type+"\" class=\""+$class+"\">"+$value+"</button>\n"
End case 

// init
MethodeRechercher:=""

typehead:=False:C215
datepicker:=False:C215
timepicker:=False:C215