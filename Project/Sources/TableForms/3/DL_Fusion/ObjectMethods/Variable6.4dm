//Script b_VoirNotes
If ([HeBerge:4]HB_ReferenceID:1>0)
	Process_Go2(-><>PR_HBNotesP; "Go_HébergementNotes"; "Notes"; 32; [HeBerge:4]HB_ReferenceID:1; "P")
Else 
	StrAlerte(22; "")
End if 