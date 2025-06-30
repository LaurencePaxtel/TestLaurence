
If (vb_majWrong) & (vb_majOK)
	CONFIRM:C162("Confirmez la m à jour de la table")
	If (OK=1)
		READ WRITE:C146([TypesTables:11])
		
		QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=vl_RéfWrong)
		If (Records in selection:C76([TypesTables:11])=1)
			If (Num:C11(va_NewLibTa)>0)
				APPLY TO SELECTION:C70([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1:=Num:C11(va_NewLibTa))
			Else 
				APPLY TO SELECTION:C70([TypesTables:11]; [TypesTables:11]TT_Libellé:4:=va_NewLibTa)
			End if 
		End if 
		READ ONLY:C145([TypesTables:11])
		
		va_LibNo:="Action effectuée !"
		
		BEEP:C151
		BEEP:C151
	Else 
		va_LibNo:="Action annulée !"
	End if 
Else 
	ALERT:C41("Vous devez faire vos recherches !")
End if 