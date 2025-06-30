


If (Is new record:C668([LesCentres:9]))
	P_DisponibilitéNewCentre
Else 
	If (Old:C35([LesCentres:9]LC_Fermé:53)=True:C214) & ([LesCentres:9]LC_Fermé:53=False:C215)
		P_DisponibilitéNewCentre
	End if 
End if 

SAVE RECORD:C53([Adresses:53])

