$vl_EventFF:=Form event code:C388
Case of 
		
	: ($vl_EventFF=Sur affichage corps:K2:22)
		
		vl_Champs:=0
		vt_Champs:=""
		QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[Prolongation:38]PR_GPHB_Référence:5)
		MultiSoc_Filter(->[GrouPe:36])
		If (Records in selection:C76([GrouPe:36])=1)
			vt_Champs:=[GrouPe:36]GP_Intitulé:4
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
			MultiSoc_Filter(->[GroupeHeberges:37])
			vl_Champs:=Records in selection:C76([GroupeHeberges:37])
		End if 
		
		If (7=8)
			If ([Prolongation:38]PR_Groupe:4)
				QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[Prolongation:38]PR_GPHB_Référence:5)
				MultiSoc_Filter(->[GrouPe:36])
				If (Records in selection:C76([GrouPe:36])=1)
					vt_Champs:=[GrouPe:36]GP_Intitulé:4
					QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
					MultiSoc_Filter(->[GroupeHeberges:37])
					vl_Champs:=Records in selection:C76([GroupeHeberges:37])
				End if 
			Else 
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Prolongation:38]PR_GPHB_Référence:5)
				MultiSoc_Filter(->[HeBerge:4])
				If (Records in selection:C76([HeBerge:4])=1)
					vt_Champs:=[HeBerge:4]HB_Clé:2
					vl_Champs:=1
				End if 
				
			End if 
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 