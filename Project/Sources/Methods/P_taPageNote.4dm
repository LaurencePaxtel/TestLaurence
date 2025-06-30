//%attributes = {}
C_LONGINT:C283($1)

If ($1=ta_PageNote)
Else 
	ta_PageNote:=$1
	FORM GOTO PAGE:C247(ta_PageNote)
End if 