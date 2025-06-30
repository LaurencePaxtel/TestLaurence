
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If ([LesCentres:9]LC_Designation:70="")
			[LesCentres:9]LC_Designation:70:=[LesCentres:9]LC_Nom:4
		End if 
End case 
