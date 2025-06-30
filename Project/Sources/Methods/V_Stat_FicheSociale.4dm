//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_FicheSociale
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($ii)
Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		C_LONGINT:C283(rJourNuit1; rJourNuit2)
		C_DATE:C307(vd_Date1; vd_Date2)
		rJourNuit1:=1
		rJourNuit2:=1
		
		//Nombre de fiches ; Hommes; Femmes
		C_LONGINT:C283(vl_NbHB; vl_NbHBm; vl_NbHBf)
		//Nombre de personnes ; Hommes; Femmes
		C_LONGINT:C283(vl_NbHBd; vl_NbHBdm; vl_NbHBdf)
		
		//Break sur le nombre de fiches par personnes
		C_LONGINT:C283(vl_Break; vl_Break2)
		
		//Age
		C_LONGINT:C283(vl_Ag_e; vl_Ag_p; vl_TabAg)
		
		vl_TabAg:=9
		
		
		ARRAY LONGINT:C221(t_Ag_e; vl_TabAg)
		ARRAY LONGINT:C221(t_Ag_p; vl_TabAg)
		
		ARRAY TEXT:C222(<>ta_TBAge; vl_TabAg)
		<>ta_TBAge{1}:="de 0 jusqu' à  3"
		<>ta_TBAge{2}:="plus de 3 et moins de 18"
		<>ta_TBAge{3}:="plus de 18 jusqu' à 24"
		<>ta_TBAge{4}:="plus de 24 jusqu' à 29"
		<>ta_TBAge{5}:="plus de 29 jusqu' à 39"
		<>ta_TBAge{6}:="plus de 39 jusqu' à 49"
		<>ta_TBAge{7}:="plus de 49 jusqu' à 59"
		<>ta_TBAge{8}:="plus de 59 jusqu' à 69"
		<>ta_TBAge{9}:="plus de 69"
		
		ARRAY INTEGER:C220(<>te_TBAge; vl_TabAg)
		<>te_TBAge{1}:=3
		<>te_TBAge{2}:=18
		<>te_TBAge{3}:=24
		<>te_TBAge{4}:=29
		<>te_TBAge{5}:=39
		<>te_TBAge{6}:=49
		<>te_TBAge{7}:=59
		<>te_TBAge{8}:=69
		<>te_TBAge{9}:=70
		
		
		//Heure
		C_LONGINT:C283(vl_TabHeur; vl_TabDuré)
		vl_TabHeur:=24
		vl_TabDuré:=10
		ARRAY LONGINT:C221(<>ts_Heures; vl_TabHeur)
		For ($ii; 1; vl_TabHeur)
			<>ts_Heures{$ii}:=$ii-1
		End for 
		//Durée
		C_TIME:C306(vh_Rt)
		vh_Rt:=?00:00:00?
		ARRAY LONGINT:C221(<>th_Rt; vl_TabDuré)
		<>th_Rt{1}:=5
		<>th_Rt{2}:=10
		<>th_Rt{3}:=15
		<>th_Rt{4}:=30
		<>th_Rt{5}:=45
		<>th_Rt{6}:=60
		<>th_Rt{7}:=90
		<>th_Rt{8}:=120
		<>th_Rt{9}:=150
		<>th_Rt{10}:=151
		
		//Rencontre en effectif et en personnes
		C_LONGINT:C283(vl_Rd_e; vl_Rd_p)
		ARRAY LONGINT:C221(t_Rd_e; vl_TabHeur)
		ARRAY LONGINT:C221(t_Rd_p; vl_TabHeur)
		//Fin de rencontre en effectif et en personnes
		C_LONGINT:C283(vl_Rf_e; vl_Rf_p)
		ARRAY LONGINT:C221(t_Rf_e; vl_TabHeur)
		ARRAY LONGINT:C221(t_Rf_p; vl_TabHeur)
		//Durée de rencontre en effectif et en personnes
		C_LONGINT:C283(vl_Rt_e; vl_Rt_p)
		ARRAY LONGINT:C221(t_Rt_e; vl_TabDuré)
		ARRAY LONGINT:C221(t_Rt_p; vl_TabDuré)
		
		
		//Prise en charge EMA
		C_LONGINT:C283(vl_MRPch_e; vl_MRPch_p; vl_MRPch)
		vl_MRPch:=Size of array:C274(<>ta_MRPch)
		ARRAY LONGINT:C221(t_MRPch_e; vl_MRPch)
		ARRAY LONGINT:C221(t_MRPch_p; vl_MRPch)
		//Dernier lieu d'hébergement
		C_LONGINT:C283(vl_DerLH_e; vl_DerLH_p; vl_DerLH)
		vl_DerLH:=Size of array:C274(<>ta_DerLH)
		ARRAY LONGINT:C221(t_DerLH_e; vl_DerLH)
		ARRAY LONGINT:C221(t_DerLH_p; vl_DerLH)
		//Personne chez qui aller
		C_LONGINT:C283(vl_MRQui_e; vl_MRQui_p; vl_MRQui)
		vl_MRQui:=Size of array:C274(<>ta_MRQui)
		ARRAY LONGINT:C221(t_MRQui_e; vl_MRQui)
		ARRAY LONGINT:C221(t_MRQui_p; vl_MRQui)
		//Motif de refus
		C_LONGINT:C283(vl_MRrefu_e; vl_MRrefu_p; vl_MRrefu)
		vl_MRrefu:=Size of array:C274(<>ta_MRrefu)
		ARRAY LONGINT:C221(t_MRrefu_e; vl_MRrefu)
		ARRAY LONGINT:C221(t_MRrefu_p; vl_MRrefu)
		//Quel mode
		C_LONGINT:C283(vl_Qmod_e; vl_Qmod_p; vl_Qmod)
		vl_Qmod:=Size of array:C274(<>ta_Qmod)
		ARRAY LONGINT:C221(t_Qmod_e; vl_Qmod)
		ARRAY LONGINT:C221(t_Qmod_p; vl_Qmod)
		
		
		//Temps d'errance
		C_LONGINT:C283(vl_ter_e; vl_ter_p; vl_ter)
		vl_ter:=Size of array:C274(<>ta_TBTpsErr)
		ARRAY LONGINT:C221(t_ter_e; vl_ter)
		ARRAY LONGINT:C221(t_ter_p; vl_ter)
		
		//Compagnie actuelle
		C_LONGINT:C283(vl_CpAct_e; vl_CpAct_p; vl_CpAct)
		vl_CpAct:=Size of array:C274(<>ta_CpAct)
		ARRAY LONGINT:C221(t_CpAct_e; vl_CpAct)
		ARRAY LONGINT:C221(t_CpAct_p; vl_CpAct)
		//Quel papier
		C_LONGINT:C283(vl_Idté_e; vl_Idté_p; vl_Idté)
		vl_Idté:=Size of array:C274(<>ta_TBPIdté)
		ARRAY LONGINT:C221(t_Idté_e; vl_Idté)
		ARRAY LONGINT:C221(t_Idté_p; vl_Idté)
		//Quel régime
		C_LONGINT:C283(vl_MRrg_e; vl_MRrg_p; vl_MRrg)
		vl_MRrg:=Size of array:C274(<>ta_MRrg)
		ARRAY LONGINT:C221(t_MRrg_e; vl_MRrg)
		ARRAY LONGINT:C221(t_MRrg_p; vl_MRrg)
		//Quel suivi
		C_LONGINT:C283(vl_MRss_e; vl_MRss_p; vl_MRss)
		vl_MRss:=Size of array:C274(<>ta_MRss)
		ARRAY LONGINT:C221(t_MRss_e; vl_MRss)
		ARRAY LONGINT:C221(t_MRss_p; vl_MRss)
		//Quelle couverture 1
		C_LONGINT:C283(vl_Rcs1_e; vl_Rcs1_p; vl_Rcs1)
		vl_Rcs1:=Size of array:C274(<>ta_MRcs)
		ARRAY LONGINT:C221(t_Rcs1_e; vl_Rcs1)
		ARRAY LONGINT:C221(t_Rcs1_p; vl_Rcs1)
		//Quelle couverture 2
		C_LONGINT:C283(vl_Rcs2_e; vl_Rcs2_p; vl_Rcs2)
		vl_Rcs2:=Size of array:C274(<>ta_MRcs)
		ARRAY LONGINT:C221(t_Rcs2_e; vl_Rcs2)
		ARRAY LONGINT:C221(t_Rcs2_p; vl_Rcs2)
		//Quelle couverture3
		C_LONGINT:C283(vl_Rcs3_e; vl_Rcs3_p; vl_Rcs3)
		vl_Rcs3:=Size of array:C274(<>ta_MRcs)
		ARRAY LONGINT:C221(t_Rcs3_e; vl_Rcs3)
		ARRAY LONGINT:C221(t_Rcs3_p; vl_Rcs3)
		//Quelles ressources 1
		C_LONGINT:C283(vl_Rrs1_e; vl_Rrs1_p; vl_Rrs1)
		vl_Rrs1:=Size of array:C274(<>ta_MRrs)
		ARRAY LONGINT:C221(t_Rrs1_e; vl_Rrs1)
		ARRAY LONGINT:C221(t_Rrs1_p; vl_Rrs1)
		//Quelles ressources 2
		C_LONGINT:C283(vl_Rrs2_e; vl_Rrs2_p; vl_Rrs2)
		vl_Rrs2:=Size of array:C274(<>ta_MRrs)
		ARRAY LONGINT:C221(t_Rrs2_e; vl_Rrs2)
		ARRAY LONGINT:C221(t_Rrs2_p; vl_Rrs2)
		//Quelles ressources 3
		C_LONGINT:C283(vl_Rrs3_e; vl_Rrs3_p; vl_Rrs3)
		vl_Rrs3:=Size of array:C274(<>ta_MRrs)
		ARRAY LONGINT:C221(t_Rrs3_e; vl_Rrs3)
		ARRAY LONGINT:C221(t_Rrs3_p; vl_Rrs3)
		
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		vl_MRPch_e:=0
		vl_MRPch_p:=0
		For ($ii; 1; vl_MRPch)
			t_MRPch_e{$ii}:=0
			t_MRPch_p{$ii}:=0
		End for 
		
		vl_DerLH_e:=0
		vl_DerLH_p:=0
		For ($ii; 1; vl_DerLH)
			t_DerLH_e{$ii}:=0
			t_DerLH_p{$ii}:=0
		End for 
		
		vl_MRQui_e:=0
		vl_MRQui_p:=0
		For ($ii; 1; vl_MRQui)
			t_MRQui_e{$ii}:=0
			t_MRQui_p{$ii}:=0
		End for 
		
		vl_MRrefu_e:=0
		vl_MRrefu_p:=0
		For ($ii; 1; vl_MRrefu)
			t_MRrefu_e{$ii}:=0
			t_MRrefu_p{$ii}:=0
		End for 
		
		vl_Qmod_e:=0
		vl_Qmod_p:=0
		For ($ii; 1; vl_Qmod)
			t_Qmod_e{$ii}:=0
			t_Qmod_p{$ii}:=0
		End for 
		
		vl_ter_e:=0
		vl_ter_p:=0
		For ($ii; 1; vl_ter)
			t_ter_e{$ii}:=0
			t_ter_p{$ii}:=0
		End for 
		
		vl_CpAct_e:=0
		vl_CpAct_p:=0
		For ($ii; 1; vl_CpAct)
			t_CpAct_e{$ii}:=0
			t_CpAct_p{$ii}:=0
		End for 
		
		vl_Idté_e:=0
		vl_Idté_p:=0
		For ($ii; 1; vl_Idté)
			t_Idté_e{$ii}:=0
			t_Idté_p{$ii}:=0
		End for 
		
		vl_MRrg_e:=0
		vl_MRrg_p:=0
		For ($ii; 1; vl_MRrg)
			t_MRrg_e{$ii}:=0
			t_MRrg_p{$ii}:=0
		End for 
		
		vl_MRss_e:=0
		vl_MRss_p:=0
		For ($ii; 1; vl_MRss)
			t_MRss_e{$ii}:=0
			t_MRss_p{$ii}:=0
		End for 
		
		vl_Rcs1_e:=0
		vl_Rcs1_p:=0
		For ($ii; 1; vl_Rcs1)
			t_Rcs1_e{$ii}:=0
			t_Rcs1_p{$ii}:=0
		End for 
		
		vl_Rcs2_e:=0
		vl_Rcs2_p:=0
		For ($ii; 1; vl_Rcs2)
			t_Rcs2_e{$ii}:=0
			t_Rcs2_p{$ii}:=0
		End for 
		
		vl_Rcs3_e:=0
		vl_Rcs3_p:=0
		For ($ii; 1; vl_Rcs3)
			t_Rcs3_e{$ii}:=0
			t_Rcs3_p{$ii}:=0
		End for 
		
		vl_Rrs1_e:=0
		vl_Rrs1_p:=0
		For ($ii; 1; vl_Rrs1)
			t_Rrs1_e{$ii}:=0
			t_Rrs1_p{$ii}:=0
		End for 
		
		vl_Rrs2_e:=0
		vl_Rrs2_p:=0
		For ($ii; 1; vl_Rrs2)
			t_Rrs2_e{$ii}:=0
			t_Rrs2_p{$ii}:=0
		End for 
		
		vl_Rrs3_e:=0
		vl_Rrs3_p:=0
		For ($ii; 1; vl_Rrs3)
			t_Rrs3_e{$ii}:=0
			t_Rrs3_p{$ii}:=0
		End for 
		
		
End case 