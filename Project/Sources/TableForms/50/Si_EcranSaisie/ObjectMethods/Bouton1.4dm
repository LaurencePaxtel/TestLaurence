If ([SIAO:50]Si_DemandeAnnulee:29)
	If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
		If (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (i_Confirmer("Annuler l'annulation de la demande"+<>va_CR+"Confirmez-vous."))
				[SIAO:50]Si_DemandeAnnulee:29:=False:C215
				[SIAO:50]Si_DemandeAnnulee_Date:30:=!00-00-00!
				[SIAO:50]Si_DemandeAnnulee_Heure:31:=?00:00:00?
				[SIAO:50]Si_DemandeAnnulee_Par:32:=""
				
				[SIAO:50]Si_Etat_Type:41:=""
				[SIAO:50]Si_Etat_Date:42:=!00-00-00!
				OBJECT SET ENABLED:C1123(b_TransSIAO; True:C214)
				// P_SIAO_Etat (1;[Dossier_SIAO]SI_Annulation)
				
			End if 
		Else 
			ALERT:C41("Cette demande a été annulée le "+String:C10([SIAO:50]Si_DemandeAnnulee_Date:30; Interne date court:K1:7))
		End if 
	Else 
		ALERT:C41("Cette demande a été annulée le "+String:C10([SIAO:50]Si_DemandeAnnulee_Date:30; Interne date court:K1:7))
	End if 
Else 
	If (i_Confirmer("Annuler la demande"+<>va_CR+"Cette fonction fige la fiche et la rend non saisissable."))
		[SIAO:50]Si_DemandeAnnulee:29:=True:C214
		[SIAO:50]Si_DemandeAnnulee_Date:30:=Current date:C33
		[SIAO:50]Si_DemandeAnnulee_Heure:31:=Current time:C178
		[SIAO:50]Si_DemandeAnnulee_Par:32:=Current user:C182
		
		[SIAO:50]Si_Etat_Type:41:="Annulée (A)"
		[SIAO:50]Si_Etat_Date:42:=[SIAO:50]Si_DemandeAnnulee_Date:30
		OBJECT SET ENABLED:C1123(b_TransSIAO; False:C215)
		// P_SIAO_Etat (1;[Dossier_SIAO]SI_Annulation)
	End if 
End if 