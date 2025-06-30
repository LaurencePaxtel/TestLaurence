//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_MaraudeVeilleFind
//{
//{          Vendredi 3 mars 2006 à 14:04
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
		QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_Date:4=[DiaLogues:3]DL_Date:2; *)
	Else 
		QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_Date:4>=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([DossierSocial:25];  & ; [DossierSocial:25]DS_Date:4<=[DiaLogues:3]DL_Date2:8; *)
	End if 
	
	If ([DiaLogues:3]DL_LibelPlus:6>"")
		QUERY:C277([DossierSocial:25];  & ; [DossierSocial:25]DS_Nom:12=([DiaLogues:3]DL_LibelPlus:6+"@"); *)
	End if 
	QUERY:C277([DossierSocial:25])
	MultiSoc_Filter(->[DossierSocial:25])
	
	//`Etat civil  
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_EtatCivil:11; -><>ta_DsEtCiv; -><>te_DsEtCiv)
	//Nationalité
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_Nationalité:22; -><>ta_DsNat; -><>te_DsNat)
	
	//PersMaj  
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_PersonMajeur:24; -><>ta_DsPmaj; -><>te_DsPmaj)
	
	//ConnuSSP_Motif  
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_ConnuSSP:39; -><>ta_DsCoSSP; -><>te_DsCoSSP)
	
	//Compagnie_Problèmatique  
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_Compagnie:37; -><>ta_DsComp; -><>te_DsComp)
	
	//Régime1
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_Régime1:67; -><>ta_DsRgim1; -><>te_DsRgim1)
	
	//Papier1  
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_Papier1:48; -><>ta_DsPap1; -><>te_DsPap1)
	
	//Soc1  
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_SuiviS1:70; -><>ta_DsSoc1; -><>te_DsSoc1)
	
	//Res1
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_Ressour1_1:58; -><>ta_DsRes1; -><>te_DsRes1)
	
	//Err
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_TempsErrance:35; -><>ta_DsErr; -><>te_DsErr)
	
	//NeOu
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_LieuNéOù:19; -><>ta_DsNeOu; -><>te_DsNeOu)
	
	
	//Langue
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_Langue:23; -><>ta_DsLang; -><>te_DsLang)
	
	//Provenance_DerHeb
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_DernierHéber:27; -><>ta_DsDerH; -><>te_DsDerH)
	
	//CouvSoc
	P_HébergementCritèresFind(->[DossierSocial:25]; ->[DossierSocial:25]DS_CouvSoc1_1:51; -><>ta_DsCouvS; -><>te_DsCouvS)
	
	
End if 

vL_NbFiches:=Records in selection:C76([DossierSocial:25])
If (vL_NbFiches>0)
	P_DosSocialVeilleSort(2)
End if 