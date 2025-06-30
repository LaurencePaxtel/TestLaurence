C_BOOLEAN:C305($vb_Ok; $vb_CAS)
C_LONGINT:C283($ii; $jj; $kk)

If (Form event code:C388=Sur chargement:K2:1)
	
	//•Pour le cilc et doubleClic
	vl_SourisX:=0
	vl_SourisY:=0
	vl_SourisBt:=0
	
	//•PopUp pages
	vl_SIAO_PageNo:=1
	ta_SIAO_Page:=vl_SIAO_PageNo
	ta_SIAO_PageTitre:=vl_SIAO_PageNo
	te_SIAO_PageNo:=vl_SIAO_PageNo
	va_SIAO_PageTitre:=ta_SIAO_PageTitre{ta_SIAO_Page}
	OBJECT SET ENABLED:C1123(b_Previous; False:C215)
	
	OBJECT SET VISIBLE:C603(b_SYNCHROHG; <>vb_T_SIAOsynchroHGBT)
	
	//•Block Personnes
	ta_SIAO_PopSitFam:=1
	ta_SIAO_PopModFam:=1
	
	//•Position des ressources et dette en saisissable ou non 
	vl_Ss_RS_Editer:=0
	vl_Ss_DT_Editer:=0
	
	If (Is new record:C668([SIAO:50]))
		MultiSoc_Init_Structure(->[SIAO:50])
		i_Message("Création du dossier en cours…")
		[SIAO:50]Si_RéférenceID:1:=Uut_Numerote(->[SIAO:50])
		[SIAO:50]Si_Demande_Date:2:=Current date:C33
		[SIAO:50]Si_Demandeur_ID:21:=vl_CleUnique_ID
		[SIAO:50]Si_Demande_Nombre:4:=""
		[SIAO:50]Si_Demande_Numero:3:=F_Site(<>va_T_Site)+F_SIAO_Numero([SIAO:50]Si_Demande_Date:2)
		[SIAO:50]Si_Demandeur:20:=F_CléUnique_Clé([SIAO:50]Si_Demandeur_ID:21)
		[SIAO:50]Si_Demande_Type:5:=vl_SIAO_Action
		[SIAO:50]Si_OrigineSiteAccueil_ID:19:=vl_SIAO_Referent
		[SIAO:50]Si_Origine_SiteReference_ID:15:=1
		[SIAO:50]Si_Demande_fichecreeepar:6:=Current user:C182
		[SIAO:50]Si_Trans_Type:34:=<>vb_T_SIAO_Insertion
		
		//•• Référent
		QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=[SIAO:50]Si_OrigineSiteAccueil_ID:19)
		MultiSoc_Filter(->[SIAO_SiteAccueil:55])
		If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
			[SIAO:50]Si_Origine_SiteAccueil:18:=[SIAO_SiteAccueil:55]Sr_Nom:5+" "+[SIAO_SiteAccueil:55]Sr_Prénom:6
		End if 
		UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
		//•• Accueil
		QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=[SIAO:50]Si_Origine_SiteReference_ID:15)
		MultiSoc_Filter(->[SIAO_SiteReference:54])
		If (Records in selection:C76([SIAO_SiteReference:54])=1)
			[SIAO:50]Si_Origine_SiteReference:14:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
		End if 
		UNLOAD RECORD:C212([SIAO_SiteReference:54])
		
		//•• Création des pages du dossier
		ta_SIAO_PopSitFam:=3
		i_MessageSeul("Création des pages du dossier en cours : 1 / 12")
		$vb_OK:=F_SIAO_Var_SP(5; vl_CleUnique_ID; 0; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 2 / 12")
		$vb_OK:=F_SIAO_Var_AD(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 3 / 12")
		$vb_OK:=F_SIAO_Var_SsCS(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 4 / 12")
		$vb_OK:=F_SIAO_Var_SsSP(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 5 / 12")
		$vb_OK:=F_SIAO_Var_SsRS(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 6 / 12")
		$vb_OK:=F_SIAO_Var_SsDT(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 7 / 12")
		$vb_OK:=F_SIAO_Var_SsLG(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 8 / 12")
		$vb_OK:=F_SIAO_Var_SsDL(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 9 / 12")
		$vb_OK:=F_SIAO_Var_SsBS(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 10 / 12")
		$vb_OK:=F_SIAO_Var_SsPR(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 11 / 12")
		$vb_OK:=F_SIAO_Var_SsPP(2; vl_SP_Reference; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		i_MessageSeul("Création des pages du dossier en cours : 12 / 12")
		
		If (<>vb_T_SIAOsynchroHG)
			If (F_SIAO_SynchroHG(1; [SIAO:50]Si_Demandeur_ID:21; False:C215))
				$vb_OK:=F_SIAO_SynchroHG(2; [SIAO:50]Si_Demandeur_ID:21; False:C215)
			End if 
			i_MessageSeul("Création des pages du dossier en cours : synchronisation")
		End if 
		
		CLOSE WINDOW:C154
	Else 
		
		If ([SIAO:50]Si_Origine_SiteReference_ID:15=0)
			[SIAO:50]Si_Origine_SiteReference_ID:15:=1
			//•• Accueil
			QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=[SIAO:50]Si_Origine_SiteReference_ID:15)
			MultiSoc_Filter(->[SIAO_SiteAccueil:55])
			If (Records in selection:C76([SIAO_SiteReference:54])=1)
				[SIAO:50]Si_Origine_SiteReference:14:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
			End if 
		End if 
		
		
		P_LesLogs(<>va_Log_SIAO; [SIAO:50]Si_Demande_Numero:3)
	End if 
	
	//•• Vérification de l'existance de la bonne structure de fiches (nombre)
	$vb_OK:=F_SIAO_Var_Verif(1; [SIAO:50]Si_RéférenceID:1; 0)
	
	//•• Type de demande : Individuel/Famille/Groupe
	R1:=Num:C11([SIAO:50]Si_Demande_Type:5=1)
	R2:=Num:C11([SIAO:50]Si_Demande_Type:5=2)
	R3:=Num:C11([SIAO:50]Si_Demande_Type:5=3)
	
	
	//•• Synchro des pages
	If (F_SIAO_Var_SP(2; [SIAO:50]Si_RéférenceID:1; 0; <>vp_SIAO_PointeurVide; 0))
		$ii:=3
		$jj:=tl_SP_Reference{ta_SP_Nom}
		$kk:=[SIAO:50]Si_RéférenceID:1
	Else 
		$ii:=1
		$jj:=0
		$kk:=0
	End if 
	$vb_OK:=F_SIAO_Var_SP($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)
	$vb_OK:=F_SIAO_Var_AD($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //ADRESSE
	$vb_OK:=F_SIAO_Var_SsCS($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
	$vb_OK:=F_SIAO_Var_SsSP($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
	$vb_OK:=F_SIAO_Var_SsRS($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
	$vb_OK:=F_SIAO_Var_SsDT($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
	$vb_OK:=F_SIAO_Var_SsLG($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
	$vb_OK:=F_SIAO_Var_SsDL($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
	
	$vb_OK:=F_SIAO_Var_SsBS($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
	$vb_OK:=F_SIAO_Var_SsPR($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL et suite
	$vb_OK:=F_SIAO_Var_SsPP($ii; $jj; $kk; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS
	
	//•• Calcul des totaux
	$vb_OK:=F_SIAO_Var_SsTotal(3; 0; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //Totaux
	
	//•• Synchro des personnes
	If (Size of array:C274(ta_SP_Nom)>0)
		ta_SP_Nom:=1
	Else 
		ta_SP_Nom:=0
	End if 
	tl_SP_Reference:=ta_SP_Nom
	tl_SP_SIAO_ID:=ta_SP_Nom
	tl_SP_Personne_ID:=ta_SP_Nom
	ta_SP_Famille:=ta_SP_Nom
	ta_SP_Theme:=ta_SP_Nom
	ta_SP_SousTheme:=ta_SP_Nom
	tl_SP_Rang:=ta_SP_Nom
	ta_SP_Nom:=ta_SP_Nom
	ta_SP_Prenom:=ta_SP_Nom
	td_SP_NeLeDate:=ta_SP_Nom
	
	//•• Couleur du dossier en fonction de la fermeture ou pas du dossier
	Case of 
		: ([SIAO:50]Si_Fermeture:46>!00-00-00!)
			_O_OBJECT SET COLOR:C271(*; "Rect_Dossier"; -(Rouge:K11:4+(256*Rouge:K11:4)))
			
		: ([SIAO:50]Si_DemandeAnnulee:29)
			_O_OBJECT SET COLOR:C271(*; "Rect_Dossier"; -(Jaune:K11:2+(256*Jaune:K11:2)))
			
		Else 
			
	End case 
	
	
	$vb_CAS:=(([SIAO:50]Si_Fermeture:46=!00-00-00!) & ([SIAO:50]Si_DemandeAnnulee:29=False:C215))
	$kk:=Num:C11($vb_CAS=True:C214)
	$vb_OK:=F_SIAO_Var_SP(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)
	$vb_OK:=F_SIAO_Var_AD(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //ADRESSE
	$vb_OK:=F_SIAO_Var_SsCS(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
	$vb_OK:=F_SIAO_Var_SsSP(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
	$vb_OK:=F_SIAO_Var_SsRS(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
	$vb_OK:=F_SIAO_Var_SsDT(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
	$vb_OK:=F_SIAO_Var_SsLG(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
	$vb_OK:=F_SIAO_Var_SsDL(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
	
	$vb_OK:=F_SIAO_Var_SsBS(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
	$vb_OK:=F_SIAO_Var_SsPR(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL et suite
	$vb_OK:=F_SIAO_Var_SsPP(11; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS
	
	If (7=7)
		//Non saisissables le champs enumérés
		$vb_OK:=F_SIAO_Var_SP(13; 0; 0; <>vp_SIAO_PointeurVide; 0)  //Etat cicil
		//ADRESSE
		$vb_OK:=F_SIAO_Var_SsCS(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
		$vb_OK:=F_SIAO_Var_SsSP(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
		$vb_OK:=F_SIAO_Var_SsRS(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
		$vb_OK:=F_SIAO_Var_SsDT(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
		$vb_OK:=F_SIAO_Var_SsLG(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
		$vb_OK:=F_SIAO_Var_SsDL(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
		
		$vb_OK:=F_SIAO_Var_SsBS(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
		$vb_OK:=F_SIAO_Var_SsPR(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL et suite
		$vb_OK:=F_SIAO_Var_SsPP(13; $kk; 0; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS
	End if 
	
	P_SIAO_Divers($vb_CAS)
	
	P_SIAO_MontantSaisie(1; vl_Ss_RS_Editer)
	P_SIAO_MontantSaisie(2; vl_Ss_DT_Editer)
	
	OBJECT SET VISIBLE:C603(b_TransSIAO; False:C215)
	
	
End if 