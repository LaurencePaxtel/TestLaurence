//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbCentresDASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Voir : P_CalcStat_NbCentres
//{==================================================}
//L'Hébergement
C_LONGINT:C283($vl_TailTab; $Pos; $ii; $vl_Position1)
C_TEXT:C284($va_Critere)
vl_CT_SHom:=0
vl_CT_CHom:=0
vl_CT_EHom:=0
vl_CT_FHom:=0

vl_CT_SFem:=0
vl_CT_CFem:=0
vl_CT_EFem:=0
vl_CT_FFem:=0

vl_CT_PMin:=0
vl_CT_MMin:=0

vl_CT_Total:=0

vl_CT_Dis:=0

vl_CT_Rest:=0
$vl_TailTab:=Size of array:C274(ta_Centre)
If ($vl_TailTab>0)
	
	USE SET:C118("E_HGStatClôt")
	If (Records in selection:C76([HeberGement:5])>0)
		FIRST RECORD:C50([HeberGement:5])
		Repeat 
			$Pos:=Find in array:C230(t_CT_ID; [HeberGement:5]HG_LC_ID:61)
			If ($Pos>0)
				
				$va_Critere:=Substring:C12([HeberGement:5]HG_EtatCivil:20; Length:C16([HeberGement:5]HG_EtatCivil:20)-3; 4)  //Ancien
				$va_Critere:=""
				
				$vl_Position1:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
				//$vl_Position2:=Position(")";[HeberGement]HG_EtatCivil)
				If ($vl_Position1>0)
					$va_Critere:=Substring:C12([HeberGement:5]HG_EtatCivil:20; $vl_Position1; 3)
					$va_Critere:=$va_Critere+")"
				End if 
				
				
				Case of 
					: ($va_Critere="(HS)")  //"Homme seul")
						t_CT_SHom{$Pos}:=t_CT_SHom{$Pos}+1
					: ($va_Critere="(HC)")  //"Homme en couple")
						t_CT_CHom{$Pos}:=t_CT_CHom{$Pos}+1
					: ($va_Critere="(HE)")  //"Homme avec enfants"
						t_CT_EHom{$Pos}:=t_CT_EHom{$Pos}+1
						
					: ($va_Critere="(HF)")  //"Homme en famille")
						t_CT_FHom{$Pos}:=t_CT_FHom{$Pos}+1
					: ($va_Critere="(FS)")  //"Femme seule")
						t_CT_SFem{$Pos}:=t_CT_SFem{$Pos}+1
					: ($va_Critere="(FC)")  //"Femme en couple")
						t_CT_CFem{$Pos}:=t_CT_CFem{$Pos}+1
					: ($va_Critere="(FE)")  //"Femme avec enfants")
						t_CT_EFem{$Pos}:=t_CT_EFem{$Pos}+1
					: ($va_Critere="(FF)")  //"Femme en famille")
						t_CT_FFem{$Pos}:=t_CT_FFem{$Pos}+1
						
					: ($va_Critere="(HP)")  //"Majeur avec parents")
						t_CT_PMin{$Pos}:=t_CT_PMin{$Pos}+1
					: ($va_Critere="(FP)")  //"Majeur avec parents")
						t_CT_PMin{$Pos}:=t_CT_PMin{$Pos}+1
						
					: ($va_Critere="(HM)")  //"Mineur")
						t_CT_MMin{$Pos}:=t_CT_MMin{$Pos}+1
					: ($va_Critere="(FM)")  //"Mineur")
						t_CT_MMin{$Pos}:=t_CT_MMin{$Pos}+1
				End case 
				
			End if 
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]))
		
	End if 
	
	USE SET:C118("E_CLCourant")
	If (Records in selection:C76([CentresLits:16])>0)
		FIRST RECORD:C50([CentresLits:16])
		Repeat 
			$Pos:=Find in array:C230(t_CT_ID; [CentresLits:16]CL_LC_ID:2)
			If ($Pos>0)
				If ([CentresLits:16]CL_Type:8="J")
				Else 
					t_CT_Rest{$Pos}:=t_CT_Rest{$Pos}+[CentresLits:16]CL_Restant:7
					vl_CT_Rest:=vl_CT_Rest+[CentresLits:16]CL_Restant:7
				End if 
			End if 
			NEXT RECORD:C51([CentresLits:16])
		Until (End selection:C36([CentresLits:16]))
	End if 
	
	For ($ii; 1; $vl_TailTab)
		t_CT_Total{$ii}:=t_CT_SHom{$ii}+t_CT_CHom{$ii}+t_CT_EHom{$ii}+t_CT_FHom{$ii}+t_CT_SFem{$ii}+t_CT_CFem{$ii}+t_CT_EFem{$ii}+t_CT_FFem{$ii}+t_CT_PMin{$ii}+t_CT_MMin{$ii}
		vl_CT_SHom:=vl_CT_SHom+t_CT_SHom{$ii}
		vl_CT_CHom:=vl_CT_CHom+t_CT_CHom{$ii}
		vl_CT_EHom:=vl_CT_EHom+t_CT_EHom{$ii}
		vl_CT_FHom:=vl_CT_FHom+t_CT_FHom{$ii}
		
		vl_CT_SFem:=vl_CT_SFem+t_CT_SFem{$ii}
		vl_CT_CFem:=vl_CT_CFem+t_CT_CFem{$ii}
		vl_CT_EFem:=vl_CT_EFem+t_CT_EFem{$ii}
		vl_CT_FFem:=vl_CT_FFem+t_CT_FFem{$ii}
		
		vl_CT_PMin:=vl_CT_PMin+t_CT_PMin{$ii}
		vl_CT_MMin:=vl_CT_MMin+t_CT_MMin{$ii}
		
		vl_CT_Total:=vl_CT_Total+t_CT_Total{$ii}
		//Changement de calcul
		t_CT_Dis{$ii}:=t_CT_Total{$ii}+t_CT_Rest{$ii}
		vl_CT_Dis:=vl_CT_Dis+t_CT_Dis{$ii}
	End for 
	vl_lit_Dist:=vl_CT_Total
	vl_lit_Rest:=vl_CT_Rest
	vl_lit_At:=vl_CT_Total+vl_CT_Rest
	If (vl_lit_At>0)
		vr_lit_Pc:=(vl_lit_Dist/vl_lit_At)*100
	Else 
		vr_lit_Pc:=0
	End if 
End if 