If (Form event code:C388=Sur double clic:K2:5)
	If (Size of array:C274(te_xSglt)>0)
		If (te_xSglt>0)
			If (te_xSglt{te_xSglt}=1)
				te_xSglt{te_xSglt}:=0
			Else 
				te_xSglt{te_xSglt}:=1
			End if 
		End if 
	End if 
End if 
