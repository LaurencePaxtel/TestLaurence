//Script 
CONFIRM:C162("Mise à jour du fichier Data (4DD)"+Char:C90(13)+"Confirmez-vous  ?")
If (OK=1)
	i_Message("Mise à jour du fichier Data (4DD)…")
	P_InfoDansDepart("Maj"; 0; ""; "")
	CLOSE WINDOW:C154
End if 