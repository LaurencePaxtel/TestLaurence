//Script b_Acts
If ([HeBerge:4]HB_ReferenceID:1>0)
	Process_Go20(-><>PR_HBAction; "Go_HébergementAction"; "Actions"; 0; [HeBerge:4]HB_ReferenceID:1; "N"; "")
Else 
	StrAlerte(3; "")
End if 