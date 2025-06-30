//Formule format : D_TablesN2
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (vPtrT2_Var1->>"")
			If (Size of array:C274(t_TabNiv1)>0)
				$Pos:=Find in array:C230(t_TabNiv1; vPtrT2_Var1->)
				If ($Pos>0)
					t_TabNiv1:=$Pos
					t_TabNiv1{0}:=t_TabNiv1{$Pos}
					
					
					
					Tab_PopIn2Rec
					SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; t_TabNiv2)
					If (Size of array:C274(t_TabNiv2)>0)
						
						$Pos:=Find in array:C230(t_TabNiv2; vPtrT2_Var2->)
						If ($Pos>0)
							t_TabNiv2:=$Pos
							t_TabNiv2{0}:=t_TabNiv2{t_TabNiv2}
						End if 
					End if 
				End if 
			End if 
		End if 
		
End case 


