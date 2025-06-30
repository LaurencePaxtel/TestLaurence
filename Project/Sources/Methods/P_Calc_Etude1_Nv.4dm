//%attributes = {}
// ----------------------------------------------------
// LOGICIEL : Samu Social de Paris
// © DBsolutions/Paxtel
// Développeur : Kevin HASSAL
// Date and time: 09/08/19, 20:44:02
// ----------------------------------------------------
// Method: P_Calc_Etude1_Nv
// Description
// Cette méthode a été récrite à partir de la méthode 
// originale P_Calc_Etude1 afin d'optimiser la vitesse
// des calculs statistiques
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i)

If (<>vb_StopEven=False:C215)
	READ ONLY:C145([HeBerge:4])
	
	V_Stat_Etude(1)
	USE SET:C118("E_encours")
	
	If (sSexe=1)
		USE SET:C118("E_encours")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Genre:96=True:C214)
		
		<>te_NbGenre{2}:=<>te_NbGenre{2}+Records in selection:C76([HeberGement:5])
		<>tl_TBGenre{2}:=<>tl_TBGenre{2}+STAT_Get_Nb_Personnes
		
		USE SET:C118("E_encours")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Genre:96=False:C215)
		
		<>te_NbGenre{1}:=<>te_NbGenre{1}+Records in selection:C76([HeberGement:5])
		<>tl_TBGenre{1}:=<>tl_TBGenre{1}+STAT_Get_Nb_Personnes
	End if 
	
	//==================================//
	// Etat civil
	//==================================//
	If (sEtCv=1)
		
		For ($i; 1; Size of array:C274(ta_FilexEtCiv))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_EtatCivil:20=ta_FilexEtCiv{$i})
			
			te_FileEtCivNb{$i}:=te_FileEtCivNb{$i}+Records in selection:C76([HeberGement:5])
			tl_FileEtCivNb{$i}:=tl_FileEtCivNb{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	//==================================//
	// Age
	//==================================//
	If (sAge=1)
		
		// Modifié par : Scanu Rémy (10/10/2023)
		For ($i_el; 1; Size of array:C274(<>te_TBAge))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Age:23<=<>te_TBAge{$i_el})
			
			<>te_NbAge{$i_el}:=<>te_NbAge{$i_el}+Records in selection:C76([HeberGement:5])
			<>tl_NbAge{$i_el}:=<>tl_NbAge{$i_el}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sHeure=1)
		
		For ($i; 1; Size of array:C274(<>ts_Heures))
			USE SET:C118("E_encours")
			
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_AttenteHeur:83>=Time:C179(String:C10(<>ts_Heures{$i})+":00:00"); *)
			QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_AttenteHeur:83<=Time:C179(String:C10(<>ts_Heures{$i})+":59:59"))
			<>te_NbHatt{$i}:=<>te_NbHatt{$i}+Records in selection:C76([HeberGement:5])
			
			USE SET:C118("E_encours")
			
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_CloturéeHeur:86>=Time:C179(String:C10(<>ts_Heures{$i})+":00:00"); *)
			QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_CloturéeHeur:86<=Time:C179(String:C10(<>ts_Heures{$i})+":59:59"))
			<>te_NbHClo{$i}:=<>te_NbHClo{$i}+Records in selection:C76([HeberGement:5])
		End for 
		
	End if 
	
	If (sSignal=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBSglt))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Signalement:12=<>ta_TBSglt{$i})
			
			<>te_NbSglt{$i}:=<>te_NbSglt{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbSglt{$i}:=<>tl_NbSglt{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sSitFam=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBSitFam))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_SituFamille:29=<>ta_TBSitFam{$i})
			
			<>te_NbSitF{$i}:=<>te_NbSitF{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbSitF{$i}:=<>tl_NbSitF{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sNation=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBNatio))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nationalité:25=<>ta_TBNatio{$i})
			
			<>te_NbNatio{$i}:=<>te_NbNatio{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbNatio{$i}:=<>tl_NbNatio{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sMéd=1)
		USE SET:C118("E_encours")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Médicalisé:56=False:C215)
		
		<>te_NbMéd{1}:=<>te_NbMéd{1}+Records in selection:C76([HeberGement:5])
		<>tl_NbMéd{1}:=<>tl_NbMéd{1}+STAT_Get_Nb_Personnes
		
		USE SET:C118("E_encours")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Médicalisé:56=True:C214)
		
		<>te_NbMéd{2}:=<>te_NbMéd{2}+Records in selection:C76([HeberGement:5])
		<>tl_NbMéd{2}:=<>tl_NbMéd{2}+STAT_Get_Nb_Personnes
	End if 
	
	If (sErrance=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBTpsErr))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_TempsErrance:34=<>ta_TBTpsErr{$i})
			
			<>te_NbErr{$i}:=<>te_NbErr{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbErr{$i}:=<>tl_NbErr{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sRess=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBResAct))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Ressources1:45=<>ta_TBResAct{$i})
			
			<>te_NbRes{$i}:=<>te_NbRes{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbRes{$i}:=<>tl_NbRes{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sSuivi=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBSuiSoc))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_SuiviSocial1:49=<>ta_TBSuiSoc{$i})
			
			<>te_NbSui{$i}:=<>te_NbSui{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbSui{$i}:=<>tl_NbSui{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sCouv=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBCouSoc))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_CouvSocial1:53=<>ta_TBCouSoc{$i})
			
			<>te_NbCou{$i}:=<>te_NbCou{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbCou{$i}:=<>tl_NbCou{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sOR1=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBOr1))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Orientation1:58=<>ta_TBOr1{$i})
			
			<>te_NbOr1{$i}:=<>te_NbOr1{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbOr1{$i}:=<>tl_NbOr1{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sOR2=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBOr2))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Orientation2:60=<>ta_TBOr2{$i})
			
			<>te_NbOr2{$i}:=<>te_NbOr2{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbOr2{$i}:=<>tl_NbOr2{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sAutre=1)
		
		For ($i; 1; Size of array:C274(<>ta_AtS))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_AutreSolutio:88=<>ta_AtS{$i})
			
			<>te_NbAtS{$i}:=<>te_NbAtS{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbAtS{$i}:=<>tl_NbAtS{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sGare=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBGare))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Gare:15=<>ta_TBGare{$i})
			
			<>te_NbGare{$i}:=<>te_NbGare{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbGare{$i}:=<>tl_NbGare{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sVille=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBMetro))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Métro:16=<>ta_TBMetro{$i})
			
			<>te_NbMetro{$i}:=<>te_NbMetro{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbMetro{$i}:=<>tl_NbMetro{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sRupt=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBRupMaj))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_RupMajeur1:40=<>ta_TBRupMaj{$i})
			
			<>te_TBRupMaj{$i}:=<>te_TBRupMaj{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBRupMajo{$i}:=<>tl_TBRupMajo{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sCP=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBArr))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_CodePostal:14=<>ta_TBArr{$i})
			
			<>te_NbArr{$i}:=<>te_NbArr{$i}+Records in selection:C76([HeberGement:5])
			<>tl_NbArr{$i}:=<>tl_NbArr{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sDerJob=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBDerJob))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_DernierEmplo:37=<>ta_TBDerJob{$i})
			
			<>te_TBDerJob{$i}:=<>te_TBDerJob{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBDerJob{$i}:=<>tl_TBDerJob{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sSitPro=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBSitPro))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_SituProfess:36=<>ta_TBSitPro{$i})
			
			<>te_TBSitPro{$i}:=<>te_TBSitPro{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBSitPro{$i}:=<>tl_TBSitPro{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sDerHg=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBDerHéb))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_DernierHéber:35=<>ta_TBDerHéb{$i})
			
			<>te_TBDerHéb{$i}:=<>te_TBDerHéb{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBDerHéb{$i}:=<>tl_TBDerHéb{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sLien=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBLien))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Lien:18=<>ta_TBLien{$i})
			
			<>te_TBLien{$i}:=<>te_TBLien{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBLien{$i}:=<>tl_TBLien{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sPIdté=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBPIdté))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_PiècesIdté1:31=<>ta_TBPIdté{$i})
			
			<>te_TBPIdté{$i}:=<>te_TBPIdté{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBPIdté{$i}:=<>tl_TBPIdté{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sNivEtude=1)
		
		For ($i; 1; Size of array:C274(<>ta_TBNivEtu))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NiveauEtude:43=<>ta_TBNivEtu{$i})
			
			<>te_TBNivEtu{$i}:=<>te_TBNivEtu{$i}+Records in selection:C76([HeberGement:5])
			<>tl_TBNivEtu{$i}:=<>tl_TBNivEtu{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	If (sCasSpec=1)
		
		For ($i; 1; Size of array:C274(<>ta_FMCaS))
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamCasSpéc:111=<>ta_FMCaS{$i})
			
			<>te_FMCaS{$i}:=<>te_FMCaS{$i}+Records in selection:C76([HeberGement:5])
			<>tl_FMCaS{$i}:=<>tl_FMCaS{$i}+STAT_Get_Nb_Personnes
		End for 
		
	End if 
	
	// Modifié par : Scanu Rémy (10/10/2023)
	If (sChefFam=1)
		USE SET:C118("E_encours")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamChef:103=True:C214)
		
		Form:C1466.chefFamilleFiche:=Records in selection:C76([HeberGement:5])
		Form:C1466.chefFamillePersonne:=STAT_Get_Nb_Personnes
	End if 
	
End if 