//Script b_MàJEtF 
MESSAGES ON:C181
C_TEXT:C284($va_CléFam; va_MCléFam)

READ ONLY:C145([ReferenceUnique:2])
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=<>va_NoCléFAM)
If (Records in selection:C76([ReferenceUnique:2])=1)
	$va_CléFam:=String:C10([ReferenceUnique:2]RU_Numero:3)
	va_MCléFam:=Request:C163("Modifier la clé fam actuelle : "+$va_CléFam; "")
	If (OK=1)
		CONFIRM:C162("M à J n° clé de lien familles"+<>va_CR+"ancienne : "+$va_CléFam+<>va_CR+"par : "+va_MCléFam)
		If (OK=1)
			READ WRITE:C146([ReferenceUnique:2])
			QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=<>va_NoCléFAM)
			If (Records in selection:C76([ReferenceUnique:2])=1)
				
				LOAD RECORD:C52([ReferenceUnique:2])
				If (Not:C34(Locked:C147([ReferenceUnique:2])))
					[ReferenceUnique:2]RU_Numero:3:=Num:C11(va_MCléFam)
					SAVE RECORD:C53([ReferenceUnique:2])
				Else 
					ALERT:C41("La référence clé famille est consultée par un autre poste."+<>va_CR+"Veuillez essayer ultérieurement.")
				End if 
			End if 
			UNLOAD RECORD:C212([ReferenceUnique:2])
			READ ONLY:C145([ReferenceUnique:2])
		End if 
	End if 
	
Else 
	ALERT:C41("La référence clé lien de famille n'est pas encore créée.")
End if 