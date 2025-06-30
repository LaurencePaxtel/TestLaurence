If (<>ta_InPerm>0)
	If (((Current time:C178-vh_xClic1)<?00:00:02?) & (<>ta_InPerm=vl_xOld))
		If (<>te_InPermCK{<>ta_InPerm}=1)
			<>te_InPermCK{<>ta_InPerm}:=0
		Else 
			<>te_InPermCK{<>ta_InPerm}:=1
		End if 
		// tl_CTSél:=0
	End if 
	vh_xClic1:=Current time:C178
	vl_xOld:=<>ta_InPerm
Else 
	vh_xClic1:=Current time:C178
End if 