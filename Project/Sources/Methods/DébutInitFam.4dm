//%attributes = {}
C_LONGINT:C283($1)


Case of 
	: ($1=0)
		Use (Storage:C1525)
			Storage:C1525.dispositif:=New shared object:C1526
		End use 
		Use (Storage:C1525.dispositif)
			Storage:C1525.dispositif.HG_ASPasFamGroupe:=""
			Storage:C1525.dispositif.HG_ASFamGroupe:=""
			Storage:C1525.dispositif.HG_ASFamChéf:=3
		End use 
		
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-26)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			If ([DePart:1]DP_Texte:7>"")
				$ii:=Position:C15("&"; [DePart:1]DP_Texte:7)
				$ij:=Position:C15(";"; [DePart:1]DP_Texte:7)
				
				Use (Storage:C1525.dispositif)
					Storage:C1525.dispositif.HG_ASPasFamGroupe:=Substring:C12([DePart:1]DP_Texte:7; 1; $ii-1)
					Storage:C1525.dispositif.HG_ASFamGroupe:=Substring:C12([DePart:1]DP_Texte:7; $ii+1; $ij-$ii-1)
					Storage:C1525.dispositif.HG_ASFamChéf:=Num:C11(Substring:C12([DePart:1]DP_Texte:7; $ij+1))
				End use 
			End if 
			
			UNLOAD RECORD:C212([DePart:1])
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-26
			[DePart:1]DP_Libelle:6:="Groupe par défaut pour Asile"
			[DePart:1]DP_Texte:7:=Storage:C1525.dispositif.HG_ASPasFamGroupe+"&"+Storage:C1525.dispositif.HG_ASFamGroupe+";"+"3"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-26)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=Storage:C1525.dispositif.HG_ASPasFamGroupe+"&"+Storage:C1525.dispositif.HG_ASFamGroupe+";"+String:C10(Storage:C1525.dispositif.HG_ASFamChéf)
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 