//%attributes = {}
$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
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
		
		va_GPmembres:="Membres du groupe"
		va_GPLib:=""
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		
		If ((vl_SourisX>6) & (vl_SourisX<267)) & ((vl_SourisY>298) & (vl_SourisY<389))
			
			If ([GrouPe:36]GP_ReferenceID:1>0)
				P_Tab_GP(3; 0)
			Else 
				P_Tab_GP(1; 0)
			End if 
			
		End if 
		
		//Membre du groupe Groupe   
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>298) & (vl_SourisY<389))
			
		End if 
		
		//DEMANDEUR    
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>53) & (vl_SourisY<237))
			
			If ([HeBerge:4]HB_ReferenceID:1>0)
				
				If (Macintosh control down:C544) | (Windows Ctrl down:C562)
					<>vt_Trans:=[HeBerge:4]HB_Clé:2
					
					If (<>PR_AppelMem#0)
						POST OUTSIDE CALL:C329(<>PR_AppelMem)
					Else 
						QUERY:C277([MemO:30]; [MemO:30]MO_UserID:1=<>vl_UserRéfU)
						MultiSoc_Filter(->[MemO:30])
						
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
		
		If ((vl_SourisX>6) & (vl_SourisX<267)) & ((vl_SourisY>298) & (vl_SourisY<389))
			
			If ([GrouPe:36]GP_ReferenceID:1>0)
				CREATE SET:C116([GrouPe:36]; "$E_temp")
				READ WRITE:C146([GrouPe:36])
				
				If (i_NonVerrou(->[GrouPe:36]))
					FORM SET INPUT:C55([GrouPe:36]; "GP_EcranSaisie")
					$vl_Fenetre:=i_FenêtreNo(519; 158; 4; "Groupe : modifier"; 4; "")
					
					MODIFY RECORD:C57([GrouPe:36]; *)
					CLOSE WINDOW:C154($vl_Fenetre)
					
					UNLOAD RECORD:C212([GrouPe:36])
				End if 
				
				READ ONLY:C145([GrouPe:36])
				
				USE SET:C118("$E_temp")
				CLEAR SET:C117("$E_temp")
				
				vL_Nb_GP:=1
				
				ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
				FIRST RECORD:C50([GrouPe:36])
				
				P_Tab_GP(2; 0)
			Else 
				P_Tab_GP(1; 0)
			End if 
			
		End if 
		
		//Membre du groupe Groupe   
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>298) & (vl_SourisY<389))
			
			If ([GroupeHeberges:37]GH_ReferenceID:1>0)
				
				If (i_Confirmer("Supprimer "+String:C10([GroupeHeberges:37]GH_ReferenceID:1)+" du groupe : "+[GrouPe:36]GP_Intitulé:4))
					READ WRITE:C146([GroupeHeberges:37])
					
					If (i_NonVerrou(->[GroupeHeberges:37]))
						DELETE RECORD:C58([GroupeHeberges:37])
						UNLOAD RECORD:C212([GroupeHeberges:37])
					End if 
					
					READ ONLY:C145([GroupeHeberges:37])
					P_Tab_GP(3; 0)
					
				End if 
				
			End if 
			
		End if 
		
		//DEMANDEUR       
		If ((vl_SourisX>290) & (vl_SourisX<764)) & ((vl_SourisY>53) & (vl_SourisY<237))
			
			If ([HeBerge:4]HB_ReferenceID:1>0)
				
				If (Macintosh option down:C545) | (Windows Alt down:C563)
					
					If ([GrouPe:36]GP_ReferenceID:1>0)
						CREATE SET:C116([GroupeHeberges:37]; "$E_temp")
						READ WRITE:C146([GroupeHeberges:37])
						
						CREATE RECORD:C68([GroupeHeberges:37])
						MultiSoc_Init_Structure(->[GroupeHeberges:37])
						
						[GroupeHeberges:37]GH_ReferenceID:1:=Uut_Numerote(->[GroupeHeberges:37])
						[GroupeHeberges:37]GH_GP_Référence:2:=[GrouPe:36]GP_ReferenceID:1
						[GroupeHeberges:37]GH_HB_Référence:3:=[HeBerge:4]HB_ReferenceID:1
						[GroupeHeberges:37]GH_HB_Clé:4:=[HeBerge:4]HB_Clé:2
						SAVE RECORD:C53([GroupeHeberges:37])
						UNLOAD RECORD:C212([GroupeHeberges:37])
						
						READ ONLY:C145([GroupeHeberges:37])
						
						QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
						MultiSoc_Filter(->[GroupeHeberges:37])
						
						vL_Nb_GH:=Records in selection:C76([GroupeHeberges:37])
						
						ORDER BY:C49([GroupeHeberges:37]; [HeBerge:4]HB_Clé:2; >)
						FIRST RECORD:C50([GroupeHeberges:37])
						
						va_GPmembres:="Membres du groupe '"+[GrouPe:36]GP_Intitulé:4+"' : "+String:C10(vL_Nb_GH)
					End if 
					
				Else 
					
					If (wresMulti=1)
						$pos:=Find in array:C230(<>tl_FamilleID; [HeBerge:4]HB_ReferenceID:1)
						
						If ($pos<=0)
							
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
									End if   //  Si (◊PR_HébergementMul#0)
									
								End if   //Si (va_IDT_Typ1>"")
								
							End if   //  Si (F_HébergementCtrlCréation (va_JourNuit))
							
						End if   //   Si ($pos>0)
						
					End if   //   Si (wresMulti=1)
					
				End if   //Si (Macintosh option enfoncee) | (Windows Alt enfoncee)
				
			End if 
			
		End if 
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		
		If (<>va_RéserveAction="")
			OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*0)+("Montrer les rés. multiples"*1))
		End if 
		
End case 