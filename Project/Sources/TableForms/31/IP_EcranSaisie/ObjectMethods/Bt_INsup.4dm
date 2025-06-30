QUERY:C277([IntervenantsGroupes:32]; [IntervenantsGroupes:32]IG_IP_RéférenceID:2=[IntervenantsProfils:31]IP_RéférenceID:1)
If (Records in selection:C76([IntervenantsGroupes:32])>0)
	READ WRITE:C146([IntervenantsGroupes:32])
	DELETE SELECTION:C66([IntervenantsGroupes:32])
	READ ONLY:C145([IntervenantsGroupes:32])
End if 