If (i_Confirmer("Transmettre au SIAO"+<>va_CR+"Cette fonction transmet les informations au SIAO et enregistre la fiche."))
	[Dossier_SIAO:49]SI_Trans_DernièreDate:55:=Current date:C33
	[Dossier_SIAO:49]SI_Trans_DernièreHeure:56:=Current time:C178
	[Dossier_SIAO:49]SI_Trans_NombreTransmissions:54:=[Dossier_SIAO:49]SI_Trans_NombreTransmissions:54+1
	
	P_SIAO_Etat(2; True:C214)
End if 