C_BOOLEAN:C305($vb_OK)



If ([SIAO:50]Si_Trans_Nombre:38>0)
	$vb_OK:=i_Confirmer("Transmettre au SIAO :"+<>va_CR+"Ce dossier a déjà été transmis le "+String:C10([SIAO:50]Si_Trans_Date:36)+"."+<>va_CR+"Voulez-vous le transmettre à nouveau ?")
Else 
	$vb_OK:=True:C214
End if 

If ($vb_OK)
	If (i_Confirmer("Transmettre au SIAO"+<>va_CR+"Cette fonction transmet les informations au SIAO et enregistre la fiche."))
		//ALERTE("Fonctionnalité à implémenter…")
		If (7=7)
			If (F_SIAO_Transmettre(0; (<>vb_CestUnMac=False:C215)))
				If (7=7)
					[SIAO:50]Si_Trans_Date:36:=Current date:C33
					[SIAO:50]Si_Trans_Heure:37:=Current time:C178
					[SIAO:50]Si_Trans_Nombre:38:=[SIAO:50]Si_Trans_Nombre:38+1
					SAVE RECORD:C53([SIAO:50])
				End if 
			End if 
		End if 
	End if 
End if 
