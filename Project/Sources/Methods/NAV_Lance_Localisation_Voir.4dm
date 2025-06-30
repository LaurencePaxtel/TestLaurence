//%attributes = {}
If (Accès_Groupe(<>Groupe_Recherche))
	
	// Modifié par : Scanu Rémy (05/08/2022)
	If (<>PR_HébergementC=0)
		<>PR_HébergementC:=New process:C317("Go_HébergementC"; 0; "HébergéClé"; True:C214; "JN"; "")
	Else 
		Process_Show(<>PR_HébergementC)
	End if 
	
End if 