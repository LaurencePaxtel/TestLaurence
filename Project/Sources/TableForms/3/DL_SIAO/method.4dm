
C_BOOLEAN:C305($vb_OK)

C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=[DiaLogues:3]DL_Date:2
		ve_Date_Cas:=0
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		[DiaLogues:3]DL_LibelléN:9:=""
		[DiaLogues:3]DL_LibelléG:10:=""
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		rAn1:=1
		rAn2:=1
		trans1:=1
		trans2:=1
		Dem1:=1
		Dem2:=1
		Dem3:=1
		Ferm1:=0
		
		vl_SIAO_RefAttestation:=0
		
		P_SIAO_Find
		OBJECT SET VISIBLE:C603(b_ColProposition; False:C215)
		
	: ($vl_Event=Sur données modifiées:K2:15)
		
		Case of 
			: (Modified:C32([DiaLogues:3]DL_Libellé:3))
				POST OUTSIDE CALL:C329(<>PR_HBNotesSIAO)
				P_SIAO_Find
			: (Modified:C32([DiaLogues:3]DL_LibelléN:9))
				POST OUTSIDE CALL:C329(<>PR_HBNotesSIAO)
				P_SIAO_Find
		End case 
		
	: ($vl_Event=Sur clic:K2:4)
		
		$vb_OK:=False:C215
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If (FORM Get current page:C276=1)
			$vb_OK:=((vl_SourisX>7) & (vl_SourisX<1003)) & ((vl_SourisY>126) & (vl_SourisY<671))
		End if 
		If ($vb_OK)
			If ([SIAO:50]Si_RéférenceID:1>0)
				vl_SIAO_RefAttestation:=[SIAO:50]Si_RéférenceID:1
			Else 
				vl_SIAO_RefAttestation:=0
			End if 
			If ([SIAO:50]Si_Demandeur_ID:21>0)
				
				OBJECT SET ENABLED:C1123(b_VoirNotes; True:C214)
				OBJECT SET ENABLED:C1123(b_VoirSP; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
				OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
			End if 
		End if 
		
	: ($vl_Event=Sur double clic:K2:5)
		
		$vb_OK:=False:C215
		If (FORM Get current page:C276=1)
			$vb_OK:=((vl_SourisX>7) & (vl_SourisX<1003)) & ((vl_SourisY>156) & (vl_SourisY<671))
		End if 
		If ($vb_OK)
			$vb_OK:=False:C215
			If ([SIAO:50]Si_RéférenceID:1>0)
				vl_SIAO_RefAttestation:=[SIAO:50]Si_RéférenceID:1
				Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; [SIAO:50]Si_RéférenceID:1; "M"; 0; 0; "")
				
			Else 
				vl_SIAO_RefAttestation:=0
				StrAlerte(6; "")
			End if 
		End if 
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		P_SIAO_Find
End case 