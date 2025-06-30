//Script 
CONFIRM:C162("Mettre à jour la fenêtre d'aide"+Char:C90(13)+"Confirmez-vous  ?")
If (OK=1)
	i_Message("Mettre à jour la fenêtre d'aide…")
	P_InfoDansDepart("Affectation"; 0; ""; "")
	CLOSE WINDOW:C154
End if 