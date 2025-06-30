If (Form event code:C388=Sur affichage corps:K2:22)
	If ([LesCentres:9]LC_Excuse:49)
		OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; 1)
	Else 
		OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; 0)
	End if 
End if 