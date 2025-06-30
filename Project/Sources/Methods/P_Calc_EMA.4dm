//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_EMA
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii)
If (vl_Break<=0)
	vl_Break:=1
	vl_Break2:=1
End if 
If (vl_Break2<vl_Break)
	$ii:=vl_Break
	vl_Break:=vl_Break2
	vl_Break2:=$ii
End if 


//procédure : Uut_Calc_StatEM
C_DATE:C307($Dtx)

If (vl_NbJ>366) | (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	
	C_TEXT:C284($T_File)
	$T_File:="debug_"+Current method name:C684+"_.txt"
	C_BOOLEAN:C305($B_Log)
	$B_Log:=False:C215
	Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
	
	V_Stat_EMA(1)
	
	$Dtx:=!00-00-00!
	i_Message("Calcul en cours …")
	If (vd_Date1>!00-00-00!)
		If (vd_Date1>vd_Date2)
			$Dtx:=vd_Date2
			vd_Date2:=vd_Date1
			vd_Date1:=$Dtx
		End if 
		
		
		// Partie1
		C_LONGINT:C283($L_Tick)
		$L_Tick:=Milliseconds:C459
		
		C_OBJECT:C1216($O_Objet)
		If (True:C214)
			OB SET:C1220($O_Objet; "rJourNuit1"; rJourNuit1)
			OB SET:C1220($O_Objet; "rJourNuit2"; rJourNuit2)
			OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
			OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
			OB SET:C1220($O_Objet; "vl_NbHB"; vl_NbHB)
			OB SET:C1220($O_Objet; "vl_NbHBd"; vl_NbHBd)
			OB SET:C1220($O_Objet; "vl_NbHBdf"; vl_NbHBdf)
			OB SET:C1220($O_Objet; "vl_NbHBdm"; vl_NbHBdm)
			OB SET:C1220($O_Objet; "vl_NbHBf"; vl_NbHBf)
			OB SET:C1220($O_Objet; "vl_NbHBm"; vl_NbHBm)
		End if 
		
		// Modifié par : Kevin HASSAL (06/12/2018)
		// On passe la valeur de la variable <>ref_soc_active
		// pour les méhodes qui s'exécutent côté serveur
		
		P_CalcSat_EMA_partie1(->$O_Objet; <>ref_soc_active)
		
		If (True:C214)
			rJourNuit1:=OB Get:C1224($O_Objet; "rJourNuit1"; Est un entier long:K8:6)
			rJourNuit2:=OB Get:C1224($O_Objet; "rJourNuit2"; Est un entier long:K8:6)
			vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)
			vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)
			vl_NbHB:=OB Get:C1224($O_Objet; "vl_NbHB"; Est un entier long:K8:6)
			vl_NbHBd:=OB Get:C1224($O_Objet; "vl_NbHBd"; Est un entier long:K8:6)
			vl_NbHBdf:=OB Get:C1224($O_Objet; "vl_NbHBdf"; Est un entier long:K8:6)
			vl_NbHBdm:=OB Get:C1224($O_Objet; "vl_NbHBdm"; Est un entier long:K8:6)
			vl_NbHBf:=OB Get:C1224($O_Objet; "vl_NbHBf"; Est un entier long:K8:6)
			vl_NbHBm:=OB Get:C1224($O_Objet; "vl_NbHBm"; Est un entier long:K8:6)
		End if 
		CLEAR VARIABLE:C89($O_Objet)
		Log_mensuel($B_Log; "Etape 1: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
		
		
		MESSAGES OFF:C175
		i_Stop
		ON EVENT CALL:C190("i_Stop_ESC")
		
		// partie2
		i_MessageSeul("Calcul en cours : Personnes différentes")
		If (<>vb_StopEven=False:C215)
			USE SET:C118("E_encours")
			RELATE ONE SELECTION:C349([Maraude:24]; [HeBerge:4])
			vl_NbHBd:=Records in selection:C76([HeBerge:4])
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HG_Genre:39=False:C215)
			vl_NbHBdm:=Records in selection:C76([HeBerge:4])
			vl_NbHBdf:=vl_NbHBd-vl_NbHBdm
		End if 
		//Suite
		If (<>vb_StopEven=False:C215)
			
			CREATE EMPTY SET:C140([HeBerge:4]; "E_HBCompte")
			USE SET:C118("E_encours")
			
			C_OBJECT:C1216($O_Objet)
			If (True:C214)
				OB SET:C1220($O_Objet; "<>vb_StopEven"; <>vb_StopEven)
				
				OB SET ARRAY:C1227($O_Objet; "<>ta_MRDem"; <>ta_MRDem)
				OB SET ARRAY:C1227($O_Objet; "<>ta_MReCu"; <>ta_MReCu)
				OB SET ARRAY:C1227($O_Objet; "<>ta_MReGé"; <>ta_MReGé)
				OB SET ARRAY:C1227($O_Objet; "<>ta_MRrel"; <>ta_MRrel)
				OB SET ARRAY:C1227($O_Objet; "<>ta_OrMd"; <>ta_OrMd)
				OB SET ARRAY:C1227($O_Objet; "<>ta_OrSc"; <>ta_OrSc)
				OB SET ARRAY:C1227($O_Objet; "<>ta_TBArr"; <>ta_TBArr)
				OB SET ARRAY:C1227($O_Objet; "<>ta_TBPorte"; <>ta_TBPorte)
				OB SET ARRAY:C1227($O_Objet; "<>ta_TBSglt"; <>ta_TBSglt)
				
				OB SET ARRAY:C1227($O_Objet; "t_Rd_e"; t_Rd_e)
				OB SET ARRAY:C1227($O_Objet; "t_Ag_e"; t_Ag_e)
				OB SET ARRAY:C1227($O_Objet; "t_Ag_p"; t_Ag_p)
				OB SET ARRAY:C1227($O_Objet; "t_Ar_e"; t_Ar_e)
				OB SET ARRAY:C1227($O_Objet; "t_Ar_p"; t_Ar_p)
				OB SET ARRAY:C1227($O_Objet; "t_DM_e"; t_DM_e)
				OB SET ARRAY:C1227($O_Objet; "t_DM_p"; t_DM_p)
				OB SET ARRAY:C1227($O_Objet; "t_EtCu_e"; t_EtCu_e)
				OB SET ARRAY:C1227($O_Objet; "t_EtCu_p"; t_EtCu_p)
				OB SET ARRAY:C1227($O_Objet; "t_EtG_e"; t_EtG_e)
				OB SET ARRAY:C1227($O_Objet; "t_EtG_p"; t_EtG_p)
				OB SET ARRAY:C1227($O_Objet; "t_OMd_e"; t_OMd_e)
				OB SET ARRAY:C1227($O_Objet; "t_OMd_p"; t_OMd_p)
				OB SET ARRAY:C1227($O_Objet; "t_OSc_e"; t_OSc_e)
				OB SET ARRAY:C1227($O_Objet; "t_OSc_p"; t_OSc_p)
				OB SET ARRAY:C1227($O_Objet; "t_PL_e"; t_PL_e)
				OB SET ARRAY:C1227($O_Objet; "t_PL_p"; t_PL_p)
				OB SET ARRAY:C1227($O_Objet; "t_Rd_p"; t_Rd_p)
				OB SET ARRAY:C1227($O_Objet; "t_Rel_e"; t_Rel_e)
				OB SET ARRAY:C1227($O_Objet; "t_Rel_p"; t_Rel_p)
				OB SET ARRAY:C1227($O_Objet; "t_Rf_e"; t_Rf_e)
				OB SET ARRAY:C1227($O_Objet; "t_Rf_p"; t_Rf_p)
				OB SET ARRAY:C1227($O_Objet; "t_Rt_e"; t_Rt_e)
				OB SET ARRAY:C1227($O_Objet; "t_Rt_p"; t_Rt_p)
				OB SET ARRAY:C1227($O_Objet; "t_SG_e"; t_SG_e)
				OB SET ARRAY:C1227($O_Objet; "t_SG_p"; t_SG_p)
				
				OB SET ARRAY:C1227($O_Objet; "<>te_TBAge"; <>te_TBAge)
				OB SET ARRAY:C1227($O_Objet; "<>ts_Heures"; <>ts_Heures)
				OB SET ARRAY:C1227($O_Objet; "<>th_Rt"; <>th_Rt)
			End if 
			P_CalcSat_EMA_partie2(->$O_Objet)
			If (True:C214)
				OB SET:C1220($O_Objet; "<>vb_StopEven"; <>vb_StopEven)
				
				OB GET ARRAY:C1229($O_Objet; "<>ta_MRDem"; <>ta_MRDem)
				OB GET ARRAY:C1229($O_Objet; "<>ta_MReCu"; <>ta_MReCu)
				OB GET ARRAY:C1229($O_Objet; "<>ta_MReGé"; <>ta_MReGé)
				OB GET ARRAY:C1229($O_Objet; "<>ta_MRrel"; <>ta_MRrel)
				OB GET ARRAY:C1229($O_Objet; "<>ta_OrMd"; <>ta_OrMd)
				OB GET ARRAY:C1229($O_Objet; "<>ta_OrSc"; <>ta_OrSc)
				OB GET ARRAY:C1229($O_Objet; "<>ta_TBArr"; <>ta_TBArr)
				OB GET ARRAY:C1229($O_Objet; "<>ta_TBPorte"; <>ta_TBPorte)
				OB GET ARRAY:C1229($O_Objet; "<>ta_TBSglt"; <>ta_TBSglt)
				
				OB GET ARRAY:C1229($O_Objet; "t_Rd_e"; t_Rd_e)
				OB GET ARRAY:C1229($O_Objet; "t_Ag_e"; t_Ag_e)
				OB GET ARRAY:C1229($O_Objet; "t_Ag_p"; t_Ag_p)
				OB GET ARRAY:C1229($O_Objet; "t_Ar_e"; t_Ar_e)
				OB GET ARRAY:C1229($O_Objet; "t_Ar_p"; t_Ar_p)
				OB GET ARRAY:C1229($O_Objet; "t_DM_e"; t_DM_e)
				OB GET ARRAY:C1229($O_Objet; "t_DM_p"; t_DM_p)
				OB GET ARRAY:C1229($O_Objet; "t_EtCu_e"; t_EtCu_e)
				OB GET ARRAY:C1229($O_Objet; "t_EtCu_p"; t_EtCu_p)
				OB GET ARRAY:C1229($O_Objet; "t_EtG_e"; t_EtG_e)
				OB GET ARRAY:C1229($O_Objet; "t_EtG_p"; t_EtG_p)
				OB GET ARRAY:C1229($O_Objet; "t_OMd_e"; t_OMd_e)
				OB GET ARRAY:C1229($O_Objet; "t_OMd_p"; t_OMd_p)
				OB GET ARRAY:C1229($O_Objet; "t_OSc_e"; t_OSc_e)
				OB GET ARRAY:C1229($O_Objet; "t_OSc_p"; t_OSc_p)
				OB GET ARRAY:C1229($O_Objet; "t_PL_e"; t_PL_e)
				OB GET ARRAY:C1229($O_Objet; "t_PL_p"; t_PL_p)
				OB GET ARRAY:C1229($O_Objet; "t_Rd_p"; t_Rd_p)
				OB GET ARRAY:C1229($O_Objet; "t_Rel_e"; t_Rel_e)
				OB GET ARRAY:C1229($O_Objet; "t_Rel_p"; t_Rel_p)
				OB GET ARRAY:C1229($O_Objet; "t_Rf_e"; t_Rf_e)
				OB GET ARRAY:C1229($O_Objet; "t_Rf_p"; t_Rf_p)
				OB GET ARRAY:C1229($O_Objet; "t_Rt_e"; t_Rt_e)
				OB GET ARRAY:C1229($O_Objet; "t_Rt_p"; t_Rt_p)
				OB GET ARRAY:C1229($O_Objet; "t_SG_e"; t_SG_e)
				OB GET ARRAY:C1229($O_Objet; "t_SG_p"; t_SG_p)
				
				OB GET ARRAY:C1229($O_Objet; "<>te_TBAge"; <>te_TBAge)
				OB GET ARRAY:C1229($O_Objet; "<>ts_Heures"; <>ts_Heures)
				OB GET ARRAY:C1229($O_Objet; "<>th_Rt"; <>th_Rt)
			End if 
			CLEAR VARIABLE:C89($O_Objet)
			
			
		End if 
		P_Calc_StatType2(->vl_TabSG; ->vl_SG_e; ->vl_SG_p; ->t_SG_e; ->t_SG_p)
		P_Calc_StatType2(->vl_TabPL; ->vl_PL_e; ->vl_PL_p; ->t_PL_e; ->t_PL_p)
		P_Calc_StatType2(->vl_TabAR; ->vl_Ar_e; ->vl_Ar_p; ->t_Ar_e; ->t_Ar_p)
		P_Calc_StatType2(->vl_TabDm; ->vl_Dm_e; ->vl_Dm_p; ->t_Dm_e; ->t_Dm_p)
		P_Calc_StatType2(->vl_TabAg; ->vl_Ag_e; ->vl_Ag_p; ->t_Ag_e; ->t_Ag_p)
		P_Calc_StatType2(->vl_TabHeur; ->vl_Rd_e; ->vl_Rd_p; ->t_Rd_e; ->t_Rd_p)
		P_Calc_StatType2(->vl_TabHeur; ->vl_Rf_e; ->vl_Rf_p; ->t_Rf_e; ->t_Rf_p)
		P_Calc_StatType2(->vl_TabDuré; ->vl_Rt_e; ->vl_Rt_p; ->t_Rt_e; ->t_Rt_p)
		P_Calc_StatType2(->vl_TabEtG; ->vl_EtG_e; ->vl_EtG_p; ->t_EtG_e; ->t_EtG_p)
		P_Calc_StatType2(->vl_TabEtCu; ->vl_EtCu_e; ->vl_EtCu_p; ->t_EtCu_e; ->t_EtCu_p)
		P_Calc_StatType2(->vl_TabRel; ->vl_Rel_e; ->vl_Rel_p; ->t_Rel_e; ->t_Rel_p)
		P_Calc_StatType2(->vl_TabOSc; ->vl_OSc_e; ->vl_OSc_p; ->t_OSc_e; ->t_OSc_p)
		P_Calc_StatType2(->vl_TabOMd; ->vl_OMd_e; ->vl_OMd_p; ->t_OMd_e; ->t_OMd_p)
		
		
		ON EVENT CALL:C190("")
	Else 
		StrAlerte(60; "")
	End if 
	CLOSE WINDOW:C154
End if 

