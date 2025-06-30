//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : P_SIAO_PrintDossier  
//{          Mardi 3 avril 2012 à 11:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii; $jj; $kk)
C_BOOLEAN:C305($vb_OK)

If (vl_SIAO_RefAttestation>0)
	va_Page:=""
	CREATE SET:C116([SIAO:50]; "E_SIAO")
	QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=vl_SIAO_RefAttestation)
	MultiSoc_Filter(->[SIAO:50])
	If (Records in selection:C76([SIAO:50])=1)
		_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_01")
		PRINT SETTINGS:C106
		If (OK=1)
			
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
			
			
			$vb_OK:=F_SIAO_Var_Attestation(1; 0)
			$vb_OK:=F_SIAO_Var_Attestation(10; 0)
			
			va_Page:="Page de garde"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_01")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_01")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 1"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_02")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_02")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 2 & 3"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_03")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_03")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 4"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_04")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_04")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 5"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_05")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_05")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 6"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_06")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_06")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 7"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_07")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_07")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 8"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_08")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_08")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 9"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_09")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_09")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			
			va_Page:="Page 10 & 11"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_10")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_10")
			PRINT SELECTION:C60([SIAO:50]; *)
			
			va_Page:="Page 12 et fin"
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Dossier_12")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Dossier_12")
			PRINT SELECTION:C60([SIAO:50]; *)
		End if 
		FORM SET OUTPUT:C54([SIAO:50]; "Si_ListeInclue")
	Else 
		ALERT:C41("Aucun dossier trouvé !")
	End if 
	USE SET:C118("E_SIAO")
	CLEAR SET:C117("E_SIAO")
	vL_NbFiches:=Records in selection:C76([SIAO:50])
	If (vL_NbFiches>0)
		P_SIAO_Sort(2)
	Else 
		vl_SIAO_RefAttestation:=0
	End if 
Else 
	ALERT:C41("Vous devez sélectionner un dossier.")
End if 
