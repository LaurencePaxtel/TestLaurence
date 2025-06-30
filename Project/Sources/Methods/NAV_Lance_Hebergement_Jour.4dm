//%attributes = {}
If (Accès_Groupe(<>Groupe_Jour))
	
	If (<>PR_Hébergement=0)
		<>PR_Hébergement:=New process:C317("Go_Hébergement"; 0; "FicheSignal"; "J"; "")  // BS 200516 64*1024
	Else 
		Process_Show(<>PR_Hébergement)
	End if 
	
End if 

