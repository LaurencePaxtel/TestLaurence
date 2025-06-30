C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
If (i_Confirmer("Mise à jour de la structure de données"+" ?"))
	If (Size of array:C274(ta_SP_Nom)>0)
		i_Message("Structure de données  : ")
		For ($ii; 1; Size of array:C274(ta_SP_Nom))
			i_MessageSeul("Structure de données  : "+"vérification et mise à jour - "+String:C10($ii)+"/"+String:C10(Size of array:C274(ta_SP_Nom)))
			
			
			
			$vb_OK:=F_SIAO_Var_AD(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsCS(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsSP(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsRS(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsDT(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsLG(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsDL(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsBS(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsPR(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			$vb_OK:=F_SIAO_Var_SsPP(4; tl_SP_Reference{$ii}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
			
			
		End for 
		ta_SP_Nom:=1
		$vb_OK:=F_SIAO_Var_SP(3; tl_SP_Reference{ta_SP_Nom}; 0; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_AD(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //ADRESSE
		$vb_OK:=F_SIAO_Var_SsCS(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
		$vb_OK:=F_SIAO_Var_SsSP(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
		$vb_OK:=F_SIAO_Var_SsRS(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
		$vb_OK:=F_SIAO_Var_SsDT(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
		$vb_OK:=F_SIAO_Var_SsLG(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
		$vb_OK:=F_SIAO_Var_SsDL(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
		
		$vb_OK:=F_SIAO_Var_SsBS(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
		$vb_OK:=F_SIAO_Var_SsPR(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL et suite
		$vb_OK:=F_SIAO_Var_SsPP(3; tl_SP_Reference{ta_SP_Nom}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS
		
		CLOSE WINDOW:C154
	End if 
End if 