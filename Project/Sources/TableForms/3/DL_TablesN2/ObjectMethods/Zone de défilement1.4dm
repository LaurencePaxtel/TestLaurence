
$vl_EventScript1:=Form event code:C388
Case of 
	: ($vl_EventScript1=Sur clic:K2:4)
		$TTNiveau:=""
		Tab_PopIn2Rec
	: ($vl_EventScript1=Sur double clic:K2:5)
		If (Size of array:C274(t_TabNiv1)>0)
			If (t_TabNiv1>0)
				If (Size of array:C274(t_TabNiv2)>0)
					
				Else 
					vPtrT2_Var1->:=t_TabNiv1{t_TabNiv1}
					vPtrT2_Var2->:=""
					ACCEPT:C269
				End if 
			End if 
		End if 
End case 