//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_StatistiqueNotes
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)

Case of 
	: ($1=0)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$2)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			LOAD RECORD:C52([DePart:1])
			
			If (Not:C34(Locked:C147([DePart:1])))
				[DePart:1]DP_Texte:7:=$3->
				SAVE RECORD:C53([DePart:1])
			End if 
			
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			
			[DePart:1]DP_ReferenceID:1:=$2
			[DePart:1]DP_Texte:7:=$3->
			
			Case of 
				: ($2=<>ve_StatCoordinateur)  //-2
					[DePart:1]DP_Libelle:6:="Rapport StatCoordinateur"
				: ($2=<>ve_StatCoordinateurS)  //-8
					[DePart:1]DP_Libelle:6:="Rapport StatCoordinateurS"
				: ($2=<>ve_StatDirection)  //-3
					[DePart:1]DP_Libelle:6:="Rapport StatDirection"
				: ($2=<>ve_StatEtude)  //-4
					[DePart:1]DP_Libelle:6:="Rapport StatEtude"
				: ($2=<>ve_StatSpécific)  //-5
					[DePart:1]DP_Libelle:6:="Rapport StatSpécific"
				: ($2=<>ve_StatDASS)  //-6
					[DePart:1]DP_Libelle:6:="Rapport StatDASS)"
				: ($2=<>ve_StatCentre)  //-10
					[DePart:1]DP_Libelle:6:="Rapport StatCentre"
				: ($2=<>ve_StatGroupe)  //-14  `en fait il ny a pas encore de stat groupe
					[DePart:1]DP_Libelle:6:="Rapport StatGroupe"
				: ($2=<>ve_StatEMA)  //-9
					[DePart:1]DP_Libelle:6:="Rapport StatEMA"
				: ($2=<>ve_StatFicheSociale)  //-12
					[DePart:1]DP_Libelle:6:="Rapport StatFicheSociale"
				: ($2=<>ve_StatMaraude)  //-11
					[DePart:1]DP_Libelle:6:="Rapport StatMaraude"
				: ($2=<>ve_StatCoordinateurC)  //-15
					[DePart:1]DP_Libelle:6:="Rapport StatDirectionCentre"
				: ($2=<>ve_StatDirectionC)  //-16
					[DePart:1]DP_Libelle:6:="Rapport StatDirectionCentre"
				: ($2=<>ve_StatGraphe)  //-17
					[DePart:1]DP_Libelle:6:="Rapport StatGraphe"
				: ($2=<>ve_StatCentreOccup)  //-19
					[DePart:1]DP_Libelle:6:="Rapport StatCentreOccup"
				: ($2=<>ve_StatMaraudeEt)  //-18
					[DePart:1]DP_Libelle:6:="Rapport StatMaraudeEtude"
				: ($2=<>ve_StatFicheSocialeEt)  //-7
					[DePart:1]DP_Libelle:6:="Rapport Stat Dossier social Etude"
				: ($2=<>ve_Coordination)  //-24
					[DePart:1]DP_Libelle:6:="Synchronisation"
			End case 
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ ONLY:C145([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$2)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			$3->:=[DePart:1]DP_Texte:7
		End if 
		
End case 