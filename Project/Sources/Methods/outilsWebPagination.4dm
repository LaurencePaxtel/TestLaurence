//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/08/22, 14:48:47
// ----------------------------------------------------
// Méthode : outilsWebPagination
// Description
// 
//
// Paramètres
// $1 = url de la page [texte]
// $2 = page actuel [entier]
// $3 = nombre d'enregistrement [entier]
// $4 = enregistrement / page [page]
// ----------------------------------------------------
var $0 : Text
var $1 : Text
var $2 : Integer
var $3 : Integer
var $4 : Integer

var $decimal : Real

var url_page_precedente; url_page_suivante; url_page_final : Text
var numero_page_precedente; numero_page_actuelle; numero_page_suivante; nb_page_total : Integer

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)

If ($2>1)  // Page précédente
	numero_page_precedente:=$2-1
Else 
	numero_page_precedente:=$2
End if 

// Page actuelle
numero_page_actuelle:=$2

// Nombre page total
$decimal:=Dec:C9($3/$4)
nb_page_total:=Int:C8($3/$4)

If ($decimal>0)
	nb_page_total:=nb_page_total+1
End if 

If (numero_page_actuelle+1<nb_page_total)  // Page suivante
	numero_page_suivante:=$2+1
Else 
	numero_page_suivante:=nb_page_total
End if 

// Création des urls de destination
url_page_precedente:=$1+String:C10(numero_page_precedente)
url_page_suivante:=$1+String:C10(numero_page_suivante)
url_page_final:=$1+String:C10(nb_page_total)

$0:=Folder:C1567(fk dossier racine web:K87:15).folder("include/pagination").file("pagination.html").getText()