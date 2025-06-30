//%attributes = {}
C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)
C_LONGINT:C283($2)
If ($1>0)
	va_RH_Typ1:=[LesCentres:9]LC_Nom:4
	va_RH_Typ2:=[LesCentres:9]LC_Lieu:5
	vl_RH_RéfID:=[LesCentres:9]LC_RéférenceID:1
	$0:=True:C214
	CANCEL:C270
Else 
	If ($2=1)
		StrAlerte(21; "")
	End if 
End if 