//Script b_AnnHB
If (Records in table:C83([TablesDemande:17])>0)
	CONFIRM:C162("Il y a "+String:C10(Records in table:C83([TablesDemande:17]))+" Compteurs de prestations."+Char:C90(13)+"Confirmez-vous la suppression ?")
	If (OK=1)
		i_Message("Suppression en cours …")
		READ WRITE:C146([TablesDemande:17])
		ALL RECORDS:C47([TablesDemande:17])
		DELETE SELECTION:C66([TablesDemande:17])
		READ ONLY:C145([TablesDemande:17])
		CLOSE WINDOW:C154
	End if 
End if 