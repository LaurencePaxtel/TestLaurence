If (i_Confirmer("Transmettre au SIAO"+<>va_CR+"Cette fonction transmet les informations au SIAO et enregistre la fiche."))
	[SIAO:50]Si_Trans_Date:36:=Current date:C33
	[SIAO:50]Si_Trans_Heure:37:=Current time:C178
	[SIAO:50]Si_Trans_Nombre:38:=[Dossier_SIAO:49]SI_Trans_NombreTransmissions:54+1
	
	ALERT:C41("Fonctionnalité à implémenter…")
	
End if 