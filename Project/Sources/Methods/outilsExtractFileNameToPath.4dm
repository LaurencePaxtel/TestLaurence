//%attributes = {}
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 24/02/21, 18:38:28
// ----------------------------------------------------
// Method: outilsExtractFileNameToPath
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_OBJECT:C1216($chemin_o)

$chemin_o:=Path to object:C1547($1; Chemin est  système:K24:25)

$0:=$chemin_o.name

If ($2=True:C214)
	$0:=$0+$chemin_o.extension
End if 