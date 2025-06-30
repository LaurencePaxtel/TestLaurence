//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:40:00
// ----------------------------------------------------
// Méthode : UTL_preprocess
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $t : Text
var $n : Integer

ARRAY TEXT:C222($_field; 0)

ON ERR CALL:C155("web_surErreur")
WEB GET HTTP HEADER:C697($_field; $_content)

w_cookie:=""
$n:=Find in array:C230($_field; "cookie")

If ($n#-1)
	$t:=$_content{$n}
	$n:=Position:C15("session="; $t)
	
	If ($n>0)
		$t:=Substring:C12($t; $n+8)
		$n:=Position:C15(";"; $t)
		
		If ($n>0)
			w_cookie:=Substring:C12($t; 1; $n-1)
		Else 
			w_cookie:=$t
		End if 
		
		If (Position:C15("@"; w_cookie)#0)
			w_cookie:=""  // cookie non valable si il contient un joker
		End if 
		
	End if 
	
End if 

//=========================================//
// Connexion web depuis 4D client 
//=========================================//

$n:=Find in array:C230($_field; "X-URL")

If ($n#-1)
	$t:=$_content{$n}
	$n:=Position:C15("session="; $t)
	
	If ($n>0)
		$t:=Substring:C12($t; $n+8)
		$n:=Position:C15(";"; $t)
		
		If ($n>0)
			w_cookie:=Substring:C12($t; 1; $n-1)
		Else 
			w_cookie:=$t
			UTL_cookieSet(w_cookie)
		End if 
		
		If (Position:C15("@"; w_cookie)#0)
			w_cookie:=""  // cookie non valable si il contient un joker
		End if 
		
	End if 
	
End if 
//=========================================//

$n:=Find in array:C230($_field; "X-METHOD")

If ($n#-1)
	w_post:=($_content{$n}="POST")
	w_get:=Not:C34(w_post)
End if 

WEB GET VARIABLES:C683(w_variables; w_valeurs)
var $varPost_t : Text
If (w_post)
	$contentPost_o:=JSON Parse:C1218(w_variables{1})
	For each ($varPost_t; $contentPost_o)
		
		
		APPEND TO ARRAY:C911(w_variables; $varPost_t)
		
		If (JSON Stringify:C1217($contentPost_o[$varPost_t])="{@")
			APPEND TO ARRAY:C911(w_valeurs; JSON Stringify:C1217($contentPost_o[$varPost_t]))
		Else 
			APPEND TO ARRAY:C911(w_valeurs; String:C10($contentPost_o[$varPost_t]))
		End if 
	End for each 
End if 

For ($i; 1; Size of array:C274(w_valeurs))
	w_valeurs{$i}:=Replace string:C233(w_valeurs{$i}; "<"; "&lt;")  // empêche l'injection de code
	w_valeurs{$i}:=Replace string:C233(w_valeurs{$i}; ">"; "&gt;")
End for 

w_url:=Replace string:C233(w_url; "<"; "&lt;")  // empêche XSS
w_url:=Replace string:C233(w_url; ">"; "&gt;")

// Modified by: Scanu Rémy (23/12/2020)
// Aucun sens de faire ça...
//w_action:="???"

$p:=Position:C15("?"; Substring:C12(w_url; 0))

If ($p>0)
	w_action:=Substring:C12(w_url; 0; $p-1)
	w_parametres:=Substring:C12(w_url; $p+1)
Else 
	$p:=Position:C15("/"; Substring:C12(w_url; 0))
	
	If ($p>1)
		w_action:=Substring:C12(w_url; 0; $p-1)
		w_parametres:=Substring:C12(w_url; $p+1)
	Else 
		w_action:=Substring:C12(w_url; 0)
		w_parametres:=""
	End if 
	
End if 