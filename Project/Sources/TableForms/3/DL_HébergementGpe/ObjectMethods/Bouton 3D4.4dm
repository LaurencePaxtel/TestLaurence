Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Current user:C182="apaxtel")
			OBJECT SET VISIBLE:C603(*; "Bouton 3D4"; True:C214)
		End if 
		
		OBJECT SET ENABLED:C1123(*; "Bouton 3D4"; (Current user:C182="apaxtel"))
	: (Form event code:C388=Sur clic:K2:4)
		GET HIGHLIGHTED RECORDS:C902([HeberGement:5]; "$hebergement_ebl")
		
		If (Records in set:C195("$hebergement_ebl")>0)
			CONFIRM:C162("Souhaitez-vous vraiment supprimer l"+Choose:C955(Records in set:C195("$hebergement_ebl")>1; "es "+String:C10(Records in set:C195("$hebergement_ebl"))+" hébergements"; "'hébergement")+" ?"; "Oui"; "Non")
			
			If (OK=1)
				USE SET:C118("$hebergement_ebl")
				
				DELETE SELECTION:C66([HeberGement:5])
				Rec_Hébergements1(->vL_Nb_HG_F)
			End if 
			
		Else 
			ALERT:C41("Veuillez sélectionner une ou plusieurs fiches hébergements !")
		End if 
		
End case 