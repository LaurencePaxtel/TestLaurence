If (Form event code:C388=Sur clic:K2:4)
	C_BOOLEAN:C305($v_bOK)
	
	If (Modified record:C314([HeberGement:5]))
		
		If (i_Confirmer("Vous avez modifié la fiche."+<>va_CR+"Si vous voulez annuler vos modifications, cliquez sur le bouton Annuler."+<>va_CR+\
			"Si vous voulez enregistrer les modifications : "+<>va_CR+" - cliquez d'abord sur OK"+<>va_CR+" - puis sur le bouton VALIDER de la fiche !")=False:C215)
			$v_bOK:=True:C214
			CANCEL:C270
		End if 
		
	Else 
		$v_bOK:=True:C214
		CANCEL:C270
	End if 
	
	If ($v_bOK)
		// Modifié par : Scanu Rémy (28/02/2023)
		OB REMOVE:C1226(Form:C1466; "dupliquerFiche")
		
		OB REMOVE:C1226(Form:C1466; "dupliquerFicheHBID")
		OB REMOVE:C1226(Form:C1466; "dupliquerFicheHGID")
		OB REMOVE:C1226(Form:C1466; "dupliquerFicheType")
		
	End if 
	
End if 