Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(statut_at; 0)
		outilsAddToArray(->statut_at; "Tous"; "Soldée"; "Non soldée")
		
		statut_at{0}:="Sélectionner une statut de facture"
	: (Form event code:C388=Sur données modifiées:K2:15)
		POST OUTSIDE CALL:C329(Current process:C322)
End case 