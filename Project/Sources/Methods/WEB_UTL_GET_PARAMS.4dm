//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 01:43:23
// ----------------------------------------------------
// Méthode : WEB_UTL_GET_PARAMS
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($valeurs; $param; $sep)
C_LONGINT:C283($position_param)

$valeurs:="__erreur__"
$param:=$1

If (Not:C34(Undefined:C82($param)))
	
	If (FIX_PARAM_SEP#"")
		$sep:=FIX_PARAM_SEP
	Else 
		$sep:=" "
	End if 
	
	Repeat 
		$position_param:=$position_param+1
		$position_param:=Find in array:C230(w_variables; $param; $position_param)
		
		If ($position_param>0)
			
			If (w_valeurs{$position_param}#"")
				$valeurs:=$valeurs+$sep+w_valeurs{$position_param}
			End if 
			
		End if 
		
	Until ($position_param<0)
	
	$valeurs:=Replace string:C233($valeurs; "__erreur__"+$sep; "")
	FIX_PARAM_SEP:=" "
	
	If ($valeurs="@__erreur__@")
		$valeurs:=""
	End if 
	
Else 
	$valeurs:="Indefinie"
End if 

$0:=$valeurs