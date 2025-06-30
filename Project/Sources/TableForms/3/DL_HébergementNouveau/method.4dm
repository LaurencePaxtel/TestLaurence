//Format sans groupes
C_LONGINT:C283($vl_EventFF; $ii)
C_BOOLEAN:C305($vb_OK; $vb_OK2)
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "BoiteLettres"; <>vb_T_BoiteLettres)
		OBJECT SET VISIBLE:C603(*; "BoiteDalo"; <>vb_T_BoiteDalo)
		
		
		OBJECT SET VISIBLE:C603(b_RecNW; False:C215)
		<>ta_Cohabitation:=0
		If (Size of array:C274(<>ta_Cohabitation)>0)
			<>ta_Cohabitation:=1
		End if 
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		rIDTG_1:=x_IDTG_1
		rIDTG_2:=x_IDTG_2
		va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
		va_IDT_CléFam:=""
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		va_FrappeClavier:=""
		va_FrappeClavierP:=""
		va_FrappeClavierD:=""
		ve_NbHGi:=0
		va_NNN:=""
		wresMulti:=0
		ARRAY LONGINT:C221(<>tl_FamilleID; 0)
		ARRAY TEXT:C222(<>ta_FamilleClé; 0)
		ARRAY TEXT:C222(<>ta_FamilleEtCv; 0)
		<>va_RéserveAction:=""
		If (wresMulti=1)
			OBJECT SET ENABLED:C1123(b_InFam; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_InFam; False:C215)
		End if 
		vb_PasseR:=False:C215
		P_HébergementNotesBt(0)
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		OBJECT SET VISIBLE:C603(*; "LibresMulti"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LibresUn"; True:C214)
		OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*Num:C11(<>PR_HébergementMul>0))+("Montrer les rés. multiples"*Num:C11(<>PR_HébergementMul=0)))
		
		//Fonctionnalité abandonnée le 20/12/2004
		OBJECT SET VISIBLE:C603(*; "VSM_@"; False:C215)
		
		//Fonctionnalité fictive le 7/7/2008
		OBJECT SET VISIBLE:C603(*; "CRYP_BT"; <>vb_T_Cryptage)
		
		If (va_JourNuit="N") & (<>vb_T_ModeCHRS=True:C214)
			OBJECT SET TITLE:C194(b_CérerHgé; "Clé + Prestation")
			//     TITRE BOUTON(b_ValHBnew;"Nouvelle  prestation")
			OBJECT SET TITLE:C194(b_ValHBnew; "Prestation")
		Else 
			OBJECT SET TITLE:C194(b_CérerHgé; "Clé + Hébergement")
			// TITRE BOUTON(b_ValHBnew;"Nouvel hébergement")
			OBJECT SET TITLE:C194(b_ValHBnew; "Hébergement")
		End if 
		
		If (<>vb_T_ModeCHRS)
			wSansFiltre:=1
		Else 
			wSansFiltre:=0
		End if 
		OBJECT SET VISIBLE:C603(wSansFiltre; User in group:C338(Current user:C182; <>Groupe_SansFiltre))
		
	: ($vl_EventFF=Sur clic:K2:4)
		//DEMANDEUR    
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>53) & (vl_SourisY<249))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				If (Macintosh control down:C544) | (Windows Ctrl down:C562)
					<>vt_Trans:=[HeBerge:4]HB_Clé:2
					If (<>PR_AppelMem#0)
						POST OUTSIDE CALL:C329(<>PR_AppelMem)
					Else 
						QUERY:C277([MemO:30]; [MemO:30]MO_UserID:1=<>vl_UserRéfU)
						If (Records in selection:C76([MemO:30])=1)
							READ WRITE:C146([MemO:30])
							If (i_NonVerrou(->[MemO:30]))
								[MemO:30]MO_Note:5:=[MemO:30]MO_Note:5+<>va_CR+<>vt_Trans
								SAVE RECORD:C53([MemO:30])
								UNLOAD RECORD:C212([MemO:30])
							End if 
							READ ONLY:C145([MemO:30])
						Else 
							StrAlerte(4; "")
						End if 
						UNLOAD RECORD:C212([MemO:30])
					End if 
					
				End if 
				Rec_Hébergements1(->vL_Nb_HG_F)
				va_NNN:=F_AfficheCléHébergé
				P_HébergementNotesBt(1)
				If (wresMulti=0)
					OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
				End if 
			Else 
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				vL_Nb_HG_F:=0
				va_NNN:=""
				P_HébergementNotesBt(0)
				If (wresMulti=0)
					OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
				End if 
			End if 
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		Case of 
			: ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>53) & (vl_SourisY<249))
				//DEMANDEUR                
				If ([HeBerge:4]HB_ReferenceID:1>0)
					If (wresMulti=1)
						$pos:=Find in array:C230(<>tl_FamilleID; [HeBerge:4]HB_ReferenceID:1)
						If ($pos>0)
						Else 
							If (F_HébergementCtrlCréation(va_JourNuit))
								Tab_PopIn1n("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
								If (va_IDT_Typ1>"")
									INSERT IN ARRAY:C227(<>tl_FamilleID; Size of array:C274(<>tl_FamilleID)+1)
									<>tl_FamilleID{Size of array:C274(<>tl_FamilleID)}:=[HeBerge:4]HB_ReferenceID:1
									INSERT IN ARRAY:C227(<>ta_FamilleClé; Size of array:C274(<>ta_FamilleClé)+1)
									<>ta_FamilleClé{Size of array:C274(<>ta_FamilleClé)}:=[HeBerge:4]HB_Clé:2
									INSERT IN ARRAY:C227(<>ta_FamilleEtCv; Size of array:C274(<>ta_FamilleEtCv)+1)
									<>ta_FamilleEtCv{Size of array:C274(<>ta_FamilleEtCv)}:=va_IDT_Typ1
									<>va_RéserveAction:="Redessiner"
									POST OUTSIDE CALL:C329(<>PR_AppelRéserve)
									va_IDT_Typ1:=""
									REDRAW:C174(va_IDT_Typ1)
									If (<>PR_HébergementMul#0)
										<>va_RéserveAction:="Redessiner"
										POST OUTSIDE CALL:C329(<>PR_HébergementMul)
									End if 
									//Sinon 
									//Uut_Alerte ("Type d'etat civil obligatoire !")
								End if 
							End if 
						End if 
					End if 
				End if 
				
			: ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>257) & (vl_SourisY<325))
				//Liste des situations
				If ([HeberGement:5]HG_ReferenceID:1>0)
					If (<>vb_T_ModeCHRS)
						$vb_OK2:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
					Else 
						$vb_OK2:=True:C214
					End if 
					If ($vb_OK2)
						$vaUn:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))
						//Permanencier
						$vb_OK:=False:C215
						If (Size of array:C274(<>ta_InPerm)>0)
							For ($ii; 1; Size of array:C274(<>ta_InPerm))
								If (<>ta_InPerm{$ii}=[HeberGement:5]HG_Permanencier:9)
									$vb_OK:=True:C214
								End if 
							End for 
						End if 
						If (<>vb_UserLOFT)
							If ($vaUn="N") & ($vb_OK)
								Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "G"; [HeberGement:5]HG_FicheNuméro:3)
							Else 
								StrAlerte(27; "")
							End if 
						Else 
							Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "G"; [HeberGement:5]HG_FicheNuméro:3)
						End if 
					Else 
						StrAlerte(6; "")
					End if 
				End if 
		End case 
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		If (<>va_Trans_Cle>"")
			va_IDT_Nom:=<>va_Trans_Nom
			va_IDT_Pré:=<>va_Trans_Prenom
			vd_IDT_NéLe:=<>vd_Trans_Nele
			ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
			va_IDT_Typ1:=<>va_Trans_EtCv
			REDUCE SELECTION:C351([HeBerge:4]; 0)
			P_HébergementHBClic(0; 1)
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>va_Trans_Cle)
			If (Records in selection:C76([HeBerge:4])=1)
				P_HébergementHBClic([HeBerge:4]HB_ReferenceID:1; 1)
			End if 
			va_IDT_TypTrans:=<>va_Trans_EtCv
			<>va_Trans_Cle:=""
		Else 
			If (<>va_RéserveAction="")
				OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*0)+("Montrer les rés. multiples"*1))
			End if 
		End if 
End case 