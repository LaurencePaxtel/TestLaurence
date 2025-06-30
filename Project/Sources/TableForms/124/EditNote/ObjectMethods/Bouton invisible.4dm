var $stop_b : Boolean

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		CONFIRM:C162("Voulez-vous vraiment sauvegarder vos changements (cette opération est irréversible) ?"; "Oui"; "Non")
		
		If (OK=1)
			
			If (String:C10(Form:C1466.typeNoteSelected)="")
				$stop_b:=(typeNote_at{typeNote_at}="") | (typeNote_at{typeNote_at}="Type de note")
			End if 
			
			If ($stop_b=False:C215)
				$stop_b:=(String:C10(Form:C1466.note)="")
				
				If ($stop_b=False:C215)
					ACCEPT:C269
				Else 
					ALERT:C41("La note est obligatoire")
				End if 
				
			Else 
				ALERT:C41("Le type de note est obligatoire")
			End if 
			
		Else 
			CANCEL:C270
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 