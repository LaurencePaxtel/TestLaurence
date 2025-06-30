If (Form event code:C388=Sur double clic:K2:5)
	If (Size of array:C274(t_TabNiv80)>0)
		If (t_TabNiv80>0)
			t_TabNiv80{0}:=t_TabNiv80{t_TabNiv80}
			OBJECT SET ENABLED:C1123(b_ValTab1; True:C214)
		Else 
			t_TabNiv80{0}:=""
			OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
		End if 
	Else 
		OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
	End if 
End if 