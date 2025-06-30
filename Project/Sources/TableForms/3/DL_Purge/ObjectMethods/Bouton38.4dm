//Script 

CONFIRM:C162("Purger les GIP."+Char:C90(13)+"Confirmez-vous la suppression ?")
If (OK=1)
	i_Message("GIP : suppression en cours")
	READ WRITE:C146([GIP:13])
	READ WRITE:C146([Assocs:14])
	
	ALL RECORDS:C47([GIP:13])
	DELETE SELECTION:C66([GIP:13])
	Uut_NumeroteRAZ(->[GIP:13])
	
	ALL RECORDS:C47([Assocs:14])
	MultiSoc_Filter(->[Assocs:14])
	DELETE SELECTION:C66([Assocs:14])
	Uut_NumeroteRAZ(->[Assocs:14])
	
	READ ONLY:C145([GIP:13])
	READ ONLY:C145([Assocs:14])
	
	CLOSE WINDOW:C154
End if 