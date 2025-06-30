
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		Case of 
			: (FAC_Facturer_au_locataire=1)
				[LesCentres:9]LC_GL_Destination_Facture:67:="locataire"
			: (FAC_Facturer_au_proprietaire=1)
				[LesCentres:9]LC_GL_Destination_Facture:67:="propriétaire"
			Else 
				[LesCentres:9]LC_GL_Destination_Facture:67:="centre"
		End case 
	Else 
		Case of 
			: ([LesCentres:9]LC_GL_Destination_Facture:67="locataire")
				FAC_Facturer_au_locataire:=1
				FAC_Facturer_au_proprietaire:=0
				FAC_Facturer_au_centre:=0
				
			: ([LesCentres:9]LC_GL_Destination_Facture:67="propriétaire")
				FAC_Facturer_au_locataire:=0
				FAC_Facturer_au_proprietaire:=1
				FAC_Facturer_au_centre:=0
			Else 
				FAC_Facturer_au_locataire:=0
				FAC_Facturer_au_proprietaire:=0
				FAC_Facturer_au_centre:=1
		End case 
End case 


