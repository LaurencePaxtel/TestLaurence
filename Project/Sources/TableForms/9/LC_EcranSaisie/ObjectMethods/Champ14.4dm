If (Modified:C32([LesCentres:9]LC_AS_Nom:35)) & ([LesCentres:9]LC_AS_Nom:35#"")
	[LesCentres:9]LC_AS_Nom:35:=[LesCentres:9]LC_AS_Nom:35+"@"
	RELATE ONE:C42([LesCentres:9]LC_AS_Nom:35; [Assocs:14]AS_CP:7)
	If ([Assocs:14]AS_Nom:2#"")
		[LesCentres:9]LC_AS_Nom:35:=[Assocs:14]AS_Nom:2
		[LesCentres:9]LC_AS_ID:34:=[Assocs:14]AS_ReferenceID:1
	Else 
		[LesCentres:9]LC_AS_Nom:35:=""
		[LesCentres:9]LC_AS_ID:34:=0
		REJECT:C38([LesCentres:9]LC_AS_Nom:35)
	End if 
End if 