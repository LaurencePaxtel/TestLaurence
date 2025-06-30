//%attributes = {}
C_LONGINT:C283($1)

If ($1=ta_Page)
Else 
	ta_Page:=$1
	FORM GOTO PAGE:C247(ta_Page)
End if 