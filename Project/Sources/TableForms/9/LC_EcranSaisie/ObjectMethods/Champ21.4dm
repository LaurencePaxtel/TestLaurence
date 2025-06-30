UTL_Adresse_Gere(->[LesCentres:9]ID:60; ->[LesCentres:9])

//ALERTE("Avant traitement : AD_Adresse1="+[Adresses]AD_Adresse1+"; LC_Adr1="+[LesCentres]LC_Adr1)

If (Is new record:C668([Adresses:53]))
	[Adresses:53]AD_Adresse1:16:=[LesCentres:9]LC_Adr1:24
	[Adresses:53]AD_Adresse2:17:=[LesCentres:9]LC_Adr2:25
	[Adresses:53]AD_Adresse3:18:=[LesCentres:9]LC_Adr3:26
	[Adresses:53]AD_Code_postal:19:=[LesCentres:9]LC_CP:27
	[Adresses:53]AD_Ville:20:=[LesCentres:9]LC_Ville:28
	
	//ALERTE("Après création de l'enregistrement : AD_Adresse1="+[Adresses]AD_Adresse1)
End if 

If (Not:C34(Is new record:C668([Adresses:53])))
	// Vérifie si l'adresse a changé après la duplication
	ALERT:C41("Avant mise à jour : AD_Adresse1="+[Adresses:53]AD_Adresse1:16+"; LC_Adr1="+[LesCentres:9]LC_Adr1:24)
	If ([Adresses:53]AD_Adresse1:16#[LesCentres:9]LC_Adr1:24)
		[Adresses:53]AD_Adresse1:16:=[LesCentres:9]LC_Adr1:24
	End if 
	If ([Adresses:53]AD_Adresse2:17#[LesCentres:9]LC_Adr2:25)
		[Adresses:53]AD_Adresse2:17:=[LesCentres:9]LC_Adr2:25
	End if 
	If ([Adresses:53]AD_Adresse3:18#[LesCentres:9]LC_Adr3:26)
		[Adresses:53]AD_Adresse3:18:=[LesCentres:9]LC_Adr3:26
	End if 
	If ([Adresses:53]AD_Code_postal:19#[LesCentres:9]LC_CP:27)
		[Adresses:53]AD_Code_postal:19:=[LesCentres:9]LC_CP:27
	End if 
	If ([Adresses:53]AD_Ville:20#[LesCentres:9]LC_Ville:28)
		[Adresses:53]AD_Ville:20:=[LesCentres:9]LC_Ville:28
	End if 
	ALERT:C41("Après mise à jour : AD_Adresse1="+[Adresses:53]AD_Adresse1:16)
End if 


//Si (Non(Nouvel enregistrement([Adresses])))
//Si ([Adresses]AD_Adresse1="")
//[Adresses]AD_Adresse1:=[LesCentres]LC_Adr1
//Fin de si 
//Si ([Adresses]AD_Adresse2="")
//[Adresses]AD_Adresse2:=[LesCentres]LC_Adr2
//Fin de si 
//Si ([Adresses]AD_Adresse3="")
//[Adresses]AD_Adresse3:=[LesCentres]LC_Adr3
//Fin de si 
//Si ([Adresses]AD_Code_postal="")
//[Adresses]AD_Code_postal:=[LesCentres]LC_CP
//Fin de si 
//Si ([Adresses]AD_Ville="")
//[Adresses]AD_Ville:=[LesCentres]LC_Ville
//Fin de si 
//Fin de si 
