//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/10/18, 07:43:31
// ----------------------------------------------------
// Méthode : WebAGL_send_json_refresh
// Description
// 
//
// Paramètres
// ----------------------------------------------------


C_TEXT:C284($HTML; MethodeRechercher; $ALERTE_MESSAGE; REDIRECT; CONFIRM_MESSAGE; $CONFIRM_MESSAGE; $REDIRECT_TAB; $REDIRECT; $REDIRECT_TAB; LH_SAISIE; $LH_SAISIE; $ALERTE_MODAL; $CELLS_VALEURS; CELLS_VALEURS)
ARRAY TEXT:C222($TB_HTML; 0; 7)
C_BOOLEAN:C305(datepicker; timepicker; typehead)

If (Count parameters:C259>=1)
	C_POINTER:C301($1)
	COPY ARRAY:C226($1->; $TB_HTML)
End if 




For ($i; 1; Size of array:C274($TB_HTML))
	
	// methode de traitement 4D
	If ($TB_HTML{$i}{10}#"")
		C_TEXT:C284($Methode; $event; $refresh; $object; $ELEM_10)
		
		ARRAY TEXT:C222($TB_ELEM_10; 0)
		$ELEM_10:=$TB_HTML{$i}{10}
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
			$TB_HTML{$i}{7}:=$TB_HTML{$i}{7}+" Methode["+$Methode+$event+$refresh+$object+"]"
		End if 
	End if 
	
	If ($TB_HTML{$i}{7}="@col2@")
		$TB_HTML{$i}{7}:=Replace string:C233($TB_HTML{$i}{7}; "col2"; "")
	End if 
	
	
	// manipulation du methode 4d rechercher
	If (($TB_HTML{$i}{8}#"") & ($TB_HTML{$i}{8}#"@|@"))
		
		MethodeRechercher:=$TB_HTML{$i}{8}
		MethodeRechercher:=Replace string:C233(MethodeRechercher; "{}"; "")
		MethodeRechercher:=Replace string:C233(MethodeRechercher; "()"; "")
		MethodeRechercher:=" data-MethodeRechercher="+MethodeRechercher
	End if 
	
	// forcer le format pour le id
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; ","; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "-"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; " "; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "'"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "/"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "*"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "+"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "%"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "#"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; "&"; "_")
	$TB_HTML{$i}{6}:=Replace string:C233($TB_HTML{$i}{6}; " "; "_")
	
	
	If ($TB_HTML{$i}{7}="@datepicker@")
		datepicker:=True:C214
	End if 
	
	If ($TB_HTML{$i}{7}="@timepicker@")
		timepicker:=True:C214
	End if 
	
	//Si ($TB_HTML{$i}{7}="@col2@")
	//$col2:=Vrai
	//Fin de si 
	
	If ($TB_HTML{$i}{7}="@invisible@")
		$invisible:="invisible"
	End if 
	$HTML:=$HTML+"'"+Lowercase:C14($TB_HTML{$i}{6}; *)+"':'"+WEB_UTL_format_js(WebAGL_Create_Tag_HTML($TB_HTML{$i}{1}; $TB_HTML{$i}{2}; $TB_HTML{$i}{3}; $TB_HTML{$i}{4}; $TB_HTML{$i}{5}; $TB_HTML{$i}{6}; $TB_HTML{$i}{7}))+"'"
	
	//$HTML:=$HTML+"'"+Minusc($TB_HTML{$i}{6};*)+"':'"+WEB_UTL_strip_ntr_json (WebAGL_Create_Tag_HTML ($TB_HTML{$i}{1};$TB_HTML{$i}{2};$TB_HTML{$i}{3};$TB_HTML{$i}{4};$TB_HTML{$i}{5};$TB_HTML{$i}{6};$TB_HTML{$i}{7}))+"'"
	//$HTML:=$HTML+"\""+Minusc($TB_HTML{$i}{6};*)+"\":\""+WEB_UTL_strip_ntr (WebAGL_Create_Tag_HTML ($TB_HTML{$i}{1};$TB_HTML{$i}{2};$TB_HTML{$i}{3};$TB_HTML{$i}{4};$TB_HTML{$i}{5};$TB_HTML{$i}{6};$TB_HTML{$i}{7}))+"\""
	If ($i<Size of array:C274($TB_HTML))
		$HTML:=$HTML+","
	End if 
End for 


If (Count parameters:C259=2)
	$0:=$HTML
Else 
	//$HTML:="({"+$HTML+"})"
	//$HTML:="({type:'refresh',valeur:{"+$HTML+"}})"
	
	If (ALERTE_MESSAGE#"")
		$ALERTE_MESSAGE:=",{type:'alerte',valeur:'"+WEB_UTL_format_js(UTL_Traduire(ALERTE_MESSAGE; "Alerte"))+"'}"
	End if 
	
	If (ALERTE_MODAL#"")
		$ALERTE_MODAL:=",{type:'modal_alerte',valeur:'"+WEB_UTL_format_js(ALERTE_MODAL)+"'}"
	End if 
	
	
	If (CONFIRM_MESSAGE#"")
		$CONFIRM_MESSAGE:=",{type:'confirme',valeur:'"+WEB_UTL_format_js(UTL_Traduire(CONFIRM_MESSAGE; "Alerte"))+"',url:'"+w_url+"'}"
	End if 
	
	If (REDIRECT#"")
		$REDIRECT:=",{type:'redirect',valeur:'"+REDIRECT+"'}"
	End if 
	
	If (REDIRECT_TAB#"")
		$REDIRECT_TAB:=",{type:'redirect_tab',valeur:'"+REDIRECT_TAB+"'}"
	End if 
	
	If (LH_SAISIE#"")
		$LH_SAISIE:=",{type:'refresh_lh',valeur:'"+WEB_UTL_format_js(LH_SAISIE)+"'}"
	End if 
	
	If (CELLS_VALEURS#"")
		$CELLS_VALEURS:=",{type:'refresh_cell',valeur:"+WEB_UTL_format_js(CELLS_VALEURS)+"}"
	End if 
	
	$HTML:="({reponse : [{type:'refresh',valeur:{"+$HTML+"}}"+$ALERTE_MESSAGE+$CONFIRM_MESSAGE+$REDIRECT+$REDIRECT_TAB+$LH_SAISIE+$ALERTE_MODAL+$CELLS_VALEURS+"]})"
	
	WEB_UTL_send_json($HTML)
End if 



