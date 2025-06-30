C_LONGINT:C283(vl_Compteur; $ii; $kk)
C_TEXT:C284(va_NoGpe; va_NoCasGpe)
If (Form event code:C388=Sur clic:K2:4)
	If (i_Confirmer("Mettre à jour le n° des groupes à 5 chiffres ."))
		MESSAGES ON:C181
		
		READ WRITE:C146([GrouPe:36])
		QUERY:C277([GrouPe:36]; [GrouPe:36]GP_Numéro:7=("J_@"))
		If (Records in selection:C76([GrouPe:36])>0)
			ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Numéro:7; >)
			FIRST RECORD:C50([GrouPe:36])
			vl_Compteur:=0
			va_NoCasGpe:="J_"
			APPLY TO SELECTION:C70([GrouPe:36]; Uut_PurgeNoGpeA1)
			$ii:=vl_Compteur
		End if 
		QUERY:C277([GrouPe:36]; [GrouPe:36]GP_Numéro:7=("N_@"))
		If (Records in selection:C76([GrouPe:36])>0)
			ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Numéro:7; >)
			FIRST RECORD:C50([GrouPe:36])
			vl_Compteur:=0
			va_NoCasGpe:="N_"
			APPLY TO SELECTION:C70([GrouPe:36]; Uut_PurgeNoGpeA1)
			$kk:=vl_Compteur
		End if 
		UNLOAD RECORD:C212([GrouPe:36])
		READ ONLY:C145([GrouPe:36])
		
		READ WRITE:C146([ReferenceUnique:2])
		QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=<>vaCPT_GpeJ)
		If (Records in selection:C76([ReferenceUnique:2])=1)
			If (i_NonVerrou(->[ReferenceUnique:2]))
				[ReferenceUnique:2]RU_Numero:3:=$ii
				SAVE RECORD:C53([ReferenceUnique:2])
				UNLOAD RECORD:C212([ReferenceUnique:2])
			End if 
		End if 
		QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=<>vaCPT_GpeN)
		If (Records in selection:C76([ReferenceUnique:2])=1)
			If (i_NonVerrou(->[ReferenceUnique:2]))
				[ReferenceUnique:2]RU_Numero:3:=$kk
				SAVE RECORD:C53([ReferenceUnique:2])
				UNLOAD RECORD:C212([ReferenceUnique:2])
			End if 
		End if 
		UNLOAD RECORD:C212([ReferenceUnique:2])
		READ ONLY:C145([ReferenceUnique:2])
		
		READ WRITE:C146([GrouPe:36])
		QUERY:C277([GrouPe:36]; [GrouPe:36]GP_Numéro:7="@<<@")
		If (Records in selection:C76([GrouPe:36])>0)
			APPLY TO SELECTION:C70([GrouPe:36]; Uut_PurgeNoGpeA2)
		End if 
		UNLOAD RECORD:C212([GrouPe:36])
		READ ONLY:C145([GrouPe:36])
		
		BEEP:C151
		ALERT:C41("Mettre à jour le n° des groupes à 5 chiffres : terminé")
		
		MESSAGES OFF:C175
	End if 
End if 