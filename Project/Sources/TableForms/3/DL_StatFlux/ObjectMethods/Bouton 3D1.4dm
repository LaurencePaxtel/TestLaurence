If (Form event code:C388=Sur clic:K2:4)
	
	If (False:C215)
		C_BOOLEAN:C305($B_Dummy)
		$B_Dummy:=P_FluxEnCours(5)
	Else 
		//i_Message ("RAZ…")
		//i_MessageSeul ("Recherche en cours…")
		
		C_OBJECT:C1216($O_Objet)
		If (True:C214)
			OB SET:C1220($O_Objet; "date"; [DiaLogues:3]DL_Date:2)
			OB SET:C1220($O_Objet; "date2"; [DiaLogues:3]DL_Date2:8)
			
			OB SET ARRAY:C1227($O_Objet; "te_xCentre"; te_xCentre)
			OB SET ARRAY:C1227($O_Objet; "tl_xCentre"; tl_xCentre)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxFirst"; tl_FluxFirst)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP"; tl_FluxFirstP)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_1"; tl_FluxFirstP_1)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_2"; tl_FluxFirstP_2)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_3"; tl_FluxFirstP_3)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxFirstP_4"; tl_FluxFirstP_4)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxIn"; tl_FluxIn)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxInP"; tl_FluxInP)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxInP_1"; tl_FluxInP_1)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxInP_2"; tl_FluxInP_2)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxInP_3"; tl_FluxInP_3)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxLast"; tl_FluxLast)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP"; tl_FluxLastP)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_1"; tl_FluxLastP_1)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_2"; tl_FluxLastP_2)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_3"; tl_FluxLastP_3)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxLastP_4"; tl_FluxLastP_4)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOut"; tl_FluxOut)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN"; tl_FluxOutN)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_1"; tl_FluxOutN_1)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_2"; tl_FluxOutN_2)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_3"; tl_FluxOutN_3)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutN_4"; tl_FluxOutN_4)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP"; tl_FluxOutP)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_1"; tl_FluxOutP_1)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_2"; tl_FluxOutP_2)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_3"; tl_FluxOutP_3)
			OB SET ARRAY:C1227($O_Objet; "tl_FluxOutP_4"; tl_FluxOutP_4)
			OB SET:C1220($O_Objet; "vl_FluxFirst"; vl_FluxFirst)
			OB SET:C1220($O_Objet; "vl_FluxFirstP"; vl_FluxFirstP)
			OB SET:C1220($O_Objet; "vl_FluxIn"; vl_FluxIn)
			OB SET:C1220($O_Objet; "vl_FluxInP"; vl_FluxInP)
			OB SET:C1220($O_Objet; "vl_FluxLast"; vl_FluxLast)
			OB SET:C1220($O_Objet; "vl_FluxLastP"; vl_FluxLastP)
			OB SET:C1220($O_Objet; "vl_FluxOut"; vl_FluxOut)
			OB SET:C1220($O_Objet; "vl_FluxOutN"; vl_FluxOutN)
			OB SET:C1220($O_Objet; "vl_FluxOutP"; vl_FluxOutP)
			OB SET:C1220($O_Objet; "vl_TrancheLigneEtatCivil"; vl_TrancheLigneEtatCivil)
			OB SET:C1220($O_Objet; "vl_MoisLigneEtatCivil"; vl_MoisLigneEtatCivil)
		End if 
		
		If (Application type:C494=4D mode distant:K5:5)
			
			C_LONGINT:C283($L_ref)
			$L_ref:=4D_Progression_Open("")
			
			C_OBJECT:C1216($O_Progression)
			OB SET:C1220($O_Progression; \
				"progress ref"; $L_ref; \
				"progress titel"; "Supervision des flux"; \
				"progress message"; "Calcul... "; \
				"progress compteur"; -1; \
				"progress max"; -1; \
				"progress stop"; -1\
				)
			4D_Progression_Send(->$O_Progression)
		End if 
		
		// Modifié par : Kevin HASSAL (06/12/2018)
		// On passe la valeur de la variable <>ref_soc_active
		// pour les méhodes qui s'exécutent côté serveur
		
		P_FluxEnCours_serveur5(->$O_Objet; <>ref_soc_active)
		
		If (Application type:C494=4D mode distant:K5:5)
			
			4D_Progression_Close($L_ref)
		End if 
		
		If (True:C214)
			OB GET ARRAY:C1229($O_Objet; "te_xCentre"; te_xCentre)
			OB GET ARRAY:C1229($O_Objet; "tl_xCentre"; tl_xCentre)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxFirst"; tl_FluxFirst)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP"; tl_FluxFirstP)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_1"; tl_FluxFirstP_1)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_2"; tl_FluxFirstP_2)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_3"; tl_FluxFirstP_3)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxFirstP_4"; tl_FluxFirstP_4)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxIn"; tl_FluxIn)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxInP"; tl_FluxInP)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxInP_1"; tl_FluxInP_1)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxInP_2"; tl_FluxInP_2)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxInP_3"; tl_FluxInP_3)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxLast"; tl_FluxLast)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP"; tl_FluxLastP)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_1"; tl_FluxLastP_1)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_2"; tl_FluxLastP_2)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_3"; tl_FluxLastP_3)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxLastP_4"; tl_FluxLastP_4)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOut"; tl_FluxOut)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN"; tl_FluxOutN)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_1"; tl_FluxOutN_1)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_2"; tl_FluxOutN_2)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_3"; tl_FluxOutN_3)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutN_4"; tl_FluxOutN_4)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP"; tl_FluxOutP)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_1"; tl_FluxOutP_1)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_2"; tl_FluxOutP_2)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_3"; tl_FluxOutP_3)
			OB GET ARRAY:C1229($O_Objet; "tl_FluxOutP_4"; tl_FluxOutP_4)
			vl_FluxFirst:=OB Get:C1224($O_Objet; "vl_FluxFirst"; Est un entier long:K8:6)
			vl_FluxFirstP:=OB Get:C1224($O_Objet; "vl_FluxFirstP"; Est un entier long:K8:6)
			vl_FluxIn:=OB Get:C1224($O_Objet; "vl_FluxIn"; Est un entier long:K8:6)
			vl_FluxInP:=OB Get:C1224($O_Objet; "vl_FluxInP"; Est un entier long:K8:6)
			vl_FluxLast:=OB Get:C1224($O_Objet; "vl_FluxLast"; Est un entier long:K8:6)
			vl_FluxLastP:=OB Get:C1224($O_Objet; "vl_FluxLastP"; Est un entier long:K8:6)
			vl_FluxOut:=OB Get:C1224($O_Objet; "vl_FluxOut"; Est un entier long:K8:6)
			vl_FluxOutN:=OB Get:C1224($O_Objet; "vl_FluxOutN"; Est un entier long:K8:6)
			vl_FluxOutP:=OB Get:C1224($O_Objet; "vl_FluxOutP"; Est un entier long:K8:6)
			vl_TrancheLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_TrancheLigneEtatCivil"; Est un entier long:K8:6)
		End if 
		
		CLEAR VARIABLE:C89($O_Objet)
		
		CLOSE WINDOW:C154
	End if 
	
End if 
