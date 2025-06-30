Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_LONGINT:C283(hebergeSelectID_el; dossierSanteSelectID_el)
		
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		REDUCE SELECTION:C351([DossierSante:33]; 0)
		
		FIRST RECORD:C50([HeBerge:4])
		
		va_Nb_HG_F:=""
		va_Nb_MR_F:=""
		va_FrappeClavier:=""
		
		vL_Nb_HB_F:=0
		vL_Nb_HG_F:=0
		vL_Nb_MR_F:=0
		vL_RéfHBOld:=0
		vL_RéfHBNew:=0
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		vb_passe1:=False:C215
		
		K_BoutonDossierDem(False:C215)
		K_BoutonDossierDos(False:C215)
		
		If (<>vb_UserMessagerie)
			Process_Go3(-><>PR_MessagerieSté; "Go_Messagerie"; <>va_MessagerieSté; 64; <>va_MessagerieSté)
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>54) & (vl_SourisY<188))  // Sous-formulaire [Heberge]
			K_BoutonDossierDem(False:C215)
			K_BoutonDossierDos(False:C215)
			
			If ([HeBerge:4]HB_ReferenceID:1>0)
				va_Nb_MR_F:=[HeBerge:4]HB_Clé:2
				va_Nb_HG_F:=[HeBerge:4]HB_Clé:2
				
				QUERY:C277([DossierSante:33]; [DossierSante:33]DE_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[DossierSante:33])
				
				vl_Nb_MR_F:=Records in selection:C76([DossierSante:33])
				
				ORDER BY:C49([DossierSante:33]; [DossierSante:33]DE_Date:4; <; *)
				ORDER BY:C49([DossierSante:33]; [DossierSante:33]DE_Heure:5; <)
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[HeberGement:5])
				
				vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
				
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
				
				K_BoutonDossierDem(True:C214)
				OBJECT SET ENABLED:C1123(b_DosNew; True:C214)
			Else 
				REDUCE SELECTION:C351([DossierSante:33]; 0)
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				
				va_Nb_MR_F:=""
				va_Nb_HG_F:=""
				vl_Nb_MR_F:=0
				vL_Nb_HG_F:=0
			End if 
			
			// Modifié par : Scanu Rémy (22/12/2021)
			hebergeSelectID_el:=[HeBerge:4]ID:65
		End if 
		
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>243) & (vl_SourisY<362))  // Sous-formulaire [DossierSante] 
			
			If ([DossierSante:33]DE_Référence:1>0)
				K_BoutonDossierDos(True:C214)
			Else 
				K_BoutonDossierDos(False:C215)
				
				If ([HeBerge:4]HB_ReferenceID:1>0)
					OBJECT SET ENABLED:C1123(b_DosNew; True:C214)
				End if 
				
			End if 
			
		End if 
		
	: (Form event code:C388=Sur double clic:K2:5)
		
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>243) & (vl_SourisY<362))  // Sous-formulaire [DossierSante] 
			
			If ([DossierSante:33]DE_Référence:1>0)
				F_UnDossierTypeModifié(->[DossierSante:33]; "DE_EcranSaisie"; "Fiche Dossier Santé"; 1)
			End if 
			
		End if 
		
	: (Form event code:C388=Sur case de fermeture:K2:21)
		outilsCleanVariable(->hebergeSelectID_el; ->dossierSanteSelectID_el)
End case 