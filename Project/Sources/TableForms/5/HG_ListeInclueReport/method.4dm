//Formule Format : iListe reports
If (Form event code:C388=Sur affichage corps:K2:22)
	
	If ([HeberGement:5]HG_ReferenceID:1>0)
		
		va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
		
		va_Rép2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
		
		va_AutSol:=[HeberGement:5]HG_AutreSolutio:88+" "+[HeberGement:5]HG_AutreSolSuite:123
		
		If ([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115")
			va_GroupeAS:="115"
		Else 
			va_GroupeAS:="DA"
		End if 
		If ([HeberGement:5]HG_FamChef:103)
			OBJECT SET FONT STYLE:C166(va_GroupeAS; 4)
		Else 
			OBJECT SET FONT STYLE:C166(va_GroupeAS; 0)
		End if 
		
		If ([HeberGement:5]HG_Réservation:91)
			
			If ([HeberGement:5]HG_NuitReste:95<=0)
				va_Réservation:="Prolongation"
			Else 
				va_Réservation:="Reservation"
			End if 
			
		Else 
			va_Réservation:=""
		End if 
		
		
		If (uEmplace=1)
			va_Emplacement:=[HeberGement:5]HG_Gare:15
		Else 
			va_Emplacement:=[HeberGement:5]HG_Emplacement:17
		End if 
		
		// #BS 11/07/16 le champ ne voulait pas s'afficher
		// Je passe par une variable et ça marche
		C_POINTER:C301($P)
		$P:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "reporte")
		$P->:=[HeberGement:5]HG_Reporté:94
		
	Else 
		va_GroupeAS:=""
		va_NomClé:=""
		va_Réservation:=""
		va_Rép2:=""
		va_Emplacement:=""
		va_AutSol:=""
	End if 
End if 