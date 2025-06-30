//%attributes = {}
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

If ($3=1)
	Case of 
		: (Form event code:C388=Sur gain focus:K2:7)
			If ($1->=!00-00-00!)
				$1->:=Current date:C33
				OBJECT SET VISIBLE:C603($2->; True:C214)
			End if 
			
		: (Form event code:C388=Sur données modifiées:K2:15)
			If ($1->=!00-00-00!)
				$2->:=!00-00-00!
				OBJECT SET VISIBLE:C603($2->; False:C215)
			End if 
			If ($1->>!00-00-00!)
				OBJECT SET VISIBLE:C603($2->; True:C214)
				If ($1->>$2->)
					If ($2->>!00-00-00!)
						$2->:=!00-00-00!
						BEEP:C151
					End if 
				Else 
				End if 
			End if 
	End case 
Else 
	If (Form event code:C388=Sur données modifiées:K2:15)
		If ($2->>!00-00-00!)
			If ($2->>=$1->)
			Else 
				BEEP:C151
				$2->:=!00-00-00!
			End if 
		End if 
	End if 
End if 