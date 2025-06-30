If (<>te_InPermCK>0)
	If (((Current time:C178-vh_xClic1)<?00:00:02?) & (<>te_InPermCK=vl_xOld))
		If (<>te_InPermCK{<>te_InPermCK}=1)
			<>te_InPermCK{<>te_InPermCK}:=0
		Else 
			<>te_InPermCK{<>te_InPermCK}:=1
		End if 
		// tl_CTSél:=0
	End if 
	vh_xClic1:=Current time:C178
	vl_xOld:=<>te_InPermCK
Else 
	vh_xClic1:=Current time:C178
End if 