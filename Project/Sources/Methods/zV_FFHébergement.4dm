//%attributes = {}
//Méthode formulaire : HG_EcranSaisie

$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_LC_Stop:=""
		va_CtrLib:=""
		x1:=0
		x2:=0
		ve_TheAge:=0
		va_TheAge:=""
		OBJECT SET VISIBLE:C603(*; "Asile_Cache"; True:C214)
		OBJECT SET ENTERABLE:C238(ve_FamH; False:C215)
		OBJECT SET ENTERABLE:C238(ve_FamF; False:C215)
		OBJECT SET ENTERABLE:C238(ve_FamFe; False:C215)
		OBJECT SET ENTERABLE:C238(ve_FamEMi; False:C215)
		OBJECT SET ENTERABLE:C238(ve_FamEMa; False:C215)
		OBJECT SET ENTERABLE:C238(ve_FamPMi; False:C215)
		OBJECT SET ENTERABLE:C238(ve_FamPMa; False:C215)
		OBJECT SET ENABLED:C1123(x1; False:C215)
		OBJECT SET ENABLED:C1123(x2; False:C215)
		
		
		If (User in group:C338(Current user:C182; <>Groupe_Asile))
			OBJECT SET VISIBLE:C603(*; "Asile_Cache"; False:C215)
			OBJECT SET ENTERABLE:C238(ve_FamH; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamF; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamFe; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamEMi; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamEMa; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamPMi; True:C214)
			OBJECT SET ENTERABLE:C238(ve_FamPMa; True:C214)
			OBJECT SET ENABLED:C1123(x1; True:C214)
			OBJECT SET ENABLED:C1123(x2; True:C214)
		End if 
		P_ChampAttribut(<>vlSTR_Std-<>vlSTR)
		
		If (Is new record:C668([HeberGement:5]))
			MultiSoc_Init_Structure(->[HeberGement:5])
			//Numérotation et affectation de la fiche d'hébergement
			P_HébergementNo(va_JourNuit)
			P_HébergementNoRéf
			If (F_VariablesTransite(4; 1; False:C215))
			End if 
			
			If (User in group:C338(Current user:C182; <>Groupe_Asile))
				If (Storage:C1525.dispositif.HG_ASFamChéf=3)
				Else 
					x1:=Num:C11([HeberGement:5]HG_FamChef:103=True:C214)
					x2:=Num:C11([HeberGement:5]HG_FamChef:103=False:C215)
				End if 
				If ([HeberGement:5]HG_FamChef:103)
					[HeberGement:5]HG_FamNbJour:107:=ve_IDT_FJou
					[HeberGement:5]HG_FamNbChambre:108:=ve_IDT_FChb
					[HeberGement:5]HG_FamPrixJour:109:=vr_IDT_FPxJ
					[HeberGement:5]HG_FamTotal:110:=vr_IDT_FPxT
				End if 
				[HeberGement:5]HG_FamCompoVar:117:=""
				P_HG_Famille(0)
				P_HG_FamilleChef(0)
				
				// [HéberGement]HG_FamGroupe:=◊va_HG_ASFamGroupe
			Else 
				[HeberGement:5]HG_FamGroupe:102:=Storage:C1525.dispositif.HG_ASPasFamGroupe  //"115"
			End if 
			OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Remp_@"; True:C214)
		Else 
			If (User in group:C338(Current user:C182; <>Groupe_Asile))
				x1:=Num:C11([HeberGement:5]HG_FamChef:103=True:C214)
				x2:=Num:C11([HeberGement:5]HG_FamChef:103=False:C215)
				P_HG_Famille(2)
				P_HG_FamilleChef(0)
			End if 
			
			If ([HeberGement:5]HG_ER_Excuse:124)
				OBJECT SET VISIBLE:C603(*; "Exc_@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
				If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_NuitenCours:92>=1) & ([HeberGement:5]HG_NuitReste:95>[HeberGement:5]HG_NuitenCours:92)
					
					OBJECT SET VISIBLE:C603(*; "Remp_@"; True:C214)
				Else 
					OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
				End if 
			End if 
			
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Externe))
			OBJECT SET VISIBLE:C603(*; "Prest_1"; False:C215)  //Prestations
			OBJECT SET VISIBLE:C603(*; "ActionPrt_1"; False:C215)  //Imprimer actions      
			If ([HeberGement:5]HG_Permanencier:9=Current user:C182)
				P_HG_Clôturé
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
			Else 
				OBJECT SET VISIBLE:C603(*; "Notes_@"; False:C215)  //Notes, Action,SP,NR
				OBJECT SET VISIBLE:C603(*; "Valider_1"; False:C215)  //Bouton de validation        
			End if 
		Else 
			P_HG_Clôturé
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
		End if 
		If (va_FormatFrom="V")
			If (7=8)  //•••••••••
				OBJECT SET VISIBLE:C603(*; "Prest_1"; False:C215)  //Prestations
				OBJECT SET VISIBLE:C603(*; "ActionPrt_1"; False:C215)  //Imprimer actions       
			End if 
		End if 
		If (<>vb_UserLOFT)
			If (Is new record:C668([HeberGement:5]))
				MultiSoc_Init_Structure(->[HeberGement:5])
				If (<>vl_LOFTCtrRéf>0)
					[HeberGement:5]HG_LC_ID:61:=<>vl_LOFTCtrRéf
					[HeberGement:5]HG_CentreNom:62:=<>va_LOFTCtrNom
					[HeberGement:5]HG_CentreARR:63:=<>va_LOFTCtrCP
					[HeberGement:5]HG_Médicalisé:56:=<>vb_LOFTCtrMéd
				End if 
			End if 
		End if 
		<>vl_NoHHisto:=[HeberGement:5]HG_HB_ID:19
		va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22
		ve_TheAge:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_Date:4)
		va_TheAge:=String:C10(ve_TheAge)
		P_Profil
		Case of 
			: (User in group:C338(Current user:C182; <>Groupe_Externe))
				If ([HeberGement:5]HG_Permanencier:9=Current user:C182)
					<>vlSTR_Std:=<>vlSTR_HGEP
				Else 
					<>vlSTR_Std:=<>vlSTR_HGE
				End if 
			: (User in group:C338(Current user:C182; <>Groupe_Asile))
				<>vlSTR_Std:=30108
			Else 
				<>vlSTR_Std:=<>vlSTR_HG1
		End case 
		
		<>vlSTR_Std_Soc:=(<>vlSTR_Std*1000)+<>ID_Societe_Active
		
		
		vl_CasSP:=0
		vb_CasSP:=False:C215
		vl_CasSP:=F_CasSP([HeberGement:5]HG_HB_ID:19; 1)
		vb_CasSP:=True:C214
		Case of 
			: (vl_CasSP=-1)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; True:C214)
				vb_CasSP:=True:C214
			: (vl_CasSP=0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; False:C215)
				vb_CasSP:=False:C215
			: (vl_CasSP>0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SP"; True:C214)
				vb_CasSP:=True:C214
				SET TIMER:C645(60)
		End case 
		
		
	: ($vl_EventFF=Sur minuteur:K2:25)
		
		OBJECT SET VISIBLE:C603(*; "Cligne_SP"; vb_CasSP)
		vb_CasSP:=Not:C34(vb_CasSP)
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		
		Case of 
			: (7=8) & (User in group:C338(Current user:C182; <>Groupe_Asile)) & (Modified:C32([HeberGement:5]HG_NuitTOTAL:93) | Modified:C32([HeberGement:5]HG_FamNbJour:107))
				If ([HeberGement:5]HG_FamNbJour:107#[HeberGement:5]HG_NuitTOTAL:93)
					StrAlerte(26; "Valeurs #")
				End if 
				If (Modified:C32([HeberGement:5]HG_NuitTOTAL:93))
					If ([HeberGement:5]HG_NuitTOTAL:93<[HeberGement:5]HG_NuitenCours:92)
						[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
					End if 
					[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
					//06/09/2004
					[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
				End if 
				
			: (Modified:C32([HeberGement:5]HG_NuitTOTAL:93))
				If ([HeberGement:5]HG_NuitTOTAL:93<[HeberGement:5]HG_NuitenCours:92)
					[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
				End if 
				[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
				//06/09/2004
				[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
			: (Modified:C32([HeberGement:5]HG_CentreNom:62))
				If ([HeberGement:5]HG_CentreNom:62<="")
					[HeberGement:5]HG_CentreNom:62:=""
					[HeberGement:5]HG_CentreARR:63:=""
					[HeberGement:5]HG_LC_ID:61:=0
				End if 
			: (Modified:C32([HeberGement:5]HG_Cloturée:67))
				If ([HeberGement:5]HG_Cloturée:67)
					[HeberGement:5]HG_EnAttente:64:=False:C215
				End if 
				
			: (Modified:C32([HeberGement:5]HG_Cloturée:67))
				
				
		End case 
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		[HeberGement:5]HG_FamClé:104:=<>va_LeNoFAM
End case 