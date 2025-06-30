//Script b_VoirNotes
If (Size of array:C274(tl_Fu_Référence)>0)
	If (ta_FU_Clé>0)
		Process_Go2(-><>PR_HBNotesP; "Go_HébergementNotes"; "Notes"; 32; tl_Fu_Référence{ta_FU_Clé}; "P")
	Else 
		StrAlerte(22; "")
	End if 
End if 