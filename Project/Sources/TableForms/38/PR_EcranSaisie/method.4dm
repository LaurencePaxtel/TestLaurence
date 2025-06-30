$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_TypeNo:=""
		
		
		If (Is new record:C668([Prolongation:38]))
			MultiSoc_Init_Structure(->[Prolongation:38])
			[Prolongation:38]PR_RéférenceID:1:=Uut_Numerote(->[Prolongation:38])
			[Prolongation:38]PR_Groupe:4:=True:C214
			[Prolongation:38]PR_Date:2:=Current date:C33
			[Prolongation:38]PR_Heure:3:=heure du jour
			[Prolongation:38]PR_GPHB_Référence:5:=[GrouPe:36]GP_ReferenceID:1
			[Prolongation:38]PR_RésaDateDébut:6:=vd_Pro_DateDeFin+1
			[Prolongation:38]PR_RésaNbMois:13:=1
			[Prolongation:38]PR_LC_ID:9:=vl_Pro_LCréf
			[Prolongation:38]PR_RésaGroupe:14:=va_Pro_Groupe
			MultiSoc_Init_Structure(->[Prolongation:38])
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[Prolongation:38]PR_LC_ID:9)
			MultiSoc_Filter(->[LesCentres:9])
			
			If (Records in selection:C76([LesCentres:9])=1)
				[Prolongation:38]PR_CentreNoms:10:=[LesCentres:9]LC_Nom:4
			Else 
				[Prolongation:38]PR_CentreNoms:10:="???"
			End if 
			[Prolongation:38]PR_ProlongationEffectuée:11:=False:C215
			[Prolongation:38]PR_ProlongationEffectuéeDate:12:=!00-00-00!
			P_PrologationDateFin([Prolongation:38]PR_RésaDateDébut:6; [Prolongation:38]PR_RésaNbMois:13; ->[Prolongation:38]PR_RésaNbJours:8; ->[Prolongation:38]PR_RésaDateFin:7)
			
			OBJECT SET ENTERABLE:C238([Prolongation:38]PR_RésaDateDébut:6; False:C215)
		Else 
		End if 
		va_GP_Intitulé:=[GrouPe:36]GP_Intitulé:4
		
		If ([Prolongation:38]PR_ProlongationEffectuée:11)
			OBJECT SET VISIBLE:C603(*; "Pr_Ctr_@"; False:C215)
			OBJECT SET ENABLED:C1123(b_ValPR; False:C215)
			OBJECT SET ENABLED:C1123(b_xx; False:C215)
			OBJECT SET ENTERABLE:C238([Prolongation:38]PR_RésaNbMois:13; False:C215)
			OBJECT SET ENTERABLE:C238([Prolongation:38]PR_RésaDateDébut:6; False:C215)
			OBJECT SET ENTERABLE:C238([Prolongation:38]PR_ProlongationEffectuée:11; False:C215)
			
		End if 
		
		P_PRO_Famille(1; ->[Prolongation:38]PR_FamilleComposition:15; ->[Prolongation:38]PR_FamilleCompositionV:16; ->[Prolongation:38]PR_NbPersonnes:17)
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		If (Modified:C32([Prolongation:38]PR_RésaNbMois:13) | Modified:C32([Prolongation:38]PR_RésaDateDébut:6))
			If ([Prolongation:38]PR_RésaNbMois:13<1) | ([Prolongation:38]PR_RésaNbMois:13><>ve_ProLg_MaxMois)
				
				If ([Prolongation:38]PR_RésaNbMois:13<1)
					ALERT:C41("La prolongation doit être d'au moins : "+" 1 mois .")
				Else 
					ALERT:C41("La prolongation ne peut dépasser : "+String:C10(<>ve_ProLg_MaxMois)+" mois .")
				End if 
				REJECT:C38([Prolongation:38]PR_RésaNbMois:13)
			Else 
				P_PrologationDateFin([Prolongation:38]PR_RésaDateDébut:6; [Prolongation:38]PR_RésaNbMois:13; ->[Prolongation:38]PR_RésaNbJours:8; ->[Prolongation:38]PR_RésaDateFin:7)
			End if 
		End if 
		
		If (Modified:C32([Prolongation:38]PR_ProlongationEffectuée:11))
			If ([Prolongation:38]PR_ProlongationEffectuée:11)
				[Prolongation:38]PR_ProlongationEffectuéeDate:12:=Current date:C33
				
			End if 
		End if 
End case 
