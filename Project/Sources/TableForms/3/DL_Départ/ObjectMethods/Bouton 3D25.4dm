
If (Accès_Groupe(<>Groupe_Prolongation))
	If (<>vb_ProLg_Prolongation)
		Process_Go(-><>PR_Prolongation; "Go_HébergementProlongation"; "Prolongation"; 32)
	Else 
		ALERT:C41("Prolongation : Accès non paramétré !!!")
	End if 
End if 