//%attributes = {}
//Procédure : Go_Sniff
//Dimanche 17 Décembre 1995 18:06
//GUEDJ.P

While (<>PR_Sniff#0)
	READ WRITE:C146([DePart:1])
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	LOAD RECORD:C52([DePart:1])
	While (Locked:C147([DePart:1]))
		LOAD RECORD:C52([DePart:1])
		For ($i; 1; 1000)
		End for 
	End while 
	
	If (Day of:C23(Current date:C33(*))=1) | (Month of:C24(Current date:C33(*))#Month of:C24([DePart:1]DP_DerniereMAJ:5))  //le mois change
		If ([DePart:1]DP_DerniereMAJ:5#Current date:C33(*))  //la dernière mise à jour n'a pas déjà  été effectuée
			
			[DePart:1]DP_NumHeberg:4:=0
			[DePart:1]DP_DerniereMAJ:5:=Current date:C33(*)
			SAVE RECORD:C53([DePart:1])
		End if 
	End if 
	UNLOAD RECORD:C212([DePart:1])
	READ ONLY:C145([DePart:1])
	DELAY PROCESS:C323(<>PR_Sniff; 1728000)
End while 