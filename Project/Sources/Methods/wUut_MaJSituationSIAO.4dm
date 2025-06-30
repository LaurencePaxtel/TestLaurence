//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : wUut_MaJSituationSIAO
//{          Lundi 6 décembre 2010 à 12:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)

QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
MultiSoc_Filter(->[SIAO_Personnes:51])
If (Records in selection:C76([SIAO_Personnes:51])>0)
	ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
	FIRST RECORD:C50([SIAO_Personnes:51])
	Repeat 
		$vb_OK:=F_SIAO_Var_AD(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsCS(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsSP(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsRS(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsDT(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsLG(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsDL(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsBS(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsPR(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		$vb_OK:=F_SIAO_Var_SsPP(4; [SIAO_Personnes:51]Sp_RéférenceID:1; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
		NEXT RECORD:C51([SIAO_Personnes:51])
	Until (End selection:C36([SIAO_Personnes:51]))
End if 