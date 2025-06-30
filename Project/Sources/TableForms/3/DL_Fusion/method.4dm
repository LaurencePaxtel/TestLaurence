$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
		OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
		OBJECT SET ENABLED:C1123(b_SUPCléHG; False:C215)
		OBJECT SET ENABLED:C1123(b_Fuse; False:C215)
		OBJECT SET ENABLED:C1123(b_SelCléM; False:C215)
		OBJECT SET ENABLED:C1123(b_SelCléF; False:C215)
		
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>6) & (vl_SourisX<764)) & ((vl_SourisY>137) & (vl_SourisY<475))
			If ([HeBerge:4]HB_ReferenceID:1>0)
				OBJECT SET ENABLED:C1123(b_VoirNotes; True:C214)
				OBJECT SET ENABLED:C1123(b_VoirSP; True:C214)
				OBJECT SET ENABLED:C1123(b_ModCléHG; True:C214)
				OBJECT SET ENABLED:C1123(b_SUPCléHG; True:C214)
				OBJECT SET ENABLED:C1123(b_SelCléM; True:C214)
				OBJECT SET ENABLED:C1123(b_SelCléF; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
				OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
				OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
				OBJECT SET ENABLED:C1123(b_SUPCléHG; False:C215)
				OBJECT SET ENABLED:C1123(b_SelCléM; False:C215)
				OBJECT SET ENABLED:C1123(b_SelCléF; False:C215)
			End if 
		End if 
End case 
