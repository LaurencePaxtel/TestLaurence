$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
		READ WRITE:C146([Maraude_MR_PathologieListe:62])
		READ WRITE:C146([Maraude_MR_ReferentList:60])
		READ WRITE:C146([Maraude_MR_SuiviMedicalList:61])
		
		vb_MRferme:=False:C215
		
		
		// Modified by: Kevin HASSAL (23-01-2019)
		
		OBJECT SET VISIBLE:C603(*; "b_SuppMaraude"; False:C215)
		If ((User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN)))
			OBJECT SET VISIBLE:C603(*; "b_SuppMaraude"; True:C214)
		End if 
		
		
		If (Is new record:C668([Maraude:24]))
			MultiSoc_Init_Structure(->[Maraude:24])
			
			[Maraude:24]MR_RéférenceID:1:=Uut_Numerote(->[Maraude:24])
			[Maraude:24]MR_Date:4:=Current date:C33()
			[Maraude:24]MR_Heure:5:=Current time:C178()
			[Maraude:24]MR_FicheNuméro:3:=<>va_T_Site+("J"*Num:C11(vb_JouN=False:C215))+("N"*Num:C11(vb_JouN=True:C214))+Uut_NumeroteDossier("MR"; [Maraude:24]MR_Date:4)
			va_Identité:=""
			[Maraude:24]MR_Nuit:2:=vb_JouN
			[Maraude:24]MR_Opérateur:8:=Current user:C182
			[Maraude:24]MR_HB_ID:10:=vl_RéfU_HBB
			[Maraude:24]MR_EtatCivil:16:=va_IDT_Typ1
			[Maraude:24]MR_Nom:17:=va_IDT_Nom
			[Maraude:24]MR_Prénom:18:=va_IDT_Pré
			[Maraude:24]MR_DateNéLe:20:=vd_IDT_NéLe
			[Maraude:24]MR_Age:19:=Uut_HébergéAgePlus(->[Maraude:24]MR_DateNéLe:20; ->[Maraude:24]MR_Date:4)
			[Maraude:24]MR_Genre:42:=(x_IDTG_1=0)
			
			p_VarMR(2)
		End if 
		RELATE MANY:C262([Maraude:24]ID:91)
		
		va_Identité:=[Maraude:24]MR_Nom:17+" "+[Maraude:24]MR_Prénom:18
		
		P_ChampAttribut(<>vlSTR_MR-<>vlSTR)
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		
		If (Modified:C32([Maraude:24]MR_HeureDebut:22) | Modified:C32([Maraude:24]MR_HeureFin:23))
			[Maraude:24]MR_DuréRencontr:79:=[Maraude:24]MR_HeureFin:23-[Maraude:24]MR_HeureDebut:22
			If ([Maraude:24]MR_DuréRencontr:79<?00:00:00?)
				[Maraude:24]MR_DuréRencontr:79:=(?24:00:00?-[Maraude:24]MR_HeureDebut:22)+[Maraude:24]MR_HeureFin:23
			End if 
		End if 
		
		
	: ($vl_EventFF=Sur libération:K2:2)
		
		UNLOAD RECORD:C212([Maraude_MR_PathologieListe:62])
		READ ONLY:C145([Maraude_MR_PathologieListe:62])
		
		UNLOAD RECORD:C212([Maraude_MR_ReferentList:60])
		READ ONLY:C145([Maraude_MR_ReferentList:60])
		
		UNLOAD RECORD:C212([Maraude_MR_SuiviMedicalList:61])
		READ ONLY:C145([Maraude_MR_SuiviMedicalList:61])
		
End case 