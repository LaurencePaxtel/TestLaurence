C_LONGINT:C283($vl_EventFF; $L_sub_demand_G; $L_sub_demand_H; $L_sub_demand_D; $L_sub_demand_B; $L_sub_Dossier_G; $L_sub_Dossier_H; $L_sub_Dossier_D; $L_sub_Dossier_B)

C_LONGINT:C283(v_hebergement_id)

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_IDT_CléFam:=""
		va_FrappeClavier:=""
		
		$L_SourisX:=0
		$L_SourisY:=0
		$L_SourisButton:=0
		
		P_HébergementNotesBt(0)
		
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		
		If (<>vb_T_ModeCHRS)
			wSansFiltre:=0  //19/01/2008
		Else 
			wSansFiltre:=0
		End if 
		
		OBJECT SET VISIBLE:C603(*; "Pointage_Bt"; <>vb_UserPointage)  //01/08/2012
		OBJECT SET VISIBLE:C603(wSansFiltre; User in group:C338(Current user:C182; <>Groupe_SansFiltre))
		
		SOC_Get_Config
		
		If (Not:C34(SO_DOS_Encours_Activer))
			OBJECT SET VISIBLE:C603(*; "@dossiers_encours@"; False:C215)
		End if 
		
	: ($vl_EventFF=Sur clic:K2:4) | ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468($L_SourisX; $L_SourisY; $L_SourisButton)  // #20180511-3
		
		OBJECT GET COORDINATES:C663(*; "sub_recherche_demand"; $L_sub_demand_G; $L_sub_demand_H; $L_sub_demand_D; $L_sub_demand_B)  // #20180511-3
		OBJECT GET COORDINATES:C663(*; "sub_recherche_dossier"; $L_sub_Dossier_G; $L_sub_Dossier_H; $L_sub_Dossier_D; $L_sub_Dossier_B)  // #20180511-3
		
		Case of 
			: ($L_SourisX>$L_sub_demand_G) & ($L_SourisX<$L_sub_demand_D) & ($L_SourisY>$L_sub_demand_H) & ($L_SourisY<$L_sub_demand_B)
				
				If ([HeBerge:4]HB_ReferenceID:1>0)
					va_NNN:=F_AfficheCléHébergé
					
					Rec_Hébergements1(->vL_Nb_HG_F)
					P_HébergementNotesBt(1)
					
					OBJECT SET ENABLED:C1123(b_ValHBnew; Not:C34(vb_DoubleClic))  // #20180511-3
					
					// Modified by: Kevin HASSAL (06/07/2020)
					// Pour la gestion des participations
					If ([HeBerge:4]HB_FAC_Mode_Facturation:80="Participations")
						OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; False:C215)
						OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; True:C214)
					Else 
						OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
						OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
					End if 
					
				Else 
					REDUCE SELECTION:C351([HeberGement:5]; 0)
					
					vL_Nb_HG_F:=0
					va_NNN:=""
					
					P_HébergementNotesBt(0)
					
					OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
				End if 
				
			: ($L_SourisX>$L_sub_Dossier_G) & ($L_SourisX<$L_sub_Dossier_D) & ($L_SourisY>$L_sub_Dossier_H) & ($L_SourisY<$L_sub_Dossier_B)
				
				If ($vl_EventFF=Sur clic:K2:4)
					
					If ([HeberGement:5]HG_ReferenceID:1>0)
						OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
						
						If (vb_DoubleClic=False:C215)
							OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
						End if 
						
					Else 
						OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
					End if 
					
					// Modified by: Kevin HASSAL (26/09/2019)
					v_hebergement_id:=[HeberGement:5]HG_ReferenceID:1
				Else   // double clic
					
					If ([HeberGement:5]HG_ReferenceID:1>0)
						P_HG_Localisation
					End if 
					
				End if 
				
		End case 
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		
		Case of 
			: (<>va_Appel_HGc="AppelSIAO")
				<>va_Appel_HGc:=""
				
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>vl_Appel_HGcRefHB)
				
				va_HGRNom:=[HeBerge:4]HB_Clé:2
				va_FrappeClavier:=va_HGRNom
				vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
				
				ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
				
				FIRST RECORD:C50([HeBerge:4])
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				
				vL_Nb_HG_F:=0
				va_NNN:=""
				
				P_HébergementNotesBt(0)
				
				OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		End case 
		
	: ($vl_EventFF=Sur menu sélectionné:K2:14)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
		// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
		i_MenuChoisi
End case 