//Script b_VoirST

If ([HeBerge:4]HB_ReferenceID:1>0)
	Process_Go2(-><>PR_HBSP; "Go_HébergementSPPLUS"; "ST"; 32; [HeBerge:4]HB_ReferenceID:1; "P")
Else 
	StrAlerte(2; "")
End if 