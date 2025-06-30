
$vl_EventScript2:=Form event code:C388
Case of 
	: ($vl_EventScript2=Sur clic:K2:4)
		
	: ($vl_EventScript2=Sur double clic:K2:5)
		If (Size of array:C274(t_TabNiv2)>0)
			If (t_TabNiv2>0)
				vPtrT2_Var1->:=t_TabNiv1{t_TabNiv1}
				vPtrT2_Var2->:=t_TabNiv2{t_TabNiv2}
				ACCEPT:C269
			Else 
				vPtrT2_Var2->:=""
			End if 
		End if 
End case 