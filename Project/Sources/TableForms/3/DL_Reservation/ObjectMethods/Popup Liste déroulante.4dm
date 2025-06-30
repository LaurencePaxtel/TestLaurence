Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(reservationProvisoire_at; 0)
		
		outilsAddToArray(->reservationProvisoire_at; "Oui"; "Non")
		
		reservationProvisoire_at:=0
		reservationProvisoire_at{0}:="Sélectionnez votre choix"
End case 