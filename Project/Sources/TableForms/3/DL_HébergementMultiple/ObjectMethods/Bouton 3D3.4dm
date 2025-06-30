If (Size of array:C274(<>ta_FamilleClé)>0)
	If (<>ta_FamilleClé>0)
		BEEP:C151
		If (i_Confirmer("Retirer de la réservation :  "+<>ta_FamilleClé{<>ta_FamilleClé}))
			
			C_LONGINT:C283($ii)
			$ii:=<>ta_FamilleClé
			DELETE FROM ARRAY:C228(<>tl_FamilleID; $ii; 1)
			DELETE FROM ARRAY:C228(<>ta_FamilleClé; $ii; 1)
			DELETE FROM ARRAY:C228(<>ta_FamilleEtCv; 1)
			If ($ii>Size of array:C274(<>ta_FamilleClé))
				$ii:=Size of array:C274(<>ta_FamilleClé)
			End if 
			<>tl_FamilleID:=$ii
			<>ta_FamilleClé:=$ii
			<>ta_FamilleEtCv:=$ii
		End if 
	Else 
		StrAlerte(3; "")
	End if 
End if 