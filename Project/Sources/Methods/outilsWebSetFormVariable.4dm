//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/10/23, 14:59:46
// ----------------------------------------------------
// Méthode : outilsWebSetFormVariable
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text  // $0 = text containing boundary
var $1 : Pointer  // $1 = pointer to array of keys
var $2 : Pointer  // $2 = pointer to array of values
var $3 : Pointer  // $3 = pointer to body
var ${4} : Pointer  // $4 = Pointer to document

var $uuid_t; $crlf_t; $separation_t; $contentType_t : Text
var $i_el; $offset_el; $compteur_el : Integer

$uuid_t:=Generate UUID:C1066
$crlf_t:="\r\n"

// Je fais débuter le compteur au 4° paramètres si jamais il y a des documents (pdf, png, jpg, txt etc.)
$compteur_el:=4

$separation_t:="--"+$uuid_t  // chaine de séparation entre chaque champ

If (Size of array:C274($1->)=(Size of array:C274($2->)))  // Les tableaux correspondent
/*
Correspond à :
UUID
	
--UUID
	
*/
	TEXT TO BLOB:C554($uuid_t+$crlf_t+$crlf_t+$separation_t+$crlf_t; $3->; UTF8 texte sans longueur:K22:17; *)
	
	For ($i_el; 1; Size of array:C274($1->))  // build body of post
		
		If ($2->{$i_el}="{{RAW_JFIF_DATA}}")  // picture data requires special handling
/*
Correspond à :
Content-Disposition: form-data; name="myFile"; filename="foo.txt" 
Content-Type: text/plain 
			
(content of the uploaded file foo.txt)
--UUID
*/
			
			Case of 
				: ($1->{$i_el}="@.pdf@")
					$contentType_t:="application/pdf"
				: ($1->{$i_el}="@.png@")
					$contentType_t:="image/png"
				: ($1->{$i_el}="@.jpg@") | ($1->{$i_el}="@.jpeg@")
					$contentType_t:="image/jpeg"
				: ($1->{$i_el}="@.json@")
					$contentType_t:="application/json"
				: ($1->{$i_el}="@.csv@")
					$contentType_t:="text/csv"
			End case 
			
			// picture data requires special handling
			TEXT TO BLOB:C554("Content-Disposition: form-data; name=\""+$1->{$i_el}+$crlf_t+"Content-Type: "+$contentType_t+$crlf_t+$crlf_t; $3->; UTF8 texte sans longueur:K22:17; *)
			
			$offset_el:=BLOB size:C605($3->)  // get offset for where document will be placed
			
			COPY BLOB:C558(${$compteur_el}->; $3->; 0; $offset_el; BLOB size:C605(${$compteur_el}->))  // copy the document into the blob
			TEXT TO BLOB:C554($crlf_t+$separation_t; $3->; UTF8 texte sans longueur:K22:17; *)
			
			If (Count parameters:C259>4)  // Il y a plusieurs documents à intégrer
				$compteur_el:=$compteur_el+1
			End if 
			
		Else   // not picture or document data so do regular handling
/*
Correspond à :
Content-Disposition: form-data; name="description" 
			
some text
--UUID
*/
			TEXT TO BLOB:C554("Content-Disposition: form-data; name=\""+$1->{$i_el}+"\""+$crlf_t+$crlf_t+$2->{$i_el}+$crlf_t+$separation_t; $3->; UTF8 texte sans longueur:K22:17; *)
		End if 
		
		If ($i_el<Size of array:C274($1->))
			TEXT TO BLOB:C554($crlf_t; $3->; UTF8 texte sans longueur:K22:17; *)
		End if 
		
	End for 
	
	TEXT TO BLOB:C554("--"+$crlf_t; $3->; UTF8 texte sans longueur:K22:17; *)
	
	$0:=$uuid_t
Else   // arrays do not match
	$0:="Error: Mismatched Arrays"
End if 