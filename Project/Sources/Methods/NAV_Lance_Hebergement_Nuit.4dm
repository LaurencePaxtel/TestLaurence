//%attributes = {}
If (Accès_Groupe(<>Groupe_Nuit))
	
	If (<>PR_Hébergement=0)
		<>PR_Hébergement:=New process:C317("Go_Hébergement"; 0; "FicheSignal"; "N"; "")  //updt
	Else 
		Process_Show(<>PR_Hébergement)
	End if 
	
End if 