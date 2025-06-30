//Script 
CONFIRM:C162("Créer dans le fichier  des data (4DD)"+Char:C90(13)+"Confirmez-vous  ?")
If (OK=1)
	i_Message("Créer dans le fichier  des data (4DD)…")
	P_InfoDansDepart("Création"; 0; ""; "")
	CLOSE WINDOW:C154
End if 