

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT Get pointer:C1124(Objet courant:K67:2)->:=New object:C1471()
		OBJECT Get pointer:C1124(Objet courant:K67:2)->values:=New collection:C1472("Etat des lieux"; "Fiche d'intervention"; "Quittance"; "Quittance V2"; \
			"Avis"; "Avis V2"; "Appel participation"; "Facture individuelle"; "Demande FSL"; "Situation comptable"; "Facture participation"; "Autre")
		
		OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
		OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du cas des « données » chargé"
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		If (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			[DOCWPRO:121]chargeData:6:=OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue
		Else 
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du cas des « données » chargé"
		End if 
		
End case 