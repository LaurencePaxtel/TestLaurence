If (<>ta_FMGrpX>0)
	If (((Current time:C178-vh_xClic1)<?00:00:02?) & (<>ta_FMGrpX=vl_xOld))
		If (<>te_FMGrpCK{<>ta_FMGrpX}=1)
			<>te_FMGrpCK{<>ta_FMGrpX}:=0
		Else 
			<>te_FMGrpCK{<>ta_FMGrpX}:=1
		End if 
		// tl_CTSél:=0
	End if 
	vh_xClic1:=Current time:C178
	vl_xOld:=<>ta_FMGrpX
Else 
	vh_xClic1:=Current time:C178
End if 