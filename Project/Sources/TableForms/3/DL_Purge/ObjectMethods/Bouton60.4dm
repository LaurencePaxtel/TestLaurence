//Script 
CONFIRM:C162("Mettre à jour le fichier des ressources (RSR)"+Char:C90(13)+"Confirmez-vous  ?")
If (OK=1)
	i_Message("Mettre à jour le fichier des ressources (RSR)…")
	P_InfoDansDepart("Chargement"; 0; ""; "")
	CLOSE WINDOW:C154
End if 