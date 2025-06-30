If (Size of array:C274(<>ta_FamilleClé)>0)
	BEEP:C151
	If (i_Confirmer("Remise à zéro de la réservation multiple ?"))
		
		ARRAY LONGINT:C221(<>tl_FamilleID; 0)
		ARRAY TEXT:C222(<>ta_FamilleClé; 0)
		ARRAY TEXT:C222(<>ta_FamilleEtCv; 0)
		<>tl_FamilleID:=0
		<>ta_FamilleClé:=0
		<>ta_FamilleEtCv:=0
	End if 
End if 