$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_NJ:=""
		r1:=1
		r2:=1
		vb_passe1:=False:C215
		vL_RéfHBOld:=0
		va_Identité:=""
		vL_Nb_HG_F:=0
		vl_RéfU_HB:=0
		OBJECT SET ENABLED:C1123(r1; False:C215)
		OBJECT SET ENABLED:C1123(r2; False:C215)
		P_HébergementNotesBt(0)
		OBJECT SET ENABLED:C1123(b_PrestNew; False:C215)
		OBJECT SET ENABLED:C1123(b_PrestMod; False:C215)
		OBJECT SET ENABLED:C1123(b_PrestSup; False:C215)
		OBJECT SET ENABLED:C1123(b_PrestImp; False:C215)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		va_IDT_CléFam:=""
		va_FrappeClavier:=""
		
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>290) & (vl_SourisX<607)) & ((vl_SourisY>53) & (vl_SourisY<231))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
				va_Identité:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4+" "+String:C10([HeBerge:4]HB_DateNéLe:5; 7)
			Else 
				vl_RéfU_HB:=0
				va_Identité:=""
			End if 
			P_HébergementRGFind(vl_RéfU_HB)
		End if 
		If ((vl_SourisX>7) & (vl_SourisX<608)) & ((vl_SourisY>290) & (vl_SourisY<470))
			If ([RenseiGnements:20]RG_RéférenceID:1>0)
				OBJECT SET ENABLED:C1123(b_PrestMod; True:C214)
				OBJECT SET ENABLED:C1123(b_PrestSup; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_PrestMod; False:C215)
				OBJECT SET ENABLED:C1123(b_PrestSup; False:C215)
			End if 
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<608)) & ((vl_SourisY>290) & (vl_SourisY<470))
			If ([RenseiGnements:20]RG_RéférenceID:1>0)
				If ([HeBerge:4]HB_ReferenceID:1=[RenseiGnements:20]RG_HB_ID:2)
					vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
					<>Vl_RefUfich:=[RenseiGnements:20]RG_RéférenceID:1
					READ WRITE:C146([RenseiGnements:20])
					If (i_NonVerrou(->[RenseiGnements:20]))
						FORM SET INPUT:C55([RenseiGnements:20]; "RG_EcranSaisie")
						$vl_Fenetre:=i_FenêtreNo(632; 241; 4; va_Identité+" : "+"Fiche demande : modifier"; 1; "")
						MODIFY RECORD:C57([RenseiGnements:20]; *)
						UNLOAD RECORD:C212([RenseiGnements:20])
						CLOSE WINDOW:C154($vl_Fenetre)
					End if 
					READ ONLY:C145([RenseiGnements:20])
				Else 
					ALERT:C41("Veuillez sélectionner une ligne dans liste et prestations !")
				End if 
			Else 
				StrAlerte(18; "")
			End if 
		End if 
End case 