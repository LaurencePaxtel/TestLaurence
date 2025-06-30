//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_DASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

// #TAG-STATS

C_DATE:C307($Dtx)
$Dtx:=!00-00-00!

i_Message("Calcul en cours …")
If (vd_Date1>!00-00-00!)
	If (vd_Date1>vd_Date2)
		$Dtx:=vd_Date2
		vd_Date2:=vd_Date1
		vd_Date1:=$Dtx
	End if 
	MESSAGES OFF:C175
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	
	i_MessageSeul("Calcul en cours  1/6: Nombre de lits")
	
	V_Stat_Etude(1)
	
	//Nombre de lits
	If (<>vb_StopEven=False:C215)
		P_CalcStat_NbLitsDASS
	End if 
	
	i_MessageSeul("Calcul en cours  2/6: Nombre d'appels")
	//Nombre d'appels
	If (<>vb_StopEven=False:C215)
		P_CalcStat_NbAppelsDASS
	End if 
	
	i_MessageSeul("Calcul en cours  3/6: Etat civil /signalement/Orientations")
	//EtatCivil/Signalement
	If (<>vb_StopEven=False:C215)
		
		C_OBJECT:C1216($O_Objet)
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
	End if 
	
	i_MessageSeul("Calcul en cours 4/6: Centres d'hébergement")
	//L'Hébergement
	If (<>vb_StopEven=False:C215)
		P_CalcStat_NbCentresDASS
	End if 
	
	i_MessageSeul("Calcul en cours 5/6: Prestations diverses")
	//Demande de prestations
	If (<>vb_StopEven=False:C215)
		P_CalcStat_NbPrestationsDASS
	End if 
	
	i_MessageSeul("Calcul en cours 6/6: Appels")
	//Appels
	If (<>vb_StopEven=False:C215)
		P_CalcStat_NbAppelsTypes
	End if 
	ON EVENT CALL:C190("")
Else 
	StrAlerte(60; "")
End if 
CLOSE WINDOW:C154
