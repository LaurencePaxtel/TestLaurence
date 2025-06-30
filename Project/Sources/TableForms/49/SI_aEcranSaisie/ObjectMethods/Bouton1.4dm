If ([Dossier_SIAO:49]SI_Annulation:57)
	If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
		If (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (i_Confirmer("Annuler l'annulation de la demande"+<>va_CR+"Confirmez-vous."))
				[Dossier_SIAO:49]SI_Annulation:57:=False:C215
				[Dossier_SIAO:49]SI_AnnulationDate:58:=!00-00-00!
				[Dossier_SIAO:49]SI_AnnulationHeure:59:=?00:00:00?
				[Dossier_SIAO:49]SI_AnnulationPar:60:=""
				
				[Dossier_SIAO:49]SI_EtatDemandeLibellé:62:=""
				[Dossier_SIAO:49]SI_EtatDemandeDate:63:=!00-00-00!
				P_SIAO_Etat(1; [Dossier_SIAO:49]SI_Annulation:57)
			End if 
		Else 
			ALERT:C41("Cette demande a été annulée le "+String:C10([Dossier_SIAO:49]SI_AnnulationDate:58; Interne date court:K1:7))
		End if 
	Else 
		ALERT:C41("Cette demande a été annulée le "+String:C10([Dossier_SIAO:49]SI_AnnulationDate:58; Interne date court:K1:7))
	End if 
Else 
	If (i_Confirmer("Annuler la demande"+<>va_CR+"Cette fonction fige la fiche et la rend non saisissable."))
		[Dossier_SIAO:49]SI_Annulation:57:=True:C214
		[Dossier_SIAO:49]SI_AnnulationDate:58:=Current date:C33
		[Dossier_SIAO:49]SI_AnnulationHeure:59:=Current time:C178
		[Dossier_SIAO:49]SI_AnnulationPar:60:=Current user:C182
		
		[Dossier_SIAO:49]SI_EtatDemandeLibellé:62:="Anulée"
		[Dossier_SIAO:49]SI_EtatDemandeDate:63:=[Dossier_SIAO:49]SI_AnnulationDate:58
		P_SIAO_Etat(1; [Dossier_SIAO:49]SI_Annulation:57)
	End if 
End if 