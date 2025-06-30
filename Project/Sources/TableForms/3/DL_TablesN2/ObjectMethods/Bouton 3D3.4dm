

If (Size of array:C274(t_TabNiv1)>0)
	If (t_TabNiv1>0)
		vPtrT2_Var1->:=t_TabNiv1{t_TabNiv1}
		If (t_TabNiv2>0)
			vPtrT2_Var2->:=t_TabNiv2{t_TabNiv2}
		Else 
			vPtrT2_Var2->:=""
		End if 
	End if 
End if 