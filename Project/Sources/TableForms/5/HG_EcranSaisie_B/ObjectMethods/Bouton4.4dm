If (7=7)
	Process_Go(-><>PR_SiaoQuoi; "Go_SIAOQuoi"; "SIAOQuoi"; 32)
Else 
	If (7=8)
		POST OUTSIDE CALL:C329(<>PR_Appel)
	Else 
		Process_Go(-><>PR_Appel; "Go_Appel"; "Appel"; 64)
		
	End if 
End if 