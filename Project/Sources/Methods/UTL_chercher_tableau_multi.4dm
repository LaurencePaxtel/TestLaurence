//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 06:20:27
// ----------------------------------------------------
// Méthode : UTL_chercher_tableau_multi
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_TEXT:C284($4)
C_REAL:C285($5)

C_TEXT:C284($chercher)
C_LONGINT:C283($offset)
C_POINTER:C301($TB_VALEURS)

$chercher:=$4
$TB_VALEURS:=$1

If (Count parameters:C259=5)
	$offset:=$5
End if 

For ($i; 1; Size of array:C274($TB_VALEURS->))
	
	If ($offset#0)
		$pos:=$offset
	Else 
		$pos:=$i
	End if 
	
	$col:=Find in array:C230($TB_VALEURS->{$pos}; $chercher)
	
	If ($col#-1)
		$2->:=$pos
		$3->:=$col
		
		$i:=Size of array:C274($TB_VALEURS->)
	End if 
	
End for 
