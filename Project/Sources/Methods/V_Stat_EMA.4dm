//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_EMA
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($ii)
Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		C_LONGINT:C283(rJourNuit1; rJourNuit2; vl_NbJ)
		C_DATE:C307(vd_Date1; vd_Date2)
		rJourNuit1:=1
		rJourNuit2:=1
		vl_NbJ:=0
		C_TEXT:C284(vt_StTexte)
		
		//Nombre de fiches ; Hommes; Femmes
		C_LONGINT:C283(vl_NbHB; vl_NbHBm; vl_NbHBf)
		//Nombre de personnes ; Hommes; Femmes
		C_LONGINT:C283(vl_NbHBd; vl_NbHBdm; vl_NbHBdf)
		
		//Break sur le nombre de fiches par personnes
		C_LONGINT:C283(vl_Break; vl_Break2)
		
		//Signalement en effectif et en personnes
		C_LONGINT:C283(vl_SG_e; vl_SG_p; vl_TabSG)
		vl_TabSG:=Size of array:C274(<>ta_TBSglt)
		ARRAY LONGINT:C221(t_SG_e; vl_TabSG)
		ARRAY LONGINT:C221(t_SG_p; vl_TabSG)
		//Emplacement en effectif et en personnes
		C_LONGINT:C283(vl_PL_e; vl_PL_p; vl_TabPL)
		vl_TabPL:=Size of array:C274(<>ta_TBPorte)
		ARRAY LONGINT:C221(t_PL_e; vl_TabPL)
		ARRAY LONGINT:C221(t_PL_p; vl_TabPL)
		//Arrondissement en effectif et en personnes
		C_LONGINT:C283(vl_Ar_e; vl_Ar_p; vl_TabAR)
		vl_TabAR:=Size of array:C274(<>ta_TBArr)
		ARRAY LONGINT:C221(t_Ar_e; vl_TabAR)
		ARRAY LONGINT:C221(t_Ar_p; vl_TabAR)
		//Demandes en effectif et en personnes
		C_LONGINT:C283(vl_Dm_e; vl_Dm_p; vl_TabDm)
		vl_TabDm:=Size of array:C274(<>ta_MRDem)
		ARRAY LONGINT:C221(t_Dm_e; vl_TabDm)
		ARRAY LONGINT:C221(t_Dm_p; vl_TabDm)
		
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
		
		//Etat général en effectif et en personnes
		C_LONGINT:C283(vl_EtG_e; vl_EtG_p; vl_TabEtG)
		vl_TabEtG:=Size of array:C274(<>ta_MReGé)
		ARRAY LONGINT:C221(t_EtG_e; vl_TabEtG)
		ARRAY LONGINT:C221(t_EtG_p; vl_TabEtG)
		//Etat cutané en effectif et en personnes
		C_LONGINT:C283(vl_EtCu_e; vl_EtCu_p; vl_TabEtCu)
		vl_TabEtCu:=Size of array:C274(<>ta_MReCu)
		ARRAY LONGINT:C221(t_EtCu_e; vl_TabEtCu)
		ARRAY LONGINT:C221(t_EtCu_p; vl_TabEtCu)
		//Relation en effectif et en personnes
		C_LONGINT:C283(vl_Rel_e; vl_Rel_p; vl_TabRel)
		vl_TabRel:=Size of array:C274(<>ta_MRrel)
		ARRAY LONGINT:C221(t_Rel_e; vl_TabRel)
		ARRAY LONGINT:C221(t_Rel_p; vl_TabRel)
		//Orient sociale en effectif et en personnes
		C_LONGINT:C283(vl_OSc_e; vl_OSc_p; vl_TabOSc)
		vl_TabOSc:=Size of array:C274(<>ta_OrSc)
		ARRAY LONGINT:C221(t_OSc_e; vl_TabOSc)
		ARRAY LONGINT:C221(t_OSc_p; vl_TabOSc)
		//Orient médicale en effectif et en personnes
		C_LONGINT:C283(vl_OMd_e; vl_OMd_p; vl_TabOMd)
		vl_TabOMd:=Size of array:C274(<>ta_OrMd)
		ARRAY LONGINT:C221(t_OMd_e; vl_TabOMd)
		ARRAY LONGINT:C221(t_OMd_p; vl_TabOMd)
		
		
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		//Signalement en effectif et en personnes
		
		vl_SG_e:=0
		vl_SG_p:=0
		For ($ii; 1; vl_TabSG)
			t_SG_e{$ii}:=0
			t_SG_p{$ii}:=0
		End for 
		//Emplacement en effectif et en personnes
		vl_PL_e:=0
		vl_PL_p:=0
		For ($ii; 1; vl_TabPL)
			t_PL_e{$ii}:=0
			t_PL_p{$ii}:=0
		End for 
		//Arrondissement en effectif et en personnes
		vl_Ar_e:=0
		vl_Ar_p:=0
		For ($ii; 1; vl_TabAR)
			t_Ar_e{$ii}:=0
			t_Ar_p{$ii}:=0
		End for 
		//Demandes en effectif et en personnes
		vl_Dm_e:=0
		vl_Dm_p:=0
		For ($ii; 1; vl_TabDm)
			t_Dm_e{$ii}:=0
			t_Dm_p{$ii}:=0
		End for 
		//Age
		vl_Ag_e:=0
		vl_Ag_p:=0
		For ($ii; 1; vl_TabAg)
			t_Ag_e{$ii}:=0
			t_Ag_p{$ii}:=0
		End for 
		
		//Heure
		vh_Rt:=?00:00:00?
		
		//Rencontre en effectif et en personnes
		vl_Rd_e:=0
		vl_Rd_p:=0
		For ($ii; 1; vl_TabHeur)
			t_Rd_e{$ii}:=0
			t_Rd_p{$ii}:=0
		End for 
		//Fin de rencontre en effectif et en personnes
		vl_Rf_e:=0
		vl_Rf_p:=0
		For ($ii; 1; vl_TabHeur)
			t_Rf_e{$ii}:=0
			t_Rf_p{$ii}:=0
		End for 
		//Durée de rencontre en effectif et en personnes
		vl_Rt_e:=0
		vl_Rt_p:=0
		For ($ii; 1; vl_TabDuré)
			t_Rt_e{$ii}:=0
			t_Rt_p{$ii}:=0
		End for 
		
		//Etat général en effectif et en personnes
		vl_EtG_e:=0
		vl_EtG_p:=0
		For ($ii; 1; vl_TabEtG)
			t_EtG_e{$ii}:=0
			t_EtG_p{$ii}:=0
		End for 
		//Etat cutané en effectif et en personnes
		vl_EtCu_e:=0
		vl_EtCu_p:=0
		For ($ii; 1; vl_TabEtCu)
			t_EtCu_e{$ii}:=0
			t_EtCu_p{$ii}:=0
		End for 
		//Relation en effectif et en personnes
		vl_Rel_e:=0
		vl_Rel_p:=0
		For ($ii; 1; vl_TabRel)
			t_Rel_e{$ii}:=0
			t_Rel_p{$ii}:=0
		End for 
		//Orient sociale en effectif et en personnes
		vl_OSc_e:=0
		vl_OSc_p:=0
		For ($ii; 1; vl_TabOSc)
			t_OSc_e{$ii}:=0
			t_OSc_p{$ii}:=0
		End for 
		ARRAY LONGINT:C221(t_OSc_e; vl_TabOSc)
		ARRAY LONGINT:C221(t_OSc_p; vl_TabOSc)
		//Orient médicale en effectif et en personnes
		vl_OMd_e:=0
		vl_OMd_p:=0
		For ($ii; 1; vl_TabOMd)
			t_OMd_e{$ii}:=0
			t_OMd_p{$ii}:=0
		End for 
		
		
End case 