//%attributes = {}
If (Size of array:C274(ta_ColSiao_ColA)>0)
	If (ta_ColSiao_ColA>0)
		If (ta_ColSiao_ColACas{ta_ColSiao_ColA}="XXXX")
			va_TitreProposition:=[SIAO:50]Si_Log_Souhaite1:22
		Else 
			
			
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{Num:C11(Substring:C12(ta_ColSiao_ColACas{ta_ColSiao_ColA}; 1; 2))}; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=ta_ColSiao_ColACas{ta_ColSiao_ColA}[[3]]; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Rang:7=Num:C11(ta_ColSiao_ColACas{ta_ColSiao_ColA}[[4]]))
			MultiSoc_Filter(->[SIAO_Situations:52])
			va_TitreProposition:=i_ChampChaine(tp_ColSiao_ColA{ta_ColSiao_ColA})
		End if 
	End if 
End if 


If (Size of array:C274(ta_ColSiao_ColB)>0)
	If (ta_ColSiao_ColB>0)
		If (ta_ColSiao_ColBCas{ta_ColSiao_ColB}="XXXX")
			va_TitreLogement:=[SIAO:50]Si_Log_Souhaite1:22
		Else 
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{Num:C11(Substring:C12(ta_ColSiao_ColBCas{ta_ColSiao_ColB}; 1; 2))}; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=ta_ColSiao_ColBCas{ta_ColSiao_ColB}[[3]]; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Rang:7=Num:C11(ta_ColSiao_ColBCas{ta_ColSiao_ColB}[[4]]))
			MultiSoc_Filter(->[SIAO_Situations:52])
			va_TitreLogement:=i_ChampChaine(tp_ColSiao_ColB{ta_ColSiao_ColB})
		End if 
	End if 
End if 




If (7=8)
	//Avant le 19/1/2012      
	If (vb_ColLogement=False:C215)
		va_TitreLogement:=[SIAO:50]Si_Log_Souhaite1:22
	Else 
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{7}; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6="A")
		MultiSoc_Filter(->[SIAO_Situations:52])
		va_TitreLogement:=[SIAO_Situations:52]Ss_Intitule:9
	End if 
	
	If (vb_ColProposition)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{12}; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6="C")
		MultiSoc_Filter(->[SIAO_Situations:52])
		va_TitreProposition:=[SIAO_Situations:52]Ss_Intitule:9
	Else 
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=[SIAO_Personnes:51]Sp_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{12}; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6="B")
		MultiSoc_Filter(->[SIAO_Situations:52])
		va_TitreProposition:=[SIAO_Situations:52]Ss_Intitule:9
	End if 
End if 