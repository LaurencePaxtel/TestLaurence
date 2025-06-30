If (Form event code:C388=Sur clic:K2:4)
	
	// Modifié par : Scanu Rémy (05/08/2022)
	If (<>PR_HébergementC=0)
		<>PR_HébergementC:=New process:C317("Go_HébergementC"; 0; "HébergéClé"; True:C214; "JN"; "")
	Else 
		Process_Show(<>PR_HébergementC)
	End if 
	
	If ([SIAO:50]Si_Demandeur_ID:21>0)
		<>va_Appel_HGc:="AppelSIAO"
		<>vl_Appel_HGcRefHB:=[SIAO:50]Si_Demandeur_ID:21
		
		POST OUTSIDE CALL:C329(<>PR_HébergementC)
	End if 
	
End if 