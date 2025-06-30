//%attributes = {"executedOnServer":true}
// Method P_CalcSat_EMA_partie2  
// 


C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)



ARRAY TEXT:C222(<>ta_MRDem; 0)
ARRAY TEXT:C222(<>ta_MReCu; 0)
ARRAY TEXT:C222(<>ta_MReGé; 0)
ARRAY TEXT:C222(<>ta_MRrel; 0)
ARRAY TEXT:C222(<>ta_OrMd; 0)
ARRAY TEXT:C222(<>ta_OrSc; 0)
ARRAY TEXT:C222(<>ta_TBArr; 0)
ARRAY TEXT:C222(<>ta_TBPorte; 0)
ARRAY TEXT:C222(<>ta_TBSglt; 0)
ARRAY LONGINT:C221(t_Rd_e; 0)
ARRAY LONGINT:C221(t_Ag_e; 0)
ARRAY LONGINT:C221(t_Ag_p; 0)
ARRAY LONGINT:C221(t_Ar_e; 0)
ARRAY LONGINT:C221(t_Ar_p; 0)
ARRAY LONGINT:C221(t_DM_e; 0)
ARRAY LONGINT:C221(t_DM_p; 0)
ARRAY LONGINT:C221(t_EtCu_e; 0)
ARRAY LONGINT:C221(t_EtCu_p; 0)
ARRAY LONGINT:C221(t_EtG_e; 0)
ARRAY LONGINT:C221(t_EtG_p; 0)
ARRAY LONGINT:C221(t_OMd_e; 0)
ARRAY LONGINT:C221(t_OMd_p; 0)
ARRAY LONGINT:C221(t_OSc_e; 0)
ARRAY LONGINT:C221(t_OSc_p; 0)
ARRAY LONGINT:C221(t_PL_e; 0)
ARRAY LONGINT:C221(t_PL_p; 0)
ARRAY LONGINT:C221(t_Rd_p; 0)
ARRAY LONGINT:C221(t_Rel_e; 0)
ARRAY LONGINT:C221(t_Rel_p; 0)
ARRAY LONGINT:C221(t_Rf_e; 0)
ARRAY LONGINT:C221(t_Rf_p; 0)
ARRAY LONGINT:C221(t_Rt_e; 0)
ARRAY LONGINT:C221(t_Rt_p; 0)
ARRAY LONGINT:C221(t_SG_e; 0)
ARRAY LONGINT:C221(t_SG_p; 0)

ARRAY INTEGER:C220(<>te_TBAge; 0)
ARRAY LONGINT:C221(<>ts_Heures; 0)
ARRAY LONGINT:C221(<>th_Rt; 0)

<>vb_StopEven:=OB Get:C1224($O_Objet; "<>vb_StopEven"; Est un booléen:K8:9)

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
	
	P_Calc_StatAge([Maraude:24]MR_Age:19; $TuCompte; ->t_Ag_e; ->t_Ag_p)
	
	
	P_Calc_StatDurée([Maraude:24]MR_HeureDebut:22; [Maraude:24]MR_HeureFin:23; $TuCompte; ->t_Rd_e; ->t_Rd_p; ->t_Rf_e; ->t_Rf_p; ->t_Rt_e; ->t_Rt_p)
	
	//Signalement
	
	P_Calc_StatType1([Maraude:24]MR_Signalt:12; $TuCompte; -><>ta_TBSglt; ->t_SG_e; ->t_SG_p)
	//Emplacements
	
	P_Calc_StatType1([Maraude:24]MR_Emplacement:14; $TuCompte; -><>ta_TBPorte; ->t_PL_e; ->t_PL_p)
	//Arrondissement
	
	P_Calc_StatType1([Maraude:24]MR_ArrondCP:15; $TuCompte; -><>ta_TBArr; ->t_Ar_e; ->t_Ar_p)
	//Demande
	
	P_Calc_StatType1([Maraude:24]MR_Demande:24; $TuCompte; -><>ta_MRDem; ->t_DM_e; ->t_DM_p)
	//Etat général
	
	P_Calc_StatType1([Maraude:24]MR_EtatGénéral:26; $TuCompte; -><>ta_MReGé; ->t_EtG_e; ->t_EtG_p)
	//Etat cutané
	
	P_Calc_StatType1([Maraude:24]MR_EtatCutané:27; $TuCompte; -><>ta_MReCu; ->t_EtCu_e; ->t_EtCu_p)
	//Relation
	
	P_Calc_StatType1([Maraude:24]MR_Relation:28; $TuCompte; -><>ta_MRrel; ->t_Rel_e; ->t_Rel_p)
	//Orientations Sociales
	
	P_Calc_StatType1([Maraude:24]MR_OrSoc:36; $TuCompte; -><>ta_OrSc; ->t_OSc_e; ->t_OSc_p)
	//Orientations médicales
	
	P_Calc_StatType1([Maraude:24]MR_OrMéd:33; $TuCompte; -><>ta_OrMd; ->t_OMd_e; ->t_OMd_p)
	NEXT RECORD:C51([Maraude:24])
End while 



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

$P_Objet->:=OB Copy:C1225($O_Objet)
