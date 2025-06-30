//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitProLg  
//{          Samedi 18 septembre 2004 à 13:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=0)
		<>vb_ProLg_Prolongation:=False:C215
		<>vb_ProLg_FinMois:=True:C214
		<>ve_ProLg_Le:=0
		<>ve_ProLg_MaxMois:=0
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-33)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Libelle:6="Prolongations : Paramètres")
			Else 
				[DePart:1]DP_Libelle:6:="Prolongations : Paramètres"
				SAVE RECORD:C53([DePart:1])
			End if 
			If (Length:C16([DePart:1]DP_Texte:7)>=3)
				<>vb_ProLg_Prolongation:=([DePart:1]DP_Texte:7[[1]]="1")
				<>vb_ProLg_FinMois:=([DePart:1]DP_Texte:7[[2]]="1")
				
				$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
				<>ve_ProLg_Le:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; 3; $ii-3))
				
				[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
				$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
				<>ve_ProLg_MaxMois:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1))
				
				<>vb_AvecProlongation:=<>vb_ProLg_Prolongation
			End if 
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-33
			[DePart:1]DP_Libelle:6:="Prolongations : Paramètres"
			
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_ProLg_Prolongation))
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(Num:C11(<>vb_ProLg_FinMois))
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>ve_ProLg_Le)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>ve_ProLg_MaxMois)+";"
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-33)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_ProLg_Prolongation))
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(Num:C11(<>vb_ProLg_FinMois))
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>ve_ProLg_Le)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>ve_ProLg_MaxMois)+";"
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 
