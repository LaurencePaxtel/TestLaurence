If (rSomme=1)
	v_Stat_DirectionCentre(3; 0)
Else 
	If (Size of array:C274(<>ta_PopCT_Centre)>0)
		If (<>ta_PopCT_Centre>0)
			v_Stat_DirectionCentre(3; <>ta_PopCT_Centre)
		End if 
	End if 
End if 