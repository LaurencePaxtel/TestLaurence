//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_FicheSociale
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (vl_Break<=0)
	vl_Break:=1
	vl_Break2:=1
End if 
If (vl_Break2<vl_Break)
	$ii:=vl_Break
	vl_Break:=vl_Break2
	vl_Break2:=$ii
End if 


C_DATE:C307($Dtx)
C_LONGINT:C283($ii)
If (vl_NbJ>366) | (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	V_Stat_FicheSociale(1)
	
	$Dtx:=!00-00-00!
	
	i_Message("Calcul en cours …")
	
	If (vd_Date1>!00-00-00!)
		If (vd_Date1>vd_Date2)
			$Dtx:=vd_Date2
			vd_Date2:=vd_Date1
			vd_Date1:=$Dtx
		End if 
		If (vd_Date1=vd_Date2)
			QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4>=vd_Date1; *)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Date:4<=vd_Date2; *)
		End if 
		If (rJourNuit1=1) & (rJourNuit2=1)  //Jour et nuit
		Else 
			If (rJourNuit1=1)  //Jour
				QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=False:C215; *)
			End if 
			If (rJourNuit2=1)  //nuit
				QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=True:C214; *)
			End if 
		End if 
		QUERY:C277([Maraude:24])
		MultiSoc_Filter(->[Maraude:24])
		vl_NbHB:=Records in selection:C76([Maraude:24])
		If (vl_NbHB>0)
			CREATE SET:C116([Maraude:24]; "E_encours")
			USE SET:C118("E_encours")
			vl_NbHB:=Records in set:C195("E_encours")
			QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_Genre:42=False:C215)
			vl_NbHBm:=Records in selection:C76([Maraude:24])
			vl_NbHBf:=vl_NbHB-vl_NbHBm
		Else 
			CREATE EMPTY SET:C140([Maraude:24]; "E_encours")
			//Nombre de fiches ; Hommes; Femmes
			vl_NbHB:=0
			vl_NbHBm:=0
			vl_NbHBf:=0
			//Nombre de personnes ; Hommes; Femmes
			vl_NbHBd:=0
			vl_NbHBdm:=0
			vl_NbHBdf:=0
		End if 
		
		MESSAGES OFF:C175
		i_Stop
		ON EVENT CALL:C190("i_Stop_ESC")
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
			ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Date:4; <)
			//FIRST RECORD([Maraude])
			While ((Not:C34(End selection:C36([Maraude:24]))) & (<>vb_StopEven=False:C215))
				
				C_BOOLEAN:C305($TuCompte)
				$TuCompte:=False:C215
				RELATE ONE:C42([Maraude:24]MR_HB_ID:10)
				If (Records in selection:C76([HeBerge:4])=1)
					If (Is in set:C273("E_HBCompte"))
					Else 
						ADD TO SET:C119([HeBerge:4]; "E_HBCompte")
						$TuCompte:=True:C214
					End if 
				End if 
				//Prise en charge EMA
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{35})
				P_Calc_StatType1([Maraude:24]MR_EnChargeEMA:43; $TuCompte; -><>ta_MRPch; ->t_MRPch_e; ->t_MRPch_p)
				//Dernier lieu d'hébergement
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{37})
				P_Calc_StatType1([Maraude:24]MR_DernierHéber:45; $TuCompte; -><>ta_DerLH; ->t_DerLH_e; ->t_DerLH_p)
				//Personne chez qui aller
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{43})
				P_Calc_StatType1([Maraude:24]MR_Connaissance:51; $TuCompte; -><>ta_MRQui; ->t_MRQui_e; ->t_MRQui_p)
				//Motif de refus
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{36})
				P_Calc_StatType1([Maraude:24]MR_RefusEMA:44; $TuCompte; -><>ta_MRrefu; ->t_MRrefu_e; ->t_MRrefu_p)
				//Quel mode
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{40})
				P_Calc_StatType1([Maraude:24]MR_Mode1:48; $TuCompte; -><>ta_Qmod; ->t_Qmod_e; ->t_Qmod_p)
				//Temps d'errance
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{42})
				P_Calc_StatType1([Maraude:24]MR_TempsErrance:50; $TuCompte; -><>ta_TBTpsErr; ->t_ter_e; ->t_ter_p)
				//Compagnie actuelle
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44})
				P_Calc_StatType1([Maraude:24]MR_Compagnie:52; $TuCompte; -><>ta_CpAct; ->t_CpAct_e; ->t_CpAct_p)
				//Quel papier
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56})
				P_Calc_StatType1([Maraude:24]MR_Papier1:55; $TuCompte; -><>ta_TBPIdté; ->t_Idté_e; ->t_Idté_p)
				//Quel régime
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68})
				P_Calc_StatType1([Maraude:24]MR_Régime1:72; $TuCompte; -><>ta_MRrg; ->t_MRrg_e; ->t_MRrg_p)
				//Quel suivi
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72})
				P_Calc_StatType1([Maraude:24]MR_SuiviS1:76; $TuCompte; -><>ta_MRss; ->t_MRss_e; ->t_MRss_p)
				//Quelle couverture 1
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48})
				P_Calc_StatType1([Maraude:24]MR_CouvSoc1_1:58; $TuCompte; -><>ta_MRcs; ->t_Rcs1_e; ->t_Rcs1_p)
				//Quelle couverture 2
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{50})
				P_Calc_StatType1([Maraude:24]MR_CouvSoc2_1:60; $TuCompte; -><>ta_MRcs; ->t_Rcs2_e; ->t_Rcs2_p)
				//Quelle couverture 3
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{52})
				P_Calc_StatType1([Maraude:24]MR_CouvSoc3_1:62; $TuCompte; -><>ta_MRcs; ->t_Rcs3_e; ->t_Rcs3_p)
				//Quelle ressources 1
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{60})
				P_Calc_StatType1([Maraude:24]MR_Ressour1_1:65; $TuCompte; -><>ta_MRrs; ->t_Rrs1_e; ->t_Rrs1_p)
				//Quelle ressources 2
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{62})
				P_Calc_StatType1([Maraude:24]MR_Ressour2_1:67; $TuCompte; -><>ta_MRrs; ->t_Rrs2_e; ->t_Rrs2_p)
				//Quelle ressources 3
				i_MessageSeul("Calcul en cours : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{64})
				P_Calc_StatType1([Maraude:24]MR_Ressour3_1:69; $TuCompte; -><>ta_MRrs; ->t_Rrs3_e; ->t_Rrs3_p)
				NEXT RECORD:C51([Maraude:24])
			End while 
		End if 
		P_Calc_StatType2(->vl_MRPch; ->vl_MRPch_e; ->vl_MRPch_p; ->t_MRPch_e; ->t_MRPch_p)
		P_Calc_StatType2(->vl_DerLH; ->vl_DerLH_e; ->vl_DerLH_p; ->t_DerLH_e; ->t_DerLH_p)
		P_Calc_StatType2(->vl_MRQui; ->vl_MRQui_e; ->vl_MRQui_p; ->t_MRQui_e; ->t_MRQui_p)
		P_Calc_StatType2(->vl_MRrefu; ->vl_MRrefu_e; ->vl_MRrefu_p; ->t_MRrefu_e; ->t_MRrefu_p)
		P_Calc_StatType2(->vl_Qmod; ->vl_Qmod_e; ->vl_Qmod_p; ->t_Qmod_e; ->t_Qmod_p)
		P_Calc_StatType2(->vl_ter; ->vl_ter_e; ->vl_ter_p; ->t_ter_e; ->t_ter_p)
		P_Calc_StatType2(->vl_CpAct; ->vl_CpAct_e; ->vl_CpAct_p; ->t_CpAct_e; ->t_CpAct_p)
		P_Calc_StatType2(->vl_Idté; ->vl_Idté_e; ->vl_Idté_p; ->t_Idté_e; ->t_Idté_p)
		P_Calc_StatType2(->vl_MRrg; ->vl_MRrg_e; ->vl_MRrg_p; ->t_MRrg_e; ->t_MRrg_p)
		P_Calc_StatType2(->vl_MRss; ->vl_MRss_e; ->vl_MRss_p; ->t_MRss_e; ->t_MRss_p)
		P_Calc_StatType2(->vl_Rcs1; ->vl_Rcs1_e; ->vl_Rcs1_p; ->t_Rcs1_e; ->t_Rcs1_p)
		P_Calc_StatType2(->vl_Rcs2; ->vl_Rcs2_e; ->vl_Rcs2_p; ->t_Rcs2_e; ->t_Rcs2_p)
		P_Calc_StatType2(->vl_Rcs3; ->vl_Rcs3_e; ->vl_Rcs3_p; ->t_Rcs3_e; ->t_Rcs3_p)
		P_Calc_StatType2(->vl_Rrs1; ->vl_Rrs1_e; ->vl_Rrs1_p; ->t_Rrs1_e; ->t_Rrs1_p)
		P_Calc_StatType2(->vl_Rrs2; ->vl_Rrs2_e; ->vl_Rrs2_p; ->t_Rrs2_e; ->t_Rrs2_p)
		P_Calc_StatType2(->vl_Rrs3; ->vl_Rrs3_e; ->vl_Rrs3_p; ->t_Rrs3_e; ->t_Rrs3_p)
		
		
		ON EVENT CALL:C190("")
	Else 
		StrAlerte(60; "")
	End if 
	CLOSE WINDOW:C154
End if 


