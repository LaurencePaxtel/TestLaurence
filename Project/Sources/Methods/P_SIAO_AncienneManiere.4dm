//%attributes = {}
If ([HeBerge:4]HB_ReferenceID:1>0)
	Process_Go2(-><>PR_SIAO; "Go_HébergementSIAO"; "SIAO"; 32; [HeBerge:4]HB_ReferenceID:1; "N")
Else 
	StrAlerte(3; "")
End if 