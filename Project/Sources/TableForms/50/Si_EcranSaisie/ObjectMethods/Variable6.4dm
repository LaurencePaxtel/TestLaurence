C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

If (Size of array:C274(ta_SIAO_PopSitFam)>0)
	If (ta_SIAO_PopSitFam>0)
		If (ta_SIAO_PopSitFam=1)
			ALERT:C41("Vous devez choisir le type de personne à ajouter.")
		Else 
			
			If (ta_SIAO_PopSitFam=3) | (ta_SIAO_PopSitFam=4)
				If (Find in array:C230(ta_SP_SousTheme; ta_SIAO_PopSitFamCode{ta_SIAO_PopSitFam})>0)
					$vb_OK:=False:C215
					ALERT:C41("Il ne peut y avoir qu'un seule demandeur ou un seul conjoint !")
				Else 
					$vb_OK:=True:C214
				End if 
			Else 
				$vb_OK:=True:C214
			End if 
		End if 
	End if 
End if 




If ($vb_OK)
	$vb_OK:=False:C215
	va_IDT_LienFam:=""
	va_IDT_Typ1:=""
	va_IDT_Clé:=""
	va_IDT_Nom:=""
	va_IDT_Pré:=""
	vd_IDT_NéLe:=!00-00-00!
	ve_IDT_Age:=0
	ve_IDT_PCAge:=0
	x_IDTG_1:=1
	x_IDTG_2:=0
	vl_SelCleUnique_ID:=0
	va_SIAO_EtatCivil:=""
	If (F_CléUniqueSIAO_Sel(3; ->vl_CleUnique_ID; False:C215; False:C215; 1; ->vl_SelCleUnique_ID))
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_CleUnique_ID)
		MultiSoc_Filter(->[HeBerge:4])
		
		va_SIAO_EtatCivil:=""
		vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
		ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
		If (F_Tab_Pop("Etat civil"; -><>ta_SIAO_EtCiv; ->va_SIAO_EtatCivil))
			If (F_HébergementEtatCivil(va_SIAO_EtatCivil; ve_IDT_Age))
				P_TypeEtCv_Genre(va_SIAO_EtatCivil; ->x_IDTG_1; ->x_IDTG_2)
				
				If (vl_SelCleUnique_ID>0)
					//mise à jour du genre pour les nouvelles clés
					READ WRITE:C146([HeBerge:4])
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_SelCleUnique_ID)
					MultiSoc_Filter(->[HeBerge:4])
					If (Records in selection:C76([HeBerge:4])=1)
						If (i_NonVerrou(->[HeBerge:4]))
							[HeBerge:4]HG_Genre:39:=(x_IDTG_2=1)
							SAVE RECORD:C53([HeBerge:4])
						End if 
					End if 
					UNLOAD RECORD:C212([HeBerge:4])
					READ ONLY:C145([HeBerge:4])
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_SelCleUnique_ID)
					MultiSoc_Filter(->[HeBerge:4])
				End if 
				
				$vb_OK:=True:C214
			End if 
		End if 
	End if 
End if 


If ($vb_OK)
	i_Message("Création des pages du dossier en cours…")
	
	i_MessageSeul("Création des pages du dossier en cours : 1 / 12")
	$vb_OK:=F_SIAO_Var_SP(5; vl_CleUnique_ID; [SIAO:50]Si_RéférenceID:1; <>vp_SIAO_PointeurVide; 0)
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
	
	CLOSE WINDOW:C154
	
End if 