//%attributes = {}
// ----------------------------------------------------
// User name (OS): Scanu Rémy - remy@connect-io.fr
// Date and time: 21/12/20, 16:27:50
// ----------------------------------------------------
// Method: Web_Int_Custom_Content
// Description
// Permet de créer les dossiers par défaut pour la personnalisation de contenu
// sur le web
// Parameters
// ----------------------------------------------------
var $pathDefault_t; $pathCustom_t; $referer_t; $urlParam_t; $body_t; $propriete_t : Text
var $i_el; $position_el : Integer
var $userPreferences_o; $form_o : Object
var $param_c; $value_c : Collection

var w_visiteur : Object

ARRAY TEXT:C222($nom_at; 0)
ARRAY TEXT:C222($valeur_at; 0)

WEB GET HTTP HEADER:C697($nom_at; $valeur_at)

For ($i_el; 1; Size of array:C274($nom_at))
	OB SET:C1220(w_visiteur; $nom_at{$i_el}; $valeur_at{$i_el})
End for 

WEB GET VARIABLES:C683($nom_at; $valeur_at)

For ($i_el; 1; Size of array:C274($nom_at))
	
	If ($nom_at{$i_el}#"{@}")
		OB SET:C1220(w_visiteur; $nom_at{$i_el}; $valeur_at{$i_el})
	End if 
	
End for 

If (w_visiteur["X-URL"]="/4DACTION/@") & ((w_visiteur["X-METHOD"]="POST") | (w_visiteur["X-METHOD"]="PUT") | (w_visiteur["X-METHOD"]="DELETE"))
	WEB GET HTTP BODY:C814($body_t)
	
	If ($body_t="{@}")
		$form_o:=JSON Parse:C1218($body_t)
		w_visiteur.formRequest:=OB Copy:C1225($form_o)
		
		For each ($propriete_t; $form_o)
			OB REMOVE:C1226(w_visiteur; $propriete_t)
		End for each 
		
		w_visiteur:=outilsObjectMerge(w_visiteur; $form_o)
	End if 
	
End if 

w_visiteur["X-URLParam"]:=New collection:C1472
w_visiteur["X-URLValue"]:=New collection:C1472

w_visiteur.RefererParam:=New collection:C1472
w_visiteur.RefererValue:=New collection:C1472

$referer_t:=w_visiteur.Referer

If (Position:C15("?"; $referer_t)>0)
	$referer_t:=Substring:C12(w_visiteur.Referer; Position:C15("?"; w_visiteur.Referer)+1)
End if 

outilsWebGetParamValue($referer_t; ->$param_c; ->$value_c)

w_visiteur.RefererParam:=$param_c
w_visiteur.RefererValue:=$value_c

// On retire les parametres de l'url.
w_visiteur.url:=Lowercase:C14(w_visiteur["X-URL"])
$position_el:=Position:C15("?"; w_visiteur.url)

If ($position_el>0)
	$urlParam_t:=Substring:C12(w_visiteur.url; $position_el+1)
	outilsWebGetParamValue($urlParam_t; ->$param_c; ->$value_c)
	
	w_visiteur["X-URLParam"]:=$param_c
	w_visiteur["X-URLValue"]:=$value_c
	
	w_visiteur.url:=Substring:C12(w_visiteur.url; 1; $position_el-1)
End if 

If (Records in selection:C76([INtervenants:10])=1) & ([INtervenants:10]ID:16#0)
	$pathDefault_t:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"customContent"+Séparateur dossier:K24:12+String:C10([INtervenants:10]ID:16)+Séparateur dossier:K24:12
	
	If (Test path name:C476($pathDefault_t)#Est un dossier:K24:2)
		CREATE FOLDER:C475($pathDefault_t; *)
	End if 
	
	// Dossier perso modèle observation (facture détail)
	$pathCustom_t:=$pathDefault_t+"observation"+Séparateur dossier:K24:12+"modele"+Séparateur dossier:K24:12
	
	If (Test path name:C476($pathCustom_t)#Est un dossier:K24:2)
		CREATE FOLDER:C475($pathCustom_t; *)
	End if 
	
	// Fichier config perso
	$pathCustom_t:=$pathDefault_t+"userPreferences.json"
	
	If (Test path name:C476($pathCustom_t)#Est un document:K24:1)
		$userPreferences_o:=New object:C1471("toolbar"; New object:C1471("display"; "true"); "plateforme"; va_UserPlateforme)
		TEXT TO DOCUMENT:C1237($pathCustom_t; JSON Stringify:C1217($userPreferences_o); "UTF-8"; Document inchangé:K24:18)
	End if 
	
	w_userPreferences:=Document to text:C1236($pathCustom_t; "UTF-8"; Document inchangé:K24:18)
	w_visiteur.customPath:=$pathCustom_t
End if 