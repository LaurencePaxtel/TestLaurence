$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		r1:=Num:C11(<>vb_MarNuit=False:C215)
		r2:=Num:C11(<>vb_MarNuit=True:C214)
		OBJECT SET ENABLED:C1123(r1; False:C215)
		OBJECT SET ENABLED:C1123(r2; False:C215)
		vb_passe1:=False:C215
		vL_Nb_HB_F:=0
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vL_Nb_HG_F:=0
		va_Nb_HG_F:=""
		REDUCE SELECTION:C351([Maraude:24]; 0)
		vL_Nb_MR_F:=0
		va_Nb_MR_F:=""
		FIRST RECORD:C50([HeBerge:4])
		vL_RéfHBOld:=0
		vL_RéfHBNew:=0
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		va_FrappeClavier:=""
		wresMulti:=0  //ajouté 05/12/2018
		K_BoutonDossierDem(False:C215)
		K_BoutonDossierDos(False:C215)
		
	: ($vl_eventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		
		//DEMANDEUR
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>54) & (vl_SourisY<185))
			K_BoutonDossierDem(False:C215)
			K_BoutonDossierDos(False:C215)
			
			va_IDT_TypTrans:=""
			
			If ([HeBerge:4]HB_ReferenceID:1>0)
				va_Nb_MR_F:=[HeBerge:4]HB_Clé:2
				va_Nb_HG_F:=[HeBerge:4]HB_Clé:2
				
				QUERY:C277([Maraude:24]; [Maraude:24]MR_HB_ID:10=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[Maraude:24])
				
				vl_Nb_MR_F:=Records in selection:C76([Maraude:24])
				
				ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Date:4; <; *)
				ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Heure:5; <)
				
				FIRST RECORD:C50([Maraude:24])
				
				If (vl_Nb_MR_F>0)
					va_IDT_TypTrans:=[Maraude:24]MR_EtatCivil:16
				End if 
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[HeberGement:5])
				
				vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
				
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
				
				K_BoutonDossierDem(True:C214)
				OBJECT SET ENABLED:C1123(b_DosNew; True:C214)
			Else 
				REDUCE SELECTION:C351([Maraude:24]; 0)
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				
				va_Nb_MR_F:=""
				va_Nb_HG_F:=""
				vl_Nb_MR_F:=0
				vL_Nb_HG_F:=0
			End if 
			
		End if 
		
		//DOSIIERS    
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>243) & (vl_SourisY<362))
			
			If ([Maraude:24]MR_RéférenceID:1>0)
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
			
			If ([Maraude:24]MR_RéférenceID:1>0)
				p_VarMR(-1)
				
				F_UnDossierTypeModifié(->[Maraude:24]; "MR_EcranSaisie"; "Fiche Dossier EMA"; 1)
			End if 
			
		End if 
		
End case 