If (Records in table:C83([GrouPe:36])>0)
	CONFIRM:C162("Il y a "+String:C10(Records in table:C83([GrouPe:36]))+" Groupes."+Char:C90(13)+"Confirmez-vous la suppression ?")
	If (OK=1)
		i_Message("Suppression en cours …")
		
		
		READ WRITE:C146([GrouPe:36])
		READ WRITE:C146([GroupeHeberges:37])
		
		ALL RECORDS:C47([GroupeHeberges:37])
		DELETE SELECTION:C66([GroupeHeberges:37])
		
		ALL RECORDS:C47([GrouPe:36])
		DELETE SELECTION:C66([GrouPe:36])
		
		READ WRITE:C146([GrouPe:36])
		READ WRITE:C146([GroupeHeberges:37])
		
		
		CLOSE WINDOW:C154
	End if 
End if 