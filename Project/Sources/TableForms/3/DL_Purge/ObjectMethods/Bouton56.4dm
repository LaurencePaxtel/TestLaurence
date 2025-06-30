//Script 

CONFIRM:C162("Critères Centres : positionner à oui ."+Char:C90(13)+"Confirmez-vous la modification ?")
If (OK=1)
	i_Message("Critères Centres : modification en cours")
	READ WRITE:C146([LesCentres:9])
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	APPLY TO SELECTION:C70([LesCentres:9]; wUut_MàJCritCL)
	READ ONLY:C145([LesCentres:9])
	CLOSE WINDOW:C154
End if 