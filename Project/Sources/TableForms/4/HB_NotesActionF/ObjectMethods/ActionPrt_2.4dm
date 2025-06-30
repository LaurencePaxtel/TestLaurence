If (Form event code:C388=Sur clic:K2:4)
	CONFIRM:C162("Voulez-vous enregistrer les modifications ?"; "Oui"; "Non")
	
	If (OK=1)
		// Modifié par : Scanu Rémy (09/11/2022)
		vt_TempActi:=""
		
		Quit_HBAction(True:C214)
		SAVE RECORD:C53([HeBerge:4])
	End if 
	
	P_PrintActionF(1)
End if 