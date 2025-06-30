
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If ([LesCentres:9]LC_Designation_2:73="")
			[LesCentres:9]LC_Designation_2:73:=[LesCentres:9]LC_Nom:4
		End if 
End case 
