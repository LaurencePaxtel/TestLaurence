//Formule Format : DL_Correction
C_LONGINT:C283($vl_EventFF)
C_BOOLEAN:C305($vb_OK)
C_TIME:C306($vh_HEURE)

$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=Current date:C33(*)
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		[DiaLogues:3]DL_LibelléN:9:=""
		[DiaLogues:3]DL_LibelléG:10:=""
		
		
		r1:=1
		r2:=0
		r3:=0
		r4:=0
		r5:=0
		r6:=0
		r7:=0
		r8:=0
		sOr1:=0
		tLocal:=0
		rDernièreF:=0
		
		OBJECT SET VISIBLE:C603(*; "LeRadioSP"; False:C215)  //r7
		
		If (<>vb_T_ModeCHRS=True:C214)
			rJourNuit1:=1  //Jour
			rJourNuit2:=0  //Nuit
			JourNuit1:=1  //Jour
			JourNuit2:=0  //Nuit
			
			OBJECT SET VISIBLE:C603(*; "115_Jour"; False:C215)
			OBJECT SET VISIBLE:C603(*; "115_Nuit"; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "CHRS_Jour"; True:C214)
			OBJECT SET VISIBLE:C603(*; "CHRS_Nuit"; True:C214)
			
			OBJECT SET VISIBLE:C603(*; "Maraude_CHRS"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Maraude_115"; False:C215)
			wSansFiltre:=1
		Else 
			rJourNuit1:=1  //Jour
			rJourNuit2:=1  //Nuit
			JourNuit1:=0  //Jour
			JourNuit2:=0  //Nuit
			OBJECT SET VISIBLE:C603(*; "115_Jour"; True:C214)
			OBJECT SET VISIBLE:C603(*; "115_Nuit"; True:C214)
			
			OBJECT SET VISIBLE:C603(*; "CHRS_Jour"; False:C215)
			OBJECT SET VISIBLE:C603(*; "CHRS_Nuit"; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "Maraude_115"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Maraude_CHRS"; False:C215)
			wSansFiltre:=0
		End if 
		
		$vh_HEURE:=Current time:C178
		If (<>vb_ParamDisActivée) & (((<>vb_ParamDisJour) & (<>vb_ParamDisNuit=False:C215)) | ((<>vb_ParamDisJour=False:C215) & (<>vb_ParamDisNuit=True:C214)))
			rJourNuit1:=Num:C11(<>vb_ParamDisJour)
			rJourNuit2:=Num:C11(<>vb_ParamDisNuit)
		Else 
			If (<>vb_CentreEXC)
				rJourNuit1:=1
				rJourNuit2:=0
			Else 
				rJourNuit1:=Num:C11(($vh_HeurC>=?08:00:00?) & ($vh_HeurC<=?19:59:59?))  //Jour
				rJourNuit2:=Num:C11(rJourNuit1=0)  //Nuit
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603(wSansFiltre; User in group:C338(Current user:C182; <>Groupe_SansFiltre))
		
		rReports:=1
		rDoublons:=0
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		P_HébergementVeilleFind
		
		OBJECT SET ENABLED:C1123(b_RecNomClé; False:C215)
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
		Case of 
			: (Modified:C32([DiaLogues:3]DL_Libellé:3))
				POST OUTSIDE CALL:C329(<>PR_HBNotesV)
				P_HébergementVeilleFind
			: (Modified:C32([DiaLogues:3]DL_LibelAutre:5))
				POST OUTSIDE CALL:C329(<>PR_HBNotesV)
				P_HébergementVeilleFind
			: (Modified:C32([DiaLogues:3]DL_LibelPlus:6))
				P_HébergementVeilleFind
		End case 
		
		
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		$vb_OK:=((vl_SourisX>7) & (vl_SourisX<854)) & ((vl_SourisY>196) & (vl_SourisY<551))
		If ($vb_OK)
			If ([HeberGement:5]HG_ReferenceID:1>0)
				OBJECT SET ENABLED:C1123(b_RecNomClé; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_RecNomClé; False:C215)
			End if 
		End if 
		
		
End case 