//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 29/07/21, 16:16:50
// ----------------------------------------------------
// Méthode : outilsGetDateWithPeriod
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_DATE:C307($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_TEXT:C284($stringToTransform_t)

$stringToTransform_t:="01/"+Substring:C12($1; 0; Position:C15("-"; $1)-1)+"/"+Substring:C12($1; Position:C15("-"; $1)+1)

If ($2=True:C214)
	$0:=Date:C102($stringToTransform_t)
Else 
	$0:=outilsDernierDuMois(Date:C102($stringToTransform_t))
End if 