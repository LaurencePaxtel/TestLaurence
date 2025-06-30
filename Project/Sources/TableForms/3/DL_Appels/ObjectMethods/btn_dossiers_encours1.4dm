If (<>PR_Dossiers_Encours_Liste=0)
	Process_Go(-><>PR_Dossiers_Encours_Liste; "Go_Dossiers_Encours_Not"; "Dossiers en cours"; 64)
Else 
	Process_Show(<>PR_Dossiers_Encours_Liste)
End if 
