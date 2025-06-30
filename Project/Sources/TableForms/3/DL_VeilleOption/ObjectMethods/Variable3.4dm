If (<>te_FMGrpCK>0)
	If (((Current time:C178-vh_xClic1)<?00:00:02?) & (<>te_FMGrpCK=vl_xOld))
		If (<>te_FMGrpCK{<>te_FMGrpCK}=1)
			<>te_FMGrpCK{<>te_FMGrpCK}:=0
		Else 
			<>te_FMGrpCK{<>te_FMGrpCK}:=1
		End if 
		// tl_CTSél:=0
	End if 
	vh_xClic1:=Current time:C178
	vl_xOld:=<>te_FMGrpCK
Else 
	vh_xClic1:=Current time:C178
End if 