var $stop_b : Boolean

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Date:C102(Form:C1466.dateDu)=!00-00-00!)
			ALERT:C41("Veuillez indiquer une date de début")
			$stop_b:=True:C214
		End if 
		
		If (Date:C102(Form:C1466.dateDu)<Current date:C33) & ($stop_b=False:C215)
			ALERT:C41("Veuillez indiquer une date de début supérieur à la date du jour")
			$stop_b:=True:C214
		End if 
		
		If (Date:C102(Form:C1466.dateAu)=!00-00-00!) & ($stop_b=False:C215)
			ALERT:C41("Veuillez indiquer une date de fin")
			$stop_b:=True:C214
		End if 
		
		If (Date:C102(Form:C1466.dateAu)<Current date:C33) & ($stop_b=False:C215)
			ALERT:C41("Veuillez indiquer une date de fin supérieur à la date du jour")
			$stop_b:=True:C214
		End if 
		
		If (Date:C102(Form:C1466.dateAu)<Date:C102(Form:C1466.dateDu)) & ($stop_b=False:C215)
			ALERT:C41("Veuillez indiquer une date de fin supérieur à la date de début")
			$stop_b:=True:C214
		End if 
		
		If (String:C10(Form:C1466.service)="") & ($stop_b=False:C215)
			ALERT:C41("Veuillez indiquer un "+Get indexed string:C510(<>vlSTR_Std; 62))
			$stop_b:=True:C214
		End if 
		
		If (String:C10(Form:C1466.centre)="") & ($stop_b=False:C215)
			ALERT:C41("Veuillez sélectionner un centre")
			$stop_b:=True:C214
		End if 
		
		If (reservationProvisoire_at{reservationProvisoire_at}="Sélectionnez votre choix") & ($stop_b=False:C215)
			ALERT:C41("Veuillez sélectionner un choix pour savoir si s'agit d'une réservation provisoire")
			$stop_b:=True:C214
		End if 
		
		If (Num:C11(Form:C1466.nbPlace)<=0) & ($stop_b=False:C215)
			ALERT:C41("Veuillez indiquer un nombre de place")
			$stop_b:=True:C214
		End if 
		
		If ($stop_b=False:C215)
			CONFIRM:C162("Voulez-vous vraiment effectuer cette réservation (cette opération est irréversible) ?"; "Oui"; "Non")
			
			If (OK=1)
				ACCEPT:C269
			End if 
			
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 