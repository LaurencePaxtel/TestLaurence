var $dateReport_d : Date
var $societe_es : cs:C1710.SOcieteSelection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		// Modifié par : Scanu Rémy (20/10/2022)
		OBJECT SET VISIBLE:C603(*; "Bouton7"; (User in group:C338(Current user:C182; "ReportManuel")=True:C214) & ([HeberGement:5]HG_Nuit:2=False:C215))
	: (Form event code:C388=Sur clic:K2:4)
		// Modifié par : Scanu Rémy (17/10/2022)
		$societe_es:=ds:C1482.SOciete.query("Ref_Structure = :1"; <>ref_soc_active)
		
		If ($societe_es.length=1)
			
			// Modifié par : Scanu Rémy (11/07/2023)
			$dateReport_d:=[HeberGement:5]HG_RéservationDateFin:134
			
			If ($societe_es.first().SO_ReportManuelToday=True:C214)
				
				If ([HeberGement:5]HG_RéservationDateFin:134>=Current date:C33)
					$dateReport_d:=Current date:C33
				End if 
				
			End if 
			
			Case of 
				: ([HeberGement:5]HG_Date:4<$dateReport_d)
					CONFIRM:C162("Souhaitez-vous vraiment reporter la fiche jusqu'au "+String:C10($dateReport_d)+" ?"; "Oui"; "Non")
					
					If (OK=1)
						Form:C1466.reportManuel:=True:C214
						Form:C1466.reportManuelDate:=$dateReport_d
					End if 
					
				: ($societe_es.first().SO_ReportManuelToday=True:C214)
					ALERT:C41("Impossible de mettre en place le report car il n'y a qu'une seule nuit de prise en charge.")
				Else 
					ALERT:C41("Impossible de mettre en place le report car la date de la fiche est supérieure ou égale au dernier jour du séjour au centre "+[HeberGement:5]HG_CentreNom:62+".")
			End case 
			
		Else 
			ALERT:C41("La société ayant le code "+<>ref_soc_active+" n'a pas pu être trouvée dans la base de donnée.")
		End if 
		
End case 