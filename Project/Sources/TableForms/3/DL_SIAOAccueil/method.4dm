C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		vL_Nb_HB_F:=0
		va_FrappeClavier:=""
		va_FrappeClavierP:=""
		va_FrappeClavierD:=""
		P_HébergementNotesBt(0)
		FORM GOTO PAGE:C247(2)
		P_SIAO_Action(1)
		
	: ($vl_Event=Sur clic:K2:4)
		
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>495) & (vl_SourisX<999)) & ((vl_SourisY>266) & (vl_SourisY<463))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				vb_Sel_CleUnique:=True:C214
				vl_Sel_CleUnique:=[HeBerge:4]HB_ReferenceID:1
				P_HébergementNotesBt(1)
				//  ACTIVER BOUTON(b_SIAO_Demi)
				//ACTIVER BOUTON(b_SIAO_Demf)
				//ACTIVER BOUTON(b_SIAO_Demg)
				
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[HeberGement:5])
				va_NNN:=F_AfficheCléHébergé
			Else 
				vb_Sel_CleUnique:=False:C215
				vl_Sel_CleUnique:=0
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				va_NNN:=""
				P_HébergementNotesBt(0)
				//  INACTIVER BOUTON(b_SIAO_Demi)
				//INACTIVER BOUTON(b_SIAO_Demf)
				//INACTIVER BOUTON(b_SIAO_Demg)
			End if 
			vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; [HeberGement:5]HG_HeureAppel:5; <)
			// ORDER BY([HeberGement];[HeberGement]HG_HeureAppel;<) fixer 15/6/16 BS
			//FIRST RECORD([HeberGement])
		End if 
		
	: ($vl_Event=Sur double clic:K2:5)
		
		If ((vl_SourisX>495) & (vl_SourisX<999)) & ((vl_SourisY>266) & (vl_SourisY<463))
			P_SIAO_New  // (O) 15/6/16
			
			If (7=8)
				If ([HeBerge:4]HB_ReferenceID:1>0)
					If (va_IDT_Typ1>"")
						vb_Sel_CleUnique:=True:C214
						vl_Sel_CleUnique:=[HeBerge:4]HB_ReferenceID:1
						//vl_SIAO_Action
						//vl_SIAO_Referent
						Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; vl_Sel_CleUnique; "X"; vl_SIAO_Action; vl_SIAO_Referent; va_IDT_Typ1)
					Else 
						StrAlerte(30; "")
						//REFUSER    
					End if 
					va_IDT_Typ1:=""
					// NE PAS VALIDER
				End if 
			End if 
			
		End if 
End case 