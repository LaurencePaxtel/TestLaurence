//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 29/05/20, 22:48:44
// ----------------------------------------------------
// Méthode : outilsWebHTTPRequestClass
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Variant  // Réponse du serveur distant
var $1 : Text  // Type de requête demandé
var $2 : Text  // Url demandée
var $3 : Variant  // Body de la requête peut varié d'une requête à l'autre
var $4 : Pointer  // Pointeur de la réponse attendue de l'url $2
var $5 : Collection  // Collection headerNames [optionnel]
var $6 : Collection  // Collection headerValues [optionnel]

var $headerName_t : Text
var $index_el : Integer
var $blobVide_b : Blob
var $header_o : Object
var $reponse_v : Variant

var $request_hr : 4D:C1709.HTTPRequest
var $httpRequestOption_cs : cs:C1710.HTTPRequestOption

Case of 
	: (Value type:C1509($4->)=Est un texte:K8:3)
		$reponse_v:=""
	: (Value type:C1509($4->)=Est un objet:K8:27)
		$reponse_v:=New object:C1471
	: (Value type:C1509($4->)=Est un BLOB:K8:12)
		$reponse_v:=$blobVide_b
End case 

$header_o:=New object:C1471

If (Count parameters:C259>4)
	
	For each ($headerName_t; $5)
		$index_el:=$5.indexOf($headerName_t)
		$header_o[$headerName_t]:=$6[$index_el]
	End for each 
	
End if 

$httpRequestOption_cs:=cs:C1710.HTTPRequestOption.new($1; $header_o; $3)

ON ERR CALL:C155("Web_Detect_Error")
$request_hr:=4D:C1709.HTTPRequest.new($2; $httpRequestOption_cs)
$request_hr.wait()
ON ERR CALL:C155("")

Case of 
	: (Value type:C1509($4->)=Est un texte:K8:3)
		$reponse_v:=""
	: (Value type:C1509($4->)=Est un objet:K8:27)
		$reponse_v:=New object:C1471("erreur"; $etat_el)
	: (Value type:C1509($4->)=Est un BLOB:K8:12)
		$reponse_v:=$blobVide_b
End case 

$4->:=$reponse_v