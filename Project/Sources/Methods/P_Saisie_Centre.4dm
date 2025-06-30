//%attributes = {}
C_LONGINT:C283($1)
C_POINTER:C301($2)

If (Is nil pointer:C315($2)=False:C215)
	
	If ($2->=False:C215)
		$2->:=True:C214
		ALERT:C41("Vous ne pouvez pas modifier le critère !")
	End if 
	
End if 