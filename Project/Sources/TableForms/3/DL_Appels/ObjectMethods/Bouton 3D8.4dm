

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	If (User in group:C338(Current user:C182; <>Groupe_MemoFusion))
		Process_Go(-><>PR_FusionMem; "Go_MemoFusion"; "MemoFusion"; 32)
	Else 
		Process_Go(-><>PR_AppelMem; "Go_Appelmemo"; "Appel"; 32)
	End if 
Else 
	Process_Go(-><>PR_AppelMem; "Go_Appelmemo"; "Appel"; 32)
End if 