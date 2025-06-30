//Formule format : D_TablesN1
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (vPtrT2_Var1->>"")
			If (Size of array:C274(t_TabNiv80)>0)
				$Pos:=Find in array:C230(t_TabNiv80; vPtrT2_Var1->)
				If ($Pos>0)
					t_TabNiv80:=$Pos
					t_TabNiv80{0}:=t_TabNiv80{$Pos}
				End if 
			End if 
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		If (Size of array:C274(t_TabNiv80)>0)
			If (t_TabNiv80>0)
				t_TabNiv80{0}:=t_TabNiv80{t_TabNiv80}
				vb_Valider2:=True:C214
				ACCEPT:C269
			End if 
		End if 
End case 

