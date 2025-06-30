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
		//   CHOIX VISIBLE(b_ta_EtatCivil;vb_EtatCivil)
		//  CHOIX VISIBLE(va_IDT_Typ1;vb_EtatCivil)
		//  CHOIX VISIBLE(*;"Lib_EtatCivil";vb_EtatCivil)
		// CHOIX VISIBLE(*;"i_EtatCivil";vb_EtatCivil)
		
	: ($vl_Event=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>6) & (vl_SourisX<481)) & ((vl_SourisY>228) & (vl_SourisY<454))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				P_HébergementNotesBt(1)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
				va_NNN:=F_AfficheCléHébergé
			Else 
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				va_NNN:=""
				P_HébergementNotesBt(0)
			End if 
			vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
			FIRST RECORD:C50([HeberGement:5])
		End if 
		
	: ($vl_Event=Sur double clic:K2:5)
		If ((vl_SourisX>6) & (vl_SourisX<481)) & ((vl_SourisY>228) & (vl_SourisY<454))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				If (vb_EtatCivil)
					If (va_IDT_Typ1>"")
						vb_Sel_CleUnique:=True:C214
						vl_Sel_CleUnique:=[HeBerge:4]HB_ReferenceID:1
						CANCEL:C270
					Else 
						StrAlerte(30; "")
					End if 
				Else 
					vb_Sel_CleUnique:=True:C214
					vl_Sel_CleUnique:=[HeBerge:4]HB_ReferenceID:1
					CANCEL:C270
				End if 
				
			End if 
		End if 
End case 