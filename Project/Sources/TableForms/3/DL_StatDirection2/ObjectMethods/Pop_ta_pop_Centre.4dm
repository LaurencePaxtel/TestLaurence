//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script : ta_pop_Centre
//{
//{          Lundi 21 juin 2004 à 12:50:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(<>ta_PopCT_Centre)>0)
	If (<>ta_PopCT_Centre>0)
		If (<>tl_PopCT_ID{<>ta_PopCT_Centre}=<>tl_PopCT_ID{0})
		Else 
			<>ta_PopCT_Centre{0}:=<>ta_PopCT_Centre{<>ta_PopCT_Centre}
			<>tl_PopCT_ID{0}:=<>tl_PopCT_ID{<>ta_PopCT_Centre}
			//afficher les résultats
			
			v_Stat_DirectionCentre(3; <>ta_PopCT_Centre)
		End if 
	End if 
End if 