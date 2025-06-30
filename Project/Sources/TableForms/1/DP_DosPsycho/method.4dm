$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		vb_passe1:=False:C215
		vL_Nb_HB_F:=0
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vL_Nb_HG_F:=0
		va_Nb_HG_F:=""
		REDUCE SELECTION:C351([DossierPsycho:28]; 0)
		vL_Nb_MR_F:=0
		va_Nb_MR_F:=""
		FIRST RECORD:C50([HeBerge:4])
		vL_RéfHBOld:=0
		vL_RéfHBNew:=0
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		va_FrappeClavier:=""
		K_BoutonDossierDem(False:C215)
		K_BoutonDossierDos(False:C215)
		
	: ($vl_eventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		//DEMANDEUR
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>54) & (vl_SourisY<188))
			K_BoutonDossierDem(False:C215)
			K_BoutonDossierDos(False:C215)
			If ([HeBerge:4]HB_ReferenceID:1>0)
				va_Nb_MR_F:=[HeBerge:4]HB_Clé:2
				va_Nb_HG_F:=[HeBerge:4]HB_Clé:2
				QUERY:C277([DossierPsycho:28]; [DossierPsycho:28]DY_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				vl_Nb_MR_F:=Records in selection:C76([DossierPsycho:28])
				ORDER BY:C49([DossierPsycho:28]; [DossierPsycho:28]DY_Date:4; <; *)
				ORDER BY:C49([DossierPsycho:28]; [DossierPsycho:28]DY_Heure:5; <)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
				vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
				K_BoutonDossierDem(True:C214)
				OBJECT SET ENABLED:C1123(b_DosNew; True:C214)
			Else 
				REDUCE SELECTION:C351([DossierPsycho:28]; 0)
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				va_Nb_MR_F:=""
				va_Nb_HG_F:=""
				vl_Nb_MR_F:=0
				vL_Nb_HG_F:=0
			End if 
		End if 
		//DOSIIERS    
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>243) & (vl_SourisY<362))
			If ([DossierPsycho:28]DY_Référence:1>0)
				K_BoutonDossierDos(True:C214)
			Else 
				K_BoutonDossierDos(False:C215)
				If ([HeBerge:4]HB_ReferenceID:1>0)
					OBJECT SET ENABLED:C1123(b_DosNew; True:C214)
				End if 
			End if 
		End if 
	: ($vl_eventFF=Sur double clic:K2:5)
		//DOSIIERS    
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>243) & (vl_SourisY<362))
			If ([DossierPsycho:28]DY_Référence:1>0)
				If (F_UnDossierTypeModifié(->[DossierPsycho:28]; "DY_EcranSaisie"; "Fiche Dossier Psycho"; 0))
				End if 
			End if 
		End if 
End case 