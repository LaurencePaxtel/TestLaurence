//Formule Format : iListe reports
If (Form event code:C388=Sur affichage corps:K2:22)
	
	If (Is record loaded:C669([HeberGement:5]))
		
		va_DossierSIAO:=""
		
		OBJECT SET VISIBLE:C603(*; "ID_Centre"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ID_FamCle"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ID_DossierSIAO"; False:C215)
		
		If ([HeberGement:5]HG_ReferenceID:1>0)
			
			OBJECT SET VISIBLE:C603(*; "ID_Centre"; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			OBJECT SET VISIBLE:C603(*; "ID_FamCle"; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			OBJECT SET VISIBLE:C603(*; "ID_DossierSIAO"; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			
			
			//POUR Cryptage
			vb_LaCléEstCryptée:=False:C215
			OBJECT SET VISIBLE:C603(*; "LaCléCodée"; vb_LaCléEstCryptée)
			OBJECT SET VISIBLE:C603(*; "LaClé"; (vb_LaCléEstCryptée=False:C215))
			
			va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
			va_Rép2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
			
			//If (Length([HeberGement]HG_AutreSolutio+" "+[HeberGement]HG_AutreSolSuite)>2)
			//  //TRACE
			//End if 
			va_AutSol:=[HeberGement:5]HG_AutreSolutio:88+" "+[HeberGement:5]HG_AutreSolSuite:123
			
			If ([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115")
				va_GroupeAS:="115"
			Else 
				va_GroupeAS:="DA"
			End if 
			
			If ([HeberGement:5]HG_FamChef:103)
				OBJECT SET FONT STYLE:C166(va_GroupeAS; Souligné:K14:4)
			Else 
				OBJECT SET FONT STYLE:C166(va_GroupeAS; Normal:K14:1)
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
			
			
			va_Perimetre115:=("•"*Num:C11((([HeberGement:5]HG_LC_ID:61>0) & ([HeberGement:5]HG_LC_ID:61<=999999)) | ([HeberGement:5]HG_FamGroupe:102="115")))
			
			
			If (uEmplace=1)
				va_Emplacement:=[HeberGement:5]HG_Orientation1:58
			Else 
				va_Emplacement:=[HeberGement:5]HG_Emplacement:17
			End if 
			
			
			SET QUERY LIMIT:C395(1)  // #BS Pas la peine d'en trouver 2
			QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=[HeberGement:5]HG_HB_ID:19)
			MultiSoc_Filter(->[SIAO_Personnes:51])
			SET QUERY LIMIT:C395(0)
			If (Records in selection:C76([SIAO_Personnes:51])>0)
				va_DossierSIAO:="SI"  //AO"
			Else 
				va_DossierSIAO:=""
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
			va_Perimetre115:=""
		End if 
	End if 
End if 






