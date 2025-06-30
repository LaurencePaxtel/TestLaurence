//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : P_SIAO_Var_Afferter
//{          Dimanche 12 décembre 2010 à 14:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
If ($1>0)
	ta_SP_Nom:=$1
	$vb_OK:=F_SIAO_Var_SP(3; tl_SP_Reference{$1}; 0; <>vp_SIAO_PointeurVide; 0)
	
	$vb_OK:=F_SIAO_Var_AD(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //ADRESSE
	$vb_OK:=F_SIAO_Var_SsCS(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
	$vb_OK:=F_SIAO_Var_SsSP(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
	$vb_OK:=F_SIAO_Var_SsRS(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
	$vb_OK:=F_SIAO_Var_SsDT(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
	$vb_OK:=F_SIAO_Var_SsLG(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
	$vb_OK:=F_SIAO_Var_SsDL(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
	
	$vb_OK:=F_SIAO_Var_SsBS(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
	$vb_OK:=F_SIAO_Var_SsPR(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL et suite
	$vb_OK:=F_SIAO_Var_SsPP(3; tl_SP_Reference{$1}; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS
	
Else 
	ta_SP_Nom:=0
	
	
	$vb_OK:=F_SIAO_Var_SP(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //PERSONNE
	$vb_OK:=F_SIAO_Var_AD(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //ADRESSE
	$vb_OK:=F_SIAO_Var_SsCS(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
	$vb_OK:=F_SIAO_Var_SsSP(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION PROFESSIONNELLE
	$vb_OK:=F_SIAO_Var_SsRS(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //RESSOURCES
	$vb_OK:=F_SIAO_Var_SsDT(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //ENDETTEMENT
	$vb_OK:=F_SIAO_Var_SsLG(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DU LOGEMENT
	$vb_OK:=F_SIAO_Var_SsDL(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
	
	$vb_OK:=F_SIAO_Var_SsBS(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
	$vb_OK:=F_SIAO_Var_SsPR(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //PRECONISATION DU PROFESSIONNEL et suite
	$vb_OK:=F_SIAO_Var_SsPP(3; 0; 0; <>vp_SIAO_PointeurVide; 0)  //PROPOSITIONS
	
	
End if 
