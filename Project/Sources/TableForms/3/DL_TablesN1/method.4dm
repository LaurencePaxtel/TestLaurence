//Formule format : D_TablesN1

C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (vPtrT2_Var1->>"")
			If (Size of array:C274(t_TabNiv1)>0)
				$Pos:=Find in array:C230(t_TabNiv1; vPtrT2_Var1->)
				If ($Pos>0)
					t_TabNiv1:=$Pos
					t_TabNiv1{0}:=t_TabNiv1{$Pos}
				End if 
			End if 
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		If (Size of array:C274(t_TabNiv1)>0)
			If (t_TabNiv1>0)
				t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
				vb_Valider2:=True:C214
				ACCEPT:C269
			End if 
		End if 
End case 

