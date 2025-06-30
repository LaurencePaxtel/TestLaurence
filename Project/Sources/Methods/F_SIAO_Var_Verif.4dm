//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP © DBsolutions
//{          Procédure : F_SIAO_Var_Verif
//{          Lundi 3 janvier 2011 à 12:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)


C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=1)
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=$2)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])>0)
			ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
			FIRST RECORD:C50([SIAO_Personnes:51])
			READ WRITE:C146([SIAO_Personnes:51])
			Repeat 
				If (i_NonVerrou(->[SIAO_Personnes:51]))
					If ([SIAO_Personnes:51]Sp_Age_plus:16="MiseàJour")
						
						//•• Création des pages du dossier
						ta_SIAO_PopSitFam:=3
						i_Message("Création des pages du dossier en cours : 1 / 12")
						vl_SP_Reference:=[SIAO_Personnes:51]Sp_RéférenceID:1
						vl_SP_SIAO_ID:=[SIAO_Personnes:51]Sp_SIAO_ID:2
						vl_SP_Personne_ID:=[SIAO_Personnes:51]Sp_Personne_ID:3
						
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
						[SIAO_Personnes:51]Sp_Age_plus:16:=""
						SAVE RECORD:C53([SIAO_Personnes:51])
						CLOSE WINDOW:C154
					End if 
				End if 
				NEXT RECORD:C51([SIAO_Personnes:51])
			Until (End selection:C36([SIAO_Personnes:51]))
			UNLOAD RECORD:C212([SIAO_Personnes:51])
			READ WRITE:C146([SIAO_Personnes:51])
			
		Else 
			//Pas de demandeur
		End if 
		
		
End case 