//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 06:12:20
// ----------------------------------------------------
// Méthode : WebAGL_creer_menu
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_TEXT:C284($HTML_MENU; $HTML_SOUS_MENU; $LINK; $LABEL; HTML_MENU_TOP; $HTML_IMAGES; $IMAGE; $HTML_IMAGES_SOUS; $IMAGE_SOUS; $COMPOSITION; $COMPOSITION_PRINCIPAL; $JS_FUNCTION)
C_LONGINT:C283($s; $m; $i; $ligne; $col)
C_BOOLEAN:C305($SOUS_MENU_BOOL)

ARRAY TEXT:C222($MENU_TOP; 0; 4)
ARRAY TEXT:C222($SOUS_MENU_TOP; 0; 4)

ARRAY TEXT:C222(MENU_TOP; 0; 4)
ARRAY TEXT:C222(SOUS_MENU_TOP; 0; 4)

COPY ARRAY:C226($1->; $MENU_TOP)
COPY ARRAY:C226($1->; MENU_TOP)

If (Count parameters:C259>=2)
	COPY ARRAY:C226($2->; $SOUS_MENU_TOP)
	COPY ARRAY:C226($2->; SOUS_MENU_TOP)
End if 

$s:=1
$COMPOSITION_PRINCIPAL:="2"

HTML_NAV_PATH:=HTML_LAYOUT_PATH

For ($m; 1; Size of array:C274($MENU_TOP))
	$HTML_SOUS_MENU:=""
	
	$LABEL:=$MENU_TOP{$m}{1}
	$LINK:=$MENU_TOP{$m}{2}
	$IMAGE:=$MENU_TOP{$m}{3}
	$COMPOSITION:=$MENU_TOP{$m}{4}
	
	Case of 
		: ($COMPOSITION_PRINCIPAL="2")
			$class_menu:="blockminduo"
		: ($COMPOSITION_PRINCIPAL="3")
			$class_menu:="blockmincentertripple"
		Else 
			$class_menu:="blockmin"
	End case 
	
	If ($IMAGE#"")
		$HTML_IMAGES:=$HTML_IMAGES+"<div class=\""+$class_menu+"\">"
		$HTML_IMAGES:=$HTML_IMAGES+"<a href=\"/"+$LINK+"\"><span class=\"label\">"+UTL_Traduire($LABEL; "Menu")+"</span><img class=\"imgblock\" src=\""+HTML_NAV_PATH+"/images/"+$IMAGE+"\"></a>"
		$HTML_IMAGES:=$HTML_IMAGES+"</div>"
	End if 
	
	If ($LINK#"#") & (Position:C15("/"; $LINK)=0)
		$LINK:="/"+$LINK+"?action=liste&tous=non"
	End if 
	
	If (Num:C11($SOUS_MENU_TOP{$s}{3})=$m)
		$i:=$s
		$HTML_SOUS_MENU:="<ul class=\"dropdown-menu\">"
		
		For ($i; 1; Size of array:C274($SOUS_MENU_TOP))
			
			If (Num:C11($SOUS_MENU_TOP{$s}{3})=$m)
				$LABEL_SOUS:=$SOUS_MENU_TOP{$s}{1}
				$LINK_SOUS:=$SOUS_MENU_TOP{$s}{2}
				$IMAGE_SOUS:=$SOUS_MENU_TOP{$s}{4}
				
				If ($LINK_SOUS#"#") & (Position:C15("/"; $LINK_SOUS)=0)
					$LINK_SOUS:="/"+$LINK_SOUS  //+"?action=liste&tous=non"
				End if 
				
				If ($MENU_TOP{$m}{2}=w_action)
					
					Case of 
						: ($COMPOSITION="2")
							$class_menu_sous:="blockminduo"
						: ($COMPOSITION="3")
							$class_menu_sous:="blockmincentertripple"
						Else 
							$class_menu_sous:="blockmin"
					End case 
					
					$HTML_IMAGES_SOUS:=$HTML_IMAGES_SOUS+"<div class=\""+$class_menu_sous+"\">"
					$HTML_IMAGES_SOUS:=$HTML_IMAGES_SOUS+"<a href=\""+$LINK_SOUS+"\"><span class=\"label\">"+UTL_Traduire($LABEL_SOUS; "Menu")+"</span><img class=\"imgblock\" src=\""+HTML_NAV_PATH+"/images/"+$IMAGE_SOUS+"\"></a>"
					$HTML_IMAGES_SOUS:=$HTML_IMAGES_SOUS+"</div>"
				End if 
				
				$JS_FUNCTION:=""
				
				If ($LINK_SOUS="@js_@")
					$JS_FUNCTION:=Replace string:C233($LINK_SOUS; "/"; "")
					$LINK_SOUS:="#"
				End if 
				
				If ($LABEL_SOUS#"Structures")
					$HTML_SOUS_MENU:=$HTML_SOUS_MENU+"<li><a target=\"_self\" href=\""+$LINK_SOUS+"\" onClick=\""+$JS_FUNCTION+"\" ><i class=\""+$IMAGE_SOUS+"\"></i> "+UTL_Traduire($LABEL_SOUS; "Menu")+"</a></li>"
				Else 
					$HTML_SOUS_MENU:=$HTML_SOUS_MENU+HTML_LISTE_STRUCTURES
				End if 
				
				$s:=$s+1
			Else 
				$i:=Size of array:C274($SOUS_MENU_TOP)
			End if 
			
			$SOUS_MENU_BOOL:=True:C214
		End for 
		
		If (($SOUS_MENU_BOOL) & ($LINK#"#"))
			$LINK:="#"
		End if 
		
		$HTML_SOUS_MENU:=$HTML_SOUS_MENU+"</ul>"
	End if 
	
	If ($HTML_SOUS_MENU#"")
		$HTML_MENU:=$HTML_MENU+"<li class=\"dropdown\"><a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\""+$LINK+"\"><i class=\""+$IMAGE+"\"></i>"+UTL_Traduire($LABEL; "Menu")+"<b class=\"caret\"></b></a>"+$HTML_SOUS_MENU+"</li>"
	Else 
		$HTML_MENU:=$HTML_MENU+"<li><a target=\"_self\" href=\""+$LINK+"\">"+UTL_Traduire($LABEL; "Menu")+"</a></li>"
	End if 
	
End for 

HTML_MENU_TOP:=$HTML_MENU
UTL_chercher_tableau_multi(->$SOUS_MENU_TOP; ->$ligne; ->$col; w_action)

If ($ligne=0)
	UTL_chercher_tableau_multi(->$SOUS_MENU_TOP; ->$ligne; ->$col; "/"+w_action)
End if 

Case of 
	: ($COMPOSITION="2")
		$class_menu_sous:="grandblockduo"
	: ($COMPOSITION="3")
		$class_menu_sous:="grandblockcentertripple"
	Else 
		$class_menu_sous:="grandblock"
End case 

Case of 
	: ($COMPOSITION_PRINCIPAL="2")
		$class_menu:="grandblockduo"
	: ($COMPOSITION_PRINCIPAL="3")
		$class_menu:="grandblockcentertripple"
	Else 
		$class_menu:="grandblock"
End case 

$HTML_IMAGES_SOUS:="<div id=\""+$class_menu_sous+"\">"+$HTML_IMAGES_SOUS+"</div>"
$HTML_IMAGES:="<div id=\""+$class_menu+"\">"+$HTML_IMAGES+"</div>"

HTML_NAV_MENU_IMAGES:=$HTML_IMAGES
HTML_NAV_SOUS_MENU_IMAGES:=$HTML_IMAGES_SOUS