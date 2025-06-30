If (Form event code:C388=Sur affichage corps:K2:22)
	
	If ([HeberGement:5]HG_Genre:96=True:C214)
		va_sex:="F"
	Else 
		va_sex:="M"
	End if 
	
	If ([HeberGement:5]HG_Réservation:91=True:C214)
		va_Rés:="x"
	Else 
		va_Rés:=""
	End if 
	
	// #BS 11/07/16 le champ ne voulait pas s'afficher
	// Je passe par une variable et ça marche
	C_POINTER:C301($P)
	$P:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "reporte")
	$P->:=[HeberGement:5]HG_Reporté:94
End if 