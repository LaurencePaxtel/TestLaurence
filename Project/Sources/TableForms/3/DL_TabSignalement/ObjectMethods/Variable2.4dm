If (Form event code:C388=Sur double clic:K2:5)
	If (Size of array:C274(ta_xSglt)>0)
		If (ta_xSglt>0)
			If (te_xSglt{ta_xSglt}=1)
				te_xSglt{ta_xSglt}:=0
			Else 
				te_xSglt{ta_xSglt}:=1
			End if 
		End if 
	End if 
End if 