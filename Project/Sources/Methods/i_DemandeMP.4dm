//%attributes = {}
//Fonction : Uut_Confirmer

C_TEXT:C284($1)
C_BOOLEAN:C305($0)
$0:=False:C215


CONFIRM:C162($1)
If (OK=1)
	$0:=True:C214
End if 