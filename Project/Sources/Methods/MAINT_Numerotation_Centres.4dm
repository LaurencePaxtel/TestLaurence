//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 06/10/2020, 13:03:36
// ----------------------------------------------------
// Method: MAINT_Numerotation_Centres
// Description
// 
//
// Parameters
// ----------------------------------------------------

CONFIRM:C162("Attention, il ne faut pas utiliser cette méthode de maintenance que si tous les centres de la structure n'on aucune fiche d'hébergement ni des données liées, voulez-vous continuer?"; "Oui"; "Non")

If (OK=1)
	
	CONFIRM:C162("Voulez-vous renuméroter les fiches des centres, attention il faudra choisir Non si vous avez des données liées (fiches d'hébergements, disponibilités etc...)?"; "Oui"; "Non")
	
	If (OK=1)
		
		READ WRITE:C146([LesCentres:9])
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; >)
		
		C_LONGINT:C283($compteur)
		
		$compteur:=<>vl_T_CentreCodeDebut
		
		While (Not:C34(End selection:C36([LesCentres:9])))
			[LesCentres:9]LC_RéférenceID:1:=$compteur
			$compteur:=$compteur+1
			SAVE RECORD:C53([LesCentres:9])
			NEXT RECORD:C51([LesCentres:9])
		End while 
		
	End if 
	
	
	READ ONLY:C145([LesCentres:9])
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; <)
	
	READ WRITE:C146([ReferenceUnique:2])
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(->[LesCentres:9]))
	MultiSoc_Filter(->[ReferenceUnique:2]; False:C215)
	
	If (Records in selection:C76([ReferenceUnique:2])=0)
		CREATE RECORD:C68([ReferenceUnique:2])
		MultiSoc_Init_Structure(->[ReferenceUnique:2])
		[ReferenceUnique:2]RU_Fichier:2:=Table name:C256(->[LesCentres:9])
		[ReferenceUnique:2]RU_Numero:3:=<>vl_T_CentreCodeDebut
		[ReferenceUnique:2]RU_ValeurApha:4:=""
	End if 
	
	[ReferenceUnique:2]RU_Numero:3:=[LesCentres:9]LC_RéférenceID:1
	
	SAVE RECORD:C53([ReferenceUnique:2])
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	
	
	ALERT:C41("Opération effectuée avec succès")
	
End if 