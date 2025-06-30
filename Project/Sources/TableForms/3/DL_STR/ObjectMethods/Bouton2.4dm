//Masque dialogue menu général
If (<>PR_GenéralLib=0)
	<>PR_GenéralLib:=New process:C317("Go_GénéralLib"; 0; "GenLib"; 1)
Else 
	Process_Show(<>PR_GenéralLib)
End if 