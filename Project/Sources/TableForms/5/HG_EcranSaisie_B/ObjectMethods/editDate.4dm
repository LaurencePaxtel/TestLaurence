var $date_t : Text
var $dateOrigine_b; $modify_b : Boolean

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$date_t:=Request:C163("Quelle est la nouvelle date de la fiche ?"; String:C10(Current date:C33); "Valider"; "Annuler")
		
		Case of 
			: (Date:C102($date_t)#!00-00-00!)
				$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date = :2"; [HeberGement:5]HG_HB_ID:19; Date:C102($date_t))
				
				Case of 
					: ($hebergement_es.length=0)  // Pas de fiche hébergement et/ou prestation à cette date là
						$modify_b:=True:C214
						$dateOrigine_b:=(Date:C102($date_t)=[HeberGement:5]HG_DateOrigine:182)
					: ([HeberGement:5]HG_Nuit:2=False:C215) & ($hebergement_es[0].ID=[HeberGement:5]ID:168) & (Date:C102($date_t)=[HeberGement:5]HG_DateOrigine:182)  // Fiche hébergement, date de modification identique à celle d'origine
						$dateOrigine_b:=True:C214
					: ([HeberGement:5]HG_Nuit:2=True:C214) & ($hebergement_es.length>=1)
						$modify_b:=True:C214
					Else 
						ALERT:C41("Cette fiche étant une fiche « Hébergement », une autre fiche hébergement existe déjà à la date du "+$date_t+", il est donc impossible de modifier la date de cette fiche")
				End case 
				
				If ($dateOrigine_b=True:C214) | ($modify_b=True:C214)
					[HeberGement:5]HG_Date:4:=Date:C102($date_t)
				End if 
				
				Case of 
					: ($dateOrigine_b=True:C214)
						ALERT:C41("La date d'origine la fiche a bien été remise en place")
					: ($modify_b=True:C214)
						ALERT:C41("La date de la fiche a bien été modifiée")
				End case 
				
			: (OK=1)
				ALERT:C41("La date saisie n'est pas au format « JJ/MM/AAAA », veuillez recommencer.")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 