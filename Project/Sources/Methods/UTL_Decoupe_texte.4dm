//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:38:23
// ----------------------------------------------------
// Method: UTL_Decoupe_texte
// Description
// Découpe la chaine $1 dans le tableau $2 en fonction du séparateur $3
//
// Paramètres
// $1 pointeur sur un texte
// $2 pointeur sur un tableau texte
// $3 la chaine de séparation
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_TEXT:C284($chaine; $a_inserer; $complement)
C_LONGINT:C283($pos; $longueur_sep)

$sep:=$3
$longueur_sep:=Length:C16($sep)
$ptr_tableau:=$2
$chaine:=$1->

If (Position:C15($sep; $chaine)#0)
	$avant:=1
	$pos:=Position:C15($sep; $chaine)
	
	While ($pos#0)
		$a_insérer:=Substring:C12($chaine; $avant; $pos-$avant)+$complement
		
		If ((Length:C16($chaine)>0) & ($chaine#" ") & ($chaine#$sep))
			APPEND TO ARRAY:C911($ptr_tableau->; $a_inserer)
		End if 
		
		$avant:=$pos+$longueur_sep
		$pos:=Position:C15($sep; $chaine; $avant)
	End while 
	
	If ($avant<=(Length:C16($chaine)+1))
		$chaine2:=Substring:C12($chaine; $avant)+$complement
		
		If ((Length:C16($chaine2)>0) & ($chaine2#" ") & ($chaine2#$sep))
			APPEND TO ARRAY:C911($ptr_tableau->; $chaine2)
		End if 
		
	End if 
	
Else 
	
	If ((Length:C16($chaine)>0) & ($chaine#" ") & ($chaine#$sep))
		APPEND TO ARRAY:C911($ptr_tableau->; $chaine+$complement)
	End if 
	
End if 