//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Coordinateur
//{
//{          Lundi 26 janvier 2004 à 16:45:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($T_File)
C_LONGINT:C283($L_Tick; $L_ref; $TailleTab; $ij; $ii)
C_BOOLEAN:C305($B_Log)
C_DATE:C307($Dtx)
C_OBJECT:C1216($O_Progression; $O_Objet)

If (vd_Date1>!00-00-00!)
	$T_File:="debug_"+Current method name:C684+"_.txt"
	Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
	
	If (vd_Date1>vd_Date2)
		$Dtx:=vd_Date2
		
		vd_Date2:=vd_Date1
		vd_Date1:=$Dtx
	End if 
	
	MESSAGES OFF:C175
	i_Stop
	
	ON EVENT CALL:C190("i_Stop_ESC")
	
	$L_Tick:=Milliseconds:C459
	$L_ref:=4D_Progression_Open("")
	
	//1
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Statistiques : Répartition par Etats civils"; \
		"progress message"; "Calcul en cours  1/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2); \
		"progress compteur"; -1; \
		"progress max"; -1; \
		"progress stop"; -1\
		)
	4D_Progression_Send(->$O_Progression)
	
	V_Stat_Coordinateur(1)
	Log_mensuel($B_Log; "Etape 1: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	
	//Nombre de lits
	If (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		
		P_CalcStat_NbLits
		Log_mensuel($B_Log; "Etape 1-1: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	//2
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  2/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours  2/5: Nombre d'appels")
	//Nombre d'appels
	If (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		
		P_CalcStat_NbAppels
		Log_mensuel($B_Log; "Etape 2: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	//3
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  3/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours 3/5: Centres d'hébergement")
	//L'Hébergement
	If (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		
		If (True:C214)
			OB SET:C1220($O_Objet; "vl_CT_Abs"; vl_CT_Abs)
			OB SET:C1220($O_Objet; "vl_CT_DisJ"; vl_CT_DisJ)
			OB SET:C1220($O_Objet; "vl_CT_Rest"; vl_CT_Rest)
			
			OB SET:C1220($O_Objet; "rJourNuit1"; rJourNuit1)
			OB SET:C1220($O_Objet; "rJourNuit2"; rJourNuit2)
			OB SET:C1220($O_Objet; "vl_CT_Abs"; vl_CT_Abs)
			OB SET:C1220($O_Objet; "vl_CT_Capa"; vl_CT_Capa)
			OB SET:C1220($O_Objet; "vl_CT_CFem"; vl_CT_CFem)
			OB SET:C1220($O_Objet; "vl_CT_CHom"; vl_CT_CHom)
			OB SET:C1220($O_Objet; "vl_CT_Dis"; vl_CT_Dis)
			OB SET:C1220($O_Objet; "vl_CT_DisJ"; vl_CT_DisJ)
			OB SET:C1220($O_Objet; "vl_CT_DistA"; vl_CT_DistA)
			OB SET:C1220($O_Objet; "vl_CT_EFem"; vl_CT_EFem)
			OB SET:C1220($O_Objet; "vl_CT_EHom"; vl_CT_EHom)
			OB SET:C1220($O_Objet; "vl_CT_FFem"; vl_CT_FFem)
			OB SET:C1220($O_Objet; "vl_CT_FHom"; vl_CT_FHom)
			OB SET:C1220($O_Objet; "vl_CT_Lat"; vl_CT_Lat)
			OB SET:C1220($O_Objet; "vl_CT_MMin"; vl_CT_MMin)
			OB SET:C1220($O_Objet; "vl_CT_PMin"; vl_CT_PMin)
			OB SET:C1220($O_Objet; "vl_CT_Rest"; vl_CT_Rest)
			OB SET:C1220($O_Objet; "vl_CT_SFem"; vl_CT_SFem)
			OB SET:C1220($O_Objet; "vl_CT_SGas"; vl_CT_SGas)
			OB SET:C1220($O_Objet; "vl_CT_SGmd"; vl_CT_SGmd)
			OB SET:C1220($O_Objet; "vl_CT_SGrép"; vl_CT_SGrép)
			OB SET:C1220($O_Objet; "vl_CT_SHom"; vl_CT_SHom)
			OB SET:C1220($O_Objet; "vl_CT_Total"; vl_CT_Total)
			
			OB SET ARRAY:C1227($O_Objet; "t_CT_Abs"; t_CT_Abs)
			OB SET ARRAY:C1227($O_Objet; "t_CT_CFem"; t_CT_CFem)
			OB SET ARRAY:C1227($O_Objet; "t_CT_CHom"; t_CT_CHom)
			OB SET ARRAY:C1227($O_Objet; "t_CT_Dis"; t_CT_Dis)
			OB SET ARRAY:C1227($O_Objet; "t_CT_DisJ"; t_CT_DisJ)
			OB SET ARRAY:C1227($O_Objet; "t_CT_DistA"; t_CT_DistA)
			OB SET ARRAY:C1227($O_Objet; "t_CT_EFem"; t_CT_EFem)
			OB SET ARRAY:C1227($O_Objet; "t_CT_EHom"; t_CT_EHom)
			OB SET ARRAY:C1227($O_Objet; "t_CT_FFem"; t_CT_FFem)
			OB SET ARRAY:C1227($O_Objet; "t_CT_FHom"; t_CT_FHom)
			OB SET ARRAY:C1227($O_Objet; "t_CT_ID"; t_CT_ID)
			OB SET ARRAY:C1227($O_Objet; "t_CT_Lat"; t_CT_Lat)
			OB SET ARRAY:C1227($O_Objet; "t_CT_MMin"; t_CT_MMin)
			OB SET ARRAY:C1227($O_Objet; "t_CT_PMin"; t_CT_PMin)
			OB SET ARRAY:C1227($O_Objet; "t_CT_Rest"; t_CT_Rest)
			OB SET ARRAY:C1227($O_Objet; "t_CT_SFem"; t_CT_SFem)
			OB SET ARRAY:C1227($O_Objet; "t_CT_SGas"; t_CT_SGas)
			OB SET ARRAY:C1227($O_Objet; "t_CT_SGmd"; t_CT_SGmd)
			OB SET ARRAY:C1227($O_Objet; "t_CT_SGrép"; t_CT_SGrép)
			OB SET ARRAY:C1227($O_Objet; "t_CT_SHom"; t_CT_SHom)
			OB SET ARRAY:C1227($O_Objet; "t_CT_Total"; t_CT_Total)
			OB SET ARRAY:C1227($O_Objet; "ta_Centre"; ta_Centre)
			OB SET ARRAY:C1227($O_Objet; "te_Centre"; te_Centre)
		End if 
		
		P_CalcStat_NbCentresC(->$O_Objet)
		
		If (True:C214)
			vl_CT_Abs:=OB Get:C1224($O_Objet; "vl_CT_Abs"; Est un entier long:K8:6)
			vl_CT_DisJ:=OB Get:C1224($O_Objet; "vl_CT_DisJ"; Est un entier long:K8:6)
			vl_CT_Rest:=OB Get:C1224($O_Objet; "vl_CT_Rest"; Est un entier long:K8:6)
			
			rJourNuit1:=OB Get:C1224($O_Objet; "rJourNuit1"; Est un entier long:K8:6)
			rJourNuit2:=OB Get:C1224($O_Objet; "rJourNuit2"; Est un entier long:K8:6)
			vl_CT_Abs:=OB Get:C1224($O_Objet; "vl_CT_Abs"; Est un entier long:K8:6)
			vl_CT_Capa:=OB Get:C1224($O_Objet; "vl_CT_Capa"; Est un entier long:K8:6)
			vl_CT_CFem:=OB Get:C1224($O_Objet; "vl_CT_CFem"; Est un entier long:K8:6)
			vl_CT_CHom:=OB Get:C1224($O_Objet; "vl_CT_CHom"; Est un entier long:K8:6)
			vl_CT_Dis:=OB Get:C1224($O_Objet; "vl_CT_Dis"; Est un entier long:K8:6)
			vl_CT_DisJ:=OB Get:C1224($O_Objet; "vl_CT_DisJ"; Est un entier long:K8:6)
			vl_CT_DistA:=OB Get:C1224($O_Objet; "vl_CT_DistA"; Est un entier long:K8:6)
			vl_CT_EFem:=OB Get:C1224($O_Objet; "vl_CT_EFem"; Est un entier long:K8:6)
			vl_CT_EHom:=OB Get:C1224($O_Objet; "vl_CT_EHom"; Est un entier long:K8:6)
			vl_CT_FFem:=OB Get:C1224($O_Objet; "vl_CT_FFem"; Est un entier long:K8:6)
			vl_CT_FHom:=OB Get:C1224($O_Objet; "vl_CT_FHom"; Est un entier long:K8:6)
			vl_CT_Lat:=OB Get:C1224($O_Objet; "vl_CT_Lat"; Est un entier long:K8:6)
			vl_CT_MMin:=OB Get:C1224($O_Objet; "vl_CT_MMin"; Est un entier long:K8:6)
			vl_CT_PMin:=OB Get:C1224($O_Objet; "vl_CT_PMin"; Est un entier long:K8:6)
			vl_CT_Rest:=OB Get:C1224($O_Objet; "vl_CT_Rest"; Est un entier long:K8:6)
			vl_CT_SFem:=OB Get:C1224($O_Objet; "vl_CT_SFem"; Est un entier long:K8:6)
			vl_CT_SGas:=OB Get:C1224($O_Objet; "vl_CT_SGas"; Est un entier long:K8:6)
			vl_CT_SGmd:=OB Get:C1224($O_Objet; "vl_CT_SGmd"; Est un entier long:K8:6)
			vl_CT_SGrép:=OB Get:C1224($O_Objet; "vl_CT_SGrép"; Est un entier long:K8:6)
			vl_CT_SHom:=OB Get:C1224($O_Objet; "vl_CT_SHom"; Est un entier long:K8:6)
			vl_CT_Total:=OB Get:C1224($O_Objet; "vl_CT_Total"; Est un entier long:K8:6)
			
			OB GET ARRAY:C1229($O_Objet; "t_CT_Abs"; t_CT_Abs)
			OB GET ARRAY:C1229($O_Objet; "t_CT_CFem"; t_CT_CFem)
			OB GET ARRAY:C1229($O_Objet; "t_CT_CHom"; t_CT_CHom)
			OB GET ARRAY:C1229($O_Objet; "t_CT_Dis"; t_CT_Dis)
			OB GET ARRAY:C1229($O_Objet; "t_CT_DisJ"; t_CT_DisJ)
			OB GET ARRAY:C1229($O_Objet; "t_CT_DistA"; t_CT_DistA)
			OB GET ARRAY:C1229($O_Objet; "t_CT_EFem"; t_CT_EFem)
			OB GET ARRAY:C1229($O_Objet; "t_CT_EHom"; t_CT_EHom)
			OB GET ARRAY:C1229($O_Objet; "t_CT_FFem"; t_CT_FFem)
			OB GET ARRAY:C1229($O_Objet; "t_CT_FHom"; t_CT_FHom)
			OB GET ARRAY:C1229($O_Objet; "t_CT_ID"; t_CT_ID)
			OB GET ARRAY:C1229($O_Objet; "t_CT_Lat"; t_CT_Lat)
			OB GET ARRAY:C1229($O_Objet; "t_CT_MMin"; t_CT_MMin)
			OB GET ARRAY:C1229($O_Objet; "t_CT_PMin"; t_CT_PMin)
			OB GET ARRAY:C1229($O_Objet; "t_CT_Rest"; t_CT_Rest)
			OB GET ARRAY:C1229($O_Objet; "t_CT_SFem"; t_CT_SFem)
			OB GET ARRAY:C1229($O_Objet; "t_CT_SGas"; t_CT_SGas)
			OB GET ARRAY:C1229($O_Objet; "t_CT_SGmd"; t_CT_SGmd)
			OB GET ARRAY:C1229($O_Objet; "t_CT_SGrép"; t_CT_SGrép)
			OB GET ARRAY:C1229($O_Objet; "t_CT_SHom"; t_CT_SHom)
			OB GET ARRAY:C1229($O_Objet; "t_CT_Total"; t_CT_Total)
			OB GET ARRAY:C1229($O_Objet; "ta_Centre"; ta_Centre)
			OB GET ARRAY:C1229($O_Objet; "te_Centre"; te_Centre)
		End if 
		
		CLEAR VARIABLE:C89($O_Objet)
		
		Log_mensuel($B_Log; "Etape 3: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	$TailleTab:=Size of array:C274(te_Centre)
	
	If ($TailleTab>0)
		
		For ($ii; 1; $TailleTab)
			$ij:=$ij+te_Centre{$ii}
		End for 
		
		Case of 
			: ($ij=0)
				CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStat")
			: ($ij>0) & ($ij<$TailleTab)
				ARRAY LONGINT:C221(tl_NoUCentre; 0)
				
				For ($ii; 1; $TailleTab)
					
					If (te_Centre{$ii}=1)
						INSERT IN ARRAY:C227(tl_NoUCentre; Size of array:C274(tl_NoUCentre)+1)
						tl_NoUCentre{Size of array:C274(tl_NoUCentre)}:=t_CT_ID{$ii}
					End if 
					
				End for 
				
				If (Size of array:C274(tl_NoUCentre)>0)
					QUERY WITH ARRAY:C644([HeberGement:5]HG_LC_ID:61; tl_NoUCentre)
					
					If (Records in selection:C76([HeberGement:5])>0)
						CREATE SET:C116([HeberGement:5]; "E_xHGStat")
						INTERSECTION:C121("E_HGStat"; "E_xHGStat"; "E_HGStat")
					Else 
						CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStat")
					End if 
					
				Else 
					CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStat")
				End if 
				
			: ($ij=$TailleTab)
		End case 
		
	End if 
	
	//4
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  4/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	// i_MessageSeul ("Calcul en cours  4/5: Etat civil /signalement/Orientations")
	//EtatCivil/Signalement
	If (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		CLEAR VARIABLE:C89($O_Objet)
		
		If (True:C214)
			// tableaux non initialisés dans la méthode
			// 1
			OB SET ARRAY:C1227($O_Objet; "t_ET_DemPc"; t_ET_DemPc)
			OB SET ARRAY:C1227($O_Objet; "t_ET_DisPc"; t_ET_DisPc)
			OB SET ARRAY:C1227($O_Objet; "t_ET_MedPc"; t_ET_MedPc)
			
			OB SET:C1220($O_Objet; "vr_ET_DemPc"; vr_ET_DemPc)
			OB SET:C1220($O_Objet; "vr_ET_DisPc"; vr_ET_DisPc)
			OB SET:C1220($O_Objet; "vr_ET_MedPc"; vr_ET_MedPc)
			
			// 2
			OB SET ARRAY:C1227($O_Objet; "t_SG_DemPc"; t_SG_DemPc)
			OB SET:C1220($O_Objet; "vr_SG_DemPc"; vr_SG_DemPc)
			
			// 3
			OB SET ARRAY:C1227($O_Objet; "t_OR1_Pc"; t_OR1_Pc)
			OB SET:C1220($O_Objet; "vr_OR1_Pc"; vr_OR1_Pc)
			
			// 4
			OB SET ARRAY:C1227($O_Objet; "t_OR2_Pc"; t_OR2_Pc)
			OB SET:C1220($O_Objet; "vr_OR2_Pc"; vr_OR2_Pc)
			
			// 5
			OB SET ARRAY:C1227($O_Objet; "t_AtS_Pc"; t_AtS_Pc)
			OB SET:C1220($O_Objet; "vr_AtS_Pc"; vr_AtS_Pc)
			
			// tableau 1
			OB SET ARRAY:C1227($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)
			OB SET ARRAY:C1227($O_Objet; "t_ET_Dem"; t_ET_Dem)
			OB SET ARRAY:C1227($O_Objet; "t_ET_Dis"; t_ET_Dis)
			OB SET ARRAY:C1227($O_Objet; "t_ET_Med"; t_ET_Med)
			
			OB SET:C1220($O_Objet; "vl_ET_Dem"; vl_ET_Dem)
			OB SET:C1220($O_Objet; "vl_ET_Dis"; vl_ET_Dis)
			OB SET:C1220($O_Objet; "vl_ET_Med"; vl_ET_Med)
			
			// tableau 2
			OB SET ARRAY:C1227($O_Objet; "<>ta_TBSglt"; <>ta_TBSglt)
			OB SET ARRAY:C1227($O_Objet; "t_SG_Dem"; t_SG_Dem)
			OB SET:C1220($O_Objet; "vl_SG_Dem"; vl_SG_Dem)
			
			// tableau 3
			OB SET ARRAY:C1227($O_Objet; "<>ta_TBOr1"; <>ta_TBOr1)
			OB SET ARRAY:C1227($O_Objet; "t_OR1_Total"; t_OR1_Total)
			OB SET:C1220($O_Objet; "vl_OR1_Tot"; vl_OR1_Tot)
			
			// tableau 4
			OB SET ARRAY:C1227($O_Objet; "<>ta_TBOr2"; <>ta_TBOr2)
			OB SET ARRAY:C1227($O_Objet; "t_OR2_Total"; t_OR2_Total)
			OB SET:C1220($O_Objet; "vl_OR2_Tot"; vl_OR2_Tot)
			
			// tableau 5
			OB SET ARRAY:C1227($O_Objet; "<>ta_AtS"; <>ta_AtS)
			OB SET ARRAY:C1227($O_Objet; "t_AtS_Total"; t_AtS_Total)
			OB SET:C1220($O_Objet; "vl_AtS_Tot"; vl_AtS_Tot)
			
			// tableau 6
			OB SET ARRAY:C1227($O_Objet; "<>ta_TBMaraud"; <>ta_TBMaraud)
			OB SET ARRAY:C1227($O_Objet; "t_TBMarTot"; t_TBMarTot)
			OB SET:C1220($O_Objet; "vl_Mar_Tot"; vl_Mar_Tot)
		End if 
		
		P_CalcStat_NbEtCvSg(->$O_Objet)
		
		If (True:C214)
			// Initialisées mais non utilisés dans la méthode
			vl_Mar_Hom:=0
			vl_Mar_Fem:=0
			vl_Mar_Tot:=0
			vr_Mar_Pc:=0
			
			// 1
			OB GET ARRAY:C1229($O_Objet; "t_ET_DemPc"; t_ET_DemPc)
			OB GET ARRAY:C1229($O_Objet; "t_ET_DisPc"; t_ET_DisPc)
			OB GET ARRAY:C1229($O_Objet; "t_ET_MedPc"; t_ET_MedPc)
			
			vr_ET_DemPc:=OB Get:C1224($O_Objet; "vr_ET_DemPc"; Est un numérique:K8:4)
			vr_ET_DisPc:=OB Get:C1224($O_Objet; "vr_ET_DisPc"; Est un numérique:K8:4)
			vr_ET_MedPc:=OB Get:C1224($O_Objet; "vr_ET_MedPc"; Est un numérique:K8:4)
			
			// 2
			OB GET ARRAY:C1229($O_Objet; "t_SG_DemPc"; t_SG_DemPc)
			vr_SG_DemPc:=OB Get:C1224($O_Objet; "vr_SG_DemPc"; Est un numérique:K8:4)
			
			// 3
			OB GET ARRAY:C1229($O_Objet; "t_OR1_Pc"; t_OR1_Pc)
			vr_OR1_Pc:=OB Get:C1224($O_Objet; "vr_OR1_Pc"; Est un numérique:K8:4)
			
			// 4
			OB GET ARRAY:C1229($O_Objet; "t_OR2_Pc"; t_OR2_Pc)
			vr_OR2_Pc:=OB Get:C1224($O_Objet; "vr_OR2_Pc"; Est un numérique:K8:4)
			
			// 5
			OB GET ARRAY:C1229($O_Objet; "t_AtS_Pc"; t_AtS_Pc)
			vr_AtS_Pc:=OB Get:C1224($O_Objet; "vr_AtS_Pc"; Est un numérique:K8:4)
			
			// tableau 1
			OB GET ARRAY:C1229($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)
			OB GET ARRAY:C1229($O_Objet; "t_ET_Dem"; t_ET_Dem)
			OB GET ARRAY:C1229($O_Objet; "t_ET_Dis"; t_ET_Dis)
			OB GET ARRAY:C1229($O_Objet; "t_ET_Med"; t_ET_Med)
			
			vl_ET_Dem:=OB Get:C1224($O_Objet; "vl_ET_Dem"; Est un entier long:K8:6)
			vl_ET_Dis:=OB Get:C1224($O_Objet; "vl_ET_Dis"; Est un entier long:K8:6)
			vl_ET_Med:=OB Get:C1224($O_Objet; "vl_ET_Med"; Est un entier long:K8:6)
			
			// tableau 2
			OB GET ARRAY:C1229($O_Objet; "<>ta_TBSglt"; <>ta_TBSglt)
			OB GET ARRAY:C1229($O_Objet; "t_SG_Dem"; t_SG_Dem)
			vl_SG_Dem:=OB Get:C1224($O_Objet; "vl_SG_Dem"; Est un entier long:K8:6)
			
			// tableau 3
			OB GET ARRAY:C1229($O_Objet; "<>ta_TBOr1"; <>ta_TBOr1)
			OB GET ARRAY:C1229($O_Objet; "t_OR1_Total"; t_OR1_Total)
			vl_OR1_Tot:=OB Get:C1224($O_Objet; "vl_OR1_Tot"; Est un entier long:K8:6)
			
			// tableau 4
			OB GET ARRAY:C1229($O_Objet; "<>ta_TBOr2"; <>ta_TBOr2)
			OB GET ARRAY:C1229($O_Objet; "t_OR2_Total"; t_OR2_Total)
			vl_OR2_Tot:=OB Get:C1224($O_Objet; "vl_OR2_Tot"; Est un entier long:K8:6)
			
			// tableau 5
			OB GET ARRAY:C1229($O_Objet; "<>ta_AtS"; <>ta_AtS)
			OB GET ARRAY:C1229($O_Objet; "t_AtS_Total"; t_AtS_Total)
			vl_AtS_Tot:=OB Get:C1224($O_Objet; "vl_AtS_Tot"; Est un entier long:K8:6)
			
			// tableau 6
			OB GET ARRAY:C1229($O_Objet; "<>ta_TBMaraud"; <>ta_TBMaraud)
			OB GET ARRAY:C1229($O_Objet; "t_TBMarTot"; t_TBMarTot)
			vl_Mar_Tot:=OB Get:C1224($O_Objet; "vl_Mar_Tot"; Est un entier long:K8:6)
		End if 
		
		CLEAR VARIABLE:C89($O_Objet)
		Log_mensuel($B_Log; "Etape 4: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	//5
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  5/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours 5/5: Groupes")
	//Les groupes
	If (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		CLEAR VARIABLE:C89($O_Objet)
		
		If (True:C214)
			OB SET ARRAY:C1227($O_Objet; "<>ta_FMCaS"; <>ta_FMCaS)
			OB SET ARRAY:C1227($O_Objet; "<>ta_FMDis1"; <>ta_FMDis1)
			OB SET ARRAY:C1227($O_Objet; "<>ta_FMDis2"; <>ta_FMDis2)
			OB SET ARRAY:C1227($O_Objet; "<>ta_FMDis3"; <>ta_FMDis3)
			OB SET ARRAY:C1227($O_Objet; "<>ta_FMDis4"; <>ta_FMDis4)
			OB SET ARRAY:C1227($O_Objet; "<>ta_FMDis5"; <>ta_FMDis5)
			//OB SET ARRAY($O_Objet;"ta_FAMCpo";ta_FAMCpo)
			//OB SET ARRAY($O_Objet;"ta_xFMCaS";ta_xFMCaS)
			//OB SET ARRAY($O_Objet;"ta_xFMComp";ta_xFMComp)
			//OB SET ARRAY($O_Objet;"ta_xFMDis1";ta_xFMDis1)
			//OB SET ARRAY($O_Objet;"ta_xFMDis2";ta_xFMDis2)
			//OB SET ARRAY($O_Objet;"ta_xFMDis3";ta_xFMDis3)
			//OB SET ARRAY($O_Objet;"ta_xFMDis4";ta_xFMDis4)
			//OB SET ARRAY($O_Objet;"ta_xFMDis5";ta_xFMDis5)
			//OB SET ARRAY($O_Objet;"ta_xFMGrp";ta_xFMGrp)
			OB SET ARRAY:C1227($O_Objet; "ta_xGroupe"; ta_xGroupe)
			OB SET ARRAY:C1227($O_Objet; "tl_FMCaS"; tl_FMCaS)
			OB SET ARRAY:C1227($O_Objet; "tl_FMComp"; tl_FMComp)
			OB SET ARRAY:C1227($O_Objet; "tl_FMCompC"; tl_FMCompC)
			OB SET ARRAY:C1227($O_Objet; "tl_FMCompNC"; tl_FMCompNC)
			OB SET ARRAY:C1227($O_Objet; "tl_FMDis1"; tl_FMDis1)
			OB SET ARRAY:C1227($O_Objet; "tl_FMDis2"; tl_FMDis2)
			OB SET ARRAY:C1227($O_Objet; "tl_FMDis3"; tl_FMDis3)
			OB SET ARRAY:C1227($O_Objet; "tl_FMDis4"; tl_FMDis4)
			OB SET ARRAY:C1227($O_Objet; "tl_FMDis5"; tl_FMDis5)
			
			//OB SET ARRAY($O_Objet;"tl_xFMCaS";tl_xFMCaS)
			//OB SET ARRAY($O_Objet;"tl_xFMComp";tl_xFMComp)
			//OB SET ARRAY($O_Objet;"tl_xFMCompC";tl_xFMCompC)
			//OB SET ARRAY($O_Objet;"tl_xFMCompNC";tl_xFMCompNC)
			//OB SET ARRAY($O_Objet;"tl_xFMDis1";tl_xFMDis1)
			//OB SET ARRAY($O_Objet;"tl_xFMDis2";tl_xFMDis2)
			//OB SET ARRAY($O_Objet;"tl_xFMDis3";tl_xFMDis3)
			//OB SET ARRAY($O_Objet;"tl_xFMDis4";tl_xFMDis4)
			//OB SET ARRAY($O_Objet;"tl_xFMDis5";tl_xFMDis5)
			//OB SET ARRAY($O_Objet;"tl_xFMGrp";tl_xFMGrp)
			
			OB SET ARRAY:C1227($O_Objet; "tl_xGroupe"; tl_xGroupe)
			OB SET ARRAY:C1227($O_Objet; "tr_FMComp"; tr_FMComp)
			OB SET ARRAY:C1227($O_Objet; "tr_FMDis1"; tr_FMDis1)
			OB SET ARRAY:C1227($O_Objet; "tr_FMDis2"; tr_FMDis2)
			OB SET ARRAY:C1227($O_Objet; "tr_FMDis3"; tr_FMDis3)
			OB SET ARRAY:C1227($O_Objet; "tr_FMDis4"; tr_FMDis4)
			OB SET ARRAY:C1227($O_Objet; "tr_FMDis5"; tr_FMDis5)
			//OB SET ARRAY($O_Objet;"tr_xFMComp";tr_xFMComp)
			//OB SET ARRAY($O_Objet;"tr_xFMDis1";tr_xFMDis1)
			//OB SET ARRAY($O_Objet;"tr_xFMDis2";tr_xFMDis2)
			//OB SET ARRAY($O_Objet;"tr_xFMDis3";tr_xFMDis3)
			//OB SET ARRAY($O_Objet;"tr_xFMDis4";tr_xFMDis4)
			//OB SET ARRAY($O_Objet;"tr_xFMDis5";tr_xFMDis5)
			OB SET:C1220($O_Objet; "vl_FMCaS"; vl_FMCaS)
			OB SET:C1220($O_Objet; "vl_FMComp"; vl_FMComp)
			OB SET:C1220($O_Objet; "vl_FMCompC"; vl_FMCompC)
			OB SET:C1220($O_Objet; "vl_FMCompNC"; vl_FMCompNC)
			OB SET:C1220($O_Objet; "vl_FMDis1"; vl_FMDis1)
			OB SET:C1220($O_Objet; "vl_FMDis2"; vl_FMDis2)
			OB SET:C1220($O_Objet; "vl_FMDis3"; vl_FMDis3)
			OB SET:C1220($O_Objet; "vl_FMDis4"; vl_FMDis4)
			OB SET:C1220($O_Objet; "vl_FMDis5"; vl_FMDis5)
			OB SET:C1220($O_Objet; "vl_xGroupe"; vl_xGroupe)
			OB SET:C1220($O_Objet; "vr_FMComp"; vr_FMComp)
			OB SET:C1220($O_Objet; "vr_FMDis1"; vr_FMDis1)
			OB SET:C1220($O_Objet; "vr_FMDis2"; vr_FMDis2)
			OB SET:C1220($O_Objet; "vr_FMDis3"; vr_FMDis3)
			OB SET:C1220($O_Objet; "vr_FMDis4"; vr_FMDis4)
			OB SET:C1220($O_Objet; "vr_FMDis5"; vr_FMDis5)
		End if 
		
		P_CalcStat_NbGroupes(->$O_Objet)
		
		If (True:C214)
			ARRAY TEXT:C222(ta_FAMCpo; 0)
			ARRAY TEXT:C222(ta_xFMGrp; 0)
			ARRAY TEXT:C222(ta_xFMComp; 0)
			ARRAY TEXT:C222(ta_xFMCaS; 0)
			ARRAY TEXT:C222(ta_xFMDis1; 0)
			ARRAY TEXT:C222(ta_xFMDis2; 0)
			ARRAY TEXT:C222(ta_xFMDis3; 0)
			ARRAY TEXT:C222(ta_xFMDis4; 0)
			ARRAY TEXT:C222(ta_xFMDis5; 0)
			
			ARRAY LONGINT:C221(tl_xFMGrp; 0)
			ARRAY LONGINT:C221(tl_xFMComp; 0)
			ARRAY LONGINT:C221(tl_xFMCompC; 0)
			ARRAY LONGINT:C221(tl_xFMCompNC; 0)
			ARRAY REAL:C219(tr_xFMComp; 0)
			ARRAY LONGINT:C221(tl_xFMCaS; 0)
			ARRAY LONGINT:C221(tl_xFMDis1; 0)
			ARRAY LONGINT:C221(tl_xFMDis2; 0)
			ARRAY LONGINT:C221(tl_xFMDis3; 0)
			ARRAY LONGINT:C221(tl_xFMDis4; 0)
			ARRAY LONGINT:C221(tl_xFMDis5; 0)
			
			
			ARRAY REAL:C219(tr_xFMDis1; 0)
			ARRAY REAL:C219(tr_xFMDis2; 0)
			ARRAY REAL:C219(tr_xFMDis3; 0)
			ARRAY REAL:C219(tr_xFMDis4; 0)
			ARRAY REAL:C219(tr_xFMDis5; 0)
			
			//OB GET ARRAY($O_Objet;"<>ta_FMCaS";<>ta_FMCaS)
			//OB GET ARRAY($O_Objet;"<>ta_FMDis1";<>ta_FMDis1)
			//OB GET ARRAY($O_Objet;"<>ta_FMDis2";<>ta_FMDis2)
			//OB GET ARRAY($O_Objet;"<>ta_FMDis3";<>ta_FMDis3)
			//OB GET ARRAY($O_Objet;"<>ta_FMDis4";<>ta_FMDis4)
			//OB GET ARRAY($O_Objet;"<>ta_FMDis5";<>ta_FMDis5)
			OB GET ARRAY:C1229($O_Objet; "ta_FAMCpo"; ta_FAMCpo)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMCaS"; ta_xFMCaS)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMComp"; ta_xFMComp)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMDis1"; ta_xFMDis1)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMDis2"; ta_xFMDis2)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMDis3"; ta_xFMDis3)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMDis4"; ta_xFMDis4)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMDis5"; ta_xFMDis5)
			OB GET ARRAY:C1229($O_Objet; "ta_xFMGrp"; ta_xFMGrp)
			OB GET ARRAY:C1229($O_Objet; "ta_xGroupe"; ta_xGroupe)
			OB GET ARRAY:C1229($O_Objet; "tl_FMCaS"; tl_FMCaS)
			OB GET ARRAY:C1229($O_Objet; "tl_FMComp"; tl_FMComp)
			OB GET ARRAY:C1229($O_Objet; "tl_FMCompC"; tl_FMCompC)
			OB GET ARRAY:C1229($O_Objet; "tl_FMCompNC"; tl_FMCompNC)
			OB GET ARRAY:C1229($O_Objet; "tl_FMDis1"; tl_FMDis1)
			OB GET ARRAY:C1229($O_Objet; "tl_FMDis2"; tl_FMDis2)
			OB GET ARRAY:C1229($O_Objet; "tl_FMDis3"; tl_FMDis3)
			OB GET ARRAY:C1229($O_Objet; "tl_FMDis4"; tl_FMDis4)
			OB GET ARRAY:C1229($O_Objet; "tl_FMDis5"; tl_FMDis5)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMCaS"; tl_xFMCaS)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMComp"; tl_xFMComp)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMCompC"; tl_xFMCompC)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMCompNC"; tl_xFMCompNC)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMDis1"; tl_xFMDis1)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMDis2"; tl_xFMDis2)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMDis3"; tl_xFMDis3)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMDis4"; tl_xFMDis4)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMDis5"; tl_xFMDis5)
			OB GET ARRAY:C1229($O_Objet; "tl_xFMGrp"; tl_xFMGrp)
			OB GET ARRAY:C1229($O_Objet; "tl_xGroupe"; tl_xGroupe)
			OB GET ARRAY:C1229($O_Objet; "tr_FMComp"; tr_FMComp)
			OB GET ARRAY:C1229($O_Objet; "tr_FMDis1"; tr_FMDis1)
			OB GET ARRAY:C1229($O_Objet; "tr_FMDis2"; tr_FMDis2)
			OB GET ARRAY:C1229($O_Objet; "tr_FMDis3"; tr_FMDis3)
			OB GET ARRAY:C1229($O_Objet; "tr_FMDis4"; tr_FMDis4)
			OB GET ARRAY:C1229($O_Objet; "tr_FMDis5"; tr_FMDis5)
			OB GET ARRAY:C1229($O_Objet; "tr_xFMComp"; tr_xFMComp)
			OB GET ARRAY:C1229($O_Objet; "tr_xFMDis1"; tr_xFMDis1)
			OB GET ARRAY:C1229($O_Objet; "tr_xFMDis2"; tr_xFMDis2)
			OB GET ARRAY:C1229($O_Objet; "tr_xFMDis3"; tr_xFMDis3)
			OB GET ARRAY:C1229($O_Objet; "tr_xFMDis4"; tr_xFMDis4)
			OB GET ARRAY:C1229($O_Objet; "tr_xFMDis5"; tr_xFMDis5)
			
			vl_FMCaS:=OB Get:C1224($O_Objet; "vl_FMCaS"; Est un entier long:K8:6)
			vl_FMComp:=OB Get:C1224($O_Objet; "vl_FMComp"; Est un entier long:K8:6)
			vl_FMCompC:=OB Get:C1224($O_Objet; "vl_FMCompC"; Est un entier long:K8:6)
			vl_FMCompNC:=OB Get:C1224($O_Objet; "vl_FMCompNC"; Est un entier long:K8:6)
			vl_FMDis1:=OB Get:C1224($O_Objet; "vl_FMDis1"; Est un entier long:K8:6)
			vl_FMDis2:=OB Get:C1224($O_Objet; "vl_FMDis2"; Est un entier long:K8:6)
			vl_FMDis3:=OB Get:C1224($O_Objet; "vl_FMDis3"; Est un entier long:K8:6)
			vl_FMDis4:=OB Get:C1224($O_Objet; "vl_FMDis4"; Est un entier long:K8:6)
			vl_FMDis5:=OB Get:C1224($O_Objet; "vl_FMDis5"; Est un entier long:K8:6)
			vl_xGroupe:=OB Get:C1224($O_Objet; "vl_xGroupe"; Est un entier long:K8:6)
			vr_FMComp:=OB Get:C1224($O_Objet; "vr_FMComp"; Est un numérique:K8:4)
			vr_FMDis1:=OB Get:C1224($O_Objet; "vr_FMDis1"; Est un numérique:K8:4)
			vr_FMDis2:=OB Get:C1224($O_Objet; "vr_FMDis2"; Est un numérique:K8:4)
			vr_FMDis3:=OB Get:C1224($O_Objet; "vr_FMDis3"; Est un numérique:K8:4)
			vr_FMDis4:=OB Get:C1224($O_Objet; "vr_FMDis4"; Est un numérique:K8:4)
			vr_FMDis5:=OB Get:C1224($O_Objet; "vr_FMDis5"; Est un numérique:K8:4)
		End if 
		
		CLEAR VARIABLE:C89($O_Objet)
		Log_mensuel($B_Log; "Etape 5: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	4D_Progression_Close($L_ref)
	
	// Modifié par : Scanu Rémy (24/07/2023) et Re-modifié par Scanu Rémy (27/09/2023)
	// Ajout tableau contrôle des lignes des différentes ListBox
	ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(t_CT_Total))
	ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(t_ET_Dem))
	ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(t_SG_Dem))
	ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(tl_xGroupe))
	ARRAY BOOLEAN:C223(tb_Sel5; Size of array:C274(tl_xFMCaS))
	
	ARRAY BOOLEAN:C223(tb_Sel6; Size of array:C274(tl_xFMDis3))
	ARRAY BOOLEAN:C223(tb_Sel7; Size of array:C274(tl_xFMDis1))
	ARRAY BOOLEAN:C223(tb_Sel8; Size of array:C274(tl_xFMDis4))
	ARRAY BOOLEAN:C223(tb_Sel9; Size of array:C274(tl_xFMDis2))
	ARRAY BOOLEAN:C223(tb_Sel10; Size of array:C274(tl_xFMDis5))
	ARRAY BOOLEAN:C223(tb_Sel11; Size of array:C274(tl_xFMComp))
	
	If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
		outilsArrayVisibility(->tb_Sel1; ->t_CT_Total; ->tb_Sel2; ->t_ET_Dem; ->tb_Sel3; ->t_SG_Dem; ->tb_Sel4; ->tl_xGroupe; ->tb_Sel5; ->tl_xFMCaS; \
			->tb_Sel6; ->tl_xFMDis3; ->tb_Sel7; ->tl_xFMDis1; ->tb_Sel8; ->tl_xFMDis4; ->tb_Sel9; ->tl_xFMDis2; ->tb_Sel10; ->tl_xFMDis5; ->tb_Sel11; ->tl_xFMComp)
	Else 
		outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215; ->tb_Sel5; False:C215; \
			->tb_Sel6; False:C215; ->tb_Sel7; False:C215; ->tb_Sel8; False:C215; ->tb_Sel9; False:C215; ->tb_Sel10; False:C215; ->tb_Sel11; False:C215)
	End if 
	
	ON EVENT CALL:C190("")
Else 
	StrAlerte(60; "")
End if 