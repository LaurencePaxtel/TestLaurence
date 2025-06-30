$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		
		[DiaLogues:3]DL_Date:2:=Vd_DateDuJ
		
		Rec_TransFamille(0; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
		
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>120) & (vl_SourisY<282))
			If ([HeberGement:5]HG_ReferenceID:1>0)
				OBJECT SET ENABLED:C1123(b_VoirNotes; True:C214)
				OBJECT SET ENABLED:C1123(b_VoirSP; True:C214)
				
				OBJECT SET ENABLED:C1123(b_DSOui; True:C214)
				OBJECT SET ENABLED:C1123(b_DSNon; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
				OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
				OBJECT SET ENABLED:C1123(b_DSOui; False:C215)
				OBJECT SET ENABLED:C1123(b_DSNon; False:C215)
			End if 
		End if 
End case 