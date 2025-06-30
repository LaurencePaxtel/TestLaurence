//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitPrDispo  
//{          
//{          Vendredi 5 novembre 2004 à 13:56:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}



C_LONGINT:C283($1)
C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		<>vb_ParamDisActivée:=False:C215
		<>vb_ParamDisJour:=True:C214
		<>vb_ParamDisNuit:=True:C214
		<>vb_ParamDisBt:=False:C215
		
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-34)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$ii:=Length:C16([DePart:1]DP_Texte:7)
			
			If (Length:C16([DePart:1]DP_Texte:7)>=42)
				<>vb_ParamDisActivée:=([DePart:1]DP_Texte:7[[1]]="1")
				<>vb_ParamDisJour:=([DePart:1]DP_Texte:7[[2]]="1")
				<>vb_ParamDisNuit:=([DePart:1]DP_Texte:7[[3]]="1")
				<>vb_ParamDisBt:=([DePart:1]DP_Texte:7[[4]]="1")
				DébutBtMenu(2; Substring:C12([DePart:1]DP_Texte:7; 5))
			End if 
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-34
			[DePart:1]DP_Libelle:6:="Paramètres de disponibilité"
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_ParamDisActivée))+String:C10(Num:C11(<>vb_ParamDisJour))+String:C10(Num:C11(<>vb_ParamDisNuit))+String:C10(Num:C11(<>vb_ParamDisBt))
			DébutBtMenu(3; "")
			
			SAVE RECORD:C53([DePart:1])
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-34)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_ParamDisActivée))+String:C10(Num:C11(<>vb_ParamDisJour))+String:C10(Num:C11(<>vb_ParamDisNuit))+String:C10(Num:C11(<>vb_ParamDisBt))
			DébutBtMenu(3; "")
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 