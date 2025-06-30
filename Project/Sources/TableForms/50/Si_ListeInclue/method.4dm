If (Form event code:C388=Sur affichage corps:K2:22)
	VA_TRANSCASTYPE:=("I"*Num:C11([SIAO:50]Si_Trans_Type:34))+("U"*Num:C11([SIAO:50]Si_Trans_Type:34=False:C215))
	va_TitreCasANNUL:=("A"*Num:C11([SIAO:50]Si_DemandeAnnulee_Date:30>!00-00-00!))
	
	QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
	QUERY:C277([SIAO_Personnes:51];  & [SIAO_Personnes:51]Sp_Rang:7=1)
	MultiSoc_Filter(->[SIAO_Personnes:51])
	va_TitreETCV:=F_EtatCicil_Code([SIAO_Personnes:51]Sp_EtatCivil:8)
	
	va_TitreProposition:=""
	va_TitreLogement:=""
	va_TitreDemande:=("I"*Num:C11([SIAO:50]Si_Demande_Type:5=1))+("F"*Num:C11([SIAO:50]Si_Demande_Type:5=2))+("G"*Num:C11([SIAO:50]Si_Demande_Type:5=3))
	
	If ([SIAO:50]Si_RéférenceID:1>0)
		If (Size of array:C274(ta_ColSiao_ColA)>0)
			If (ta_ColSiao_ColA>0)
				Case of 
					: (ta_ColSiao_ColACas{ta_ColSiao_ColA}="XX18")
						va_TitreProposition:=[SIAO:50]Si_Origine_SiteAccueil:18
					: (ta_ColSiao_ColACas{ta_ColSiao_ColA}="XX22")
						va_TitreProposition:=[SIAO:50]Si_Log_Souhaite1:22
					: (ta_ColSiao_ColACas{ta_ColSiao_ColA}="XX35")
						va_TitreProposition:=[SIAO:50]Si_Trans_Competent:35
					Else 
						QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{Num:C11(Substring:C12(ta_ColSiao_ColACas{ta_ColSiao_ColA}; 1; 2))}; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_SousTheme:6=ta_ColSiao_ColACas{ta_ColSiao_ColA}[[3]]; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_Rang:7=Num:C11(ta_ColSiao_ColACas{ta_ColSiao_ColA}[[4]]))
						MultiSoc_Filter(->[SIAO_Situations:52])
						va_TitreProposition:=i_ChampChaine(tp_ColSiao_ColA{ta_ColSiao_ColA})
						
				End case 
			End if 
		End if 
		
		
		If (Size of array:C274(ta_ColSiao_ColB)>0)
			If (ta_ColSiao_ColB>0)
				Case of 
					: (ta_ColSiao_ColBCas{ta_ColSiao_ColB}="XX18")
						va_TitreLogement:=[SIAO:50]Si_Origine_SiteAccueil:18
					: (ta_ColSiao_ColBCas{ta_ColSiao_ColB}="XX22")
						va_TitreLogement:=[SIAO:50]Si_Log_Souhaite1:22
					: (ta_ColSiao_ColBCas{ta_ColSiao_ColB}="XX35")
						va_TitreLogement:=[SIAO:50]Si_Trans_Competent:35
					Else 
						QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{Num:C11(Substring:C12(ta_ColSiao_ColBCas{ta_ColSiao_ColB}; 1; 2))}; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_SousTheme:6=ta_ColSiao_ColBCas{ta_ColSiao_ColB}[[3]]; *)
						QUERY:C277([SIAO_Situations:52];  & [SIAO_Situations:52]Ss_Rang:7=Num:C11(ta_ColSiao_ColBCas{ta_ColSiao_ColB}[[4]]))
						MultiSoc_Filter(->[SIAO_Situations:52])
						va_TitreLogement:=i_ChampChaine(tp_ColSiao_ColB{ta_ColSiao_ColB})
				End case 
				
				
			End if 
		End if 
		
	End if 
	
	
	
	OBJECT SET VISIBLE:C603(*; "CAS_URGENT"; ([SIAO:50]Si_Trans_Type:34=False:C215))
	OBJECT SET VISIBLE:C603(*; "CAS_INSERT"; [SIAO:50]Si_Trans_Type:34)
	If (7=8)
		va_TitreCasReserve:=("I"*Num:C11([SIAO:50]Si_Demande_Type:5=1))+("F"*Num:C11([SIAO:50]Si_Demande_Type:5=2))+("G"*Num:C11([SIAO:50]Si_Demande_Type:5=3))
	Else 
		va_TitreCasReserve:=F_EtatCicil_Code([SIAO:50]Si_Etat_Type:41)
	End if 
	
	If ([SIAO:50]Si_Fermeture:46>!00-00-00!)
		OBJECT SET VISIBLE:C603(*; "Dos_Normal"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Dos_Ferme"; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "Dos_Normal"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Dos_Ferme"; False:C215)
	End if 
End if 
