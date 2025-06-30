$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
		
		t_TabNiv1:=0
		
		If (va_OldEtCiv>"")
			If (Size of array:C274(t_TabNiv1)>0)
				$Pos:=Find in array:C230(t_TabNiv1; va_OldEtCiv)
				If ($Pos>0)
					t_TabNiv1:=$Pos
					t_TabNiv1{0}:=t_TabNiv1{$Pos}
				End if 
			End if 
		Else 
			If (va_IDT_Typ1>"")
				If (Size of array:C274(t_TabNiv1)>0)
					$Pos:=Find in array:C230(t_TabNiv1; va_IDT_Typ1)
					If ($Pos>0)
						t_TabNiv1:=$Pos
						t_TabNiv1{0}:=t_TabNiv1{$Pos}
					End if 
				End if 
			End if 
		End if 
		
		
		If (Size of array:C274(t_TabNiv1)>0)
			If (t_TabNiv1>0)
				OBJECT SET ENABLED:C1123(b_ValTab1; True:C214)
			End if 
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		If (Size of array:C274(t_TabNiv1)>0)
			If (t_TabNiv1>0)
				t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
				ACCEPT:C269
			End if 
		End if 
End case 



