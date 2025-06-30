//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 03/08/21, 12:00:29
// ----------------------------------------------------
// Méthode : outilsGetDocumentNameInPath
// Description
// 
//
// Paramètres
// $1 : Chemin du fichier
// $2 : Séparateur (/ ou :)
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($caractere_t)
C_LONGINT:C283($compteur_el)

$compteur_el:=1

While ($caractere_t#$2)
	
	If (Substring:C12($1; Length:C16($1)-$compteur_el; 1)=$2)
		$caractere_t:=$2
	Else 
		$compteur_el:=$compteur_el+1
	End if 
	
End while 

If ($caractere_t#"")
	$0:=Substring:C12($1; Length:C16($1)-$compteur_el+1; $compteur_el)
Else 
	$0:=$1
End if 