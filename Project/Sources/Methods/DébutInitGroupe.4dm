//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitGroupe  
//{          
//{          Lundi 8 mars 2004 à 18:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		<>vb_GpeOui:=False:C215
		<>vl_GpeMaxNbFam:=99
		<>vl_GpeMaxNbStd:=99
		
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-28)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			
			If ([DePart:1]DP_Libelle:6#"Le nombre maximum de membres par familles et groupes")
				[DePart:1]DP_Libelle:6:="Le nombre maximum de membres par familles et groupes"
				SAVE RECORD:C53([DePart:1])
			End if 
			
			If (Length:C16([DePart:1]DP_Texte:7)>0)
				$ii:=Position:C15("="; [DePart:1]DP_Texte:7)
				
				If ($ii>0)
					<>vb_GpeOui:=(Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1)="Oui")
					[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
					
					$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
					<>vl_GpeMaxNbFam:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1))
					
					[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
					<>vl_GpeMaxNbStd:=Num:C11([DePart:1]DP_Texte:7)
				Else 
					$ii:=Position:C15(";"; [DePart:1]DP_Texte:7)
					
					If ($ii>0)
						<>vl_GpeMaxNbFam:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1))
						[DePart:1]DP_Texte:7:=Substring:C12([DePart:1]DP_Texte:7; $ii+1)
						
						<>vl_GpeMaxNbStd:=Num:C11([DePart:1]DP_Texte:7)
					End if 
					
				End if 
				
			End if 
			
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			
			[DePart:1]DP_ReferenceID:1:=-28
			[DePart:1]DP_Libelle:6:="Le nombre maximum de membres par familles et groupes"
			[DePart:1]DP_Texte:7:=("Oui"*Num:C11(<>vb_GpeOui))+("Non"*Num:C11(<>vb_GpeOui=False:C215))+"="+String:C10(<>vl_GpeMaxNbFam)+";"+String:C10(<>vl_GpeMaxNbStd)
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-28)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			[DePart:1]DP_Texte:7:=("Oui"*Num:C11(<>vb_GpeOui))+("Non"*Num:C11(<>vb_GpeOui=False:C215))+"="+String:C10(<>vl_GpeMaxNbFam)+";"+String:C10(<>vl_GpeMaxNbStd)
			SAVE RECORD:C53([DePart:1])
			
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
End case 