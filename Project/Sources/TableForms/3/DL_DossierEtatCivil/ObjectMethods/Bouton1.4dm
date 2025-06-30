If (Size of array:C274(t_TabNiv1)>0)
	If (t_TabNiv1<0)
		t_TabNiv1:=1
	Else 
		If ((t_TabNiv1-1)>0)
			t_TabNiv1:=t_TabNiv1-1
		Else 
			t_TabNiv1:=1
		End if 
	End if 
	t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
	OBJECT SET ENABLED:C1123(b_ValTab1; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
End if 