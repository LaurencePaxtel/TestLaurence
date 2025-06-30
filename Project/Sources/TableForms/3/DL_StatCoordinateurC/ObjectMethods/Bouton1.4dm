If (Form event code:C388=Sur clic:K2:4)
	
	If ([DiaLogues:3]DL_Date:2>!00-00-00!) & ([DiaLogues:3]DL_Date2:8>!00-00-00!)
		
		C_BOOLEAN:C305($B_Dummy)
		If (False:C215)
			$B_Dummy:=P_ActiviteEnCours(5)
		Else 
			
			//i_Message ("RAZ…")
			//i_MessageSeul ("Recherche en cours…")
			
			C_OBJECT:C1216($O_Objet)
			OB SET:C1220($O_Objet; "D_Date"; [DiaLogues:3]DL_Date:2)
			OB SET:C1220($O_Objet; "D_Date2"; [DiaLogues:3]DL_Date2:8)
			OB SET:C1220($O_Objet; "<>va_T_RefusCHRS"; <>va_T_RefusCHRS)
			OB SET:C1220($O_Objet; "<>va_T_RefusDEMANDEUR"; <>va_T_RefusDEMANDEUR)
			OB SET:C1220($O_Objet; "rReports"; rReports)
			OB SET ARRAY:C1227($O_Objet; "tl_ActiviteEtatcivil"; tl_ActiviteEtatcivil)
			OB SET ARRAY:C1227($O_Objet; "tl_ActiviteFiches"; tl_ActiviteFiches)
			OB SET ARRAY:C1227($O_Objet; "tl_ActivitePersonnes"; tl_ActivitePersonnes)
			
			C_LONGINT:C283($L_ref)
			If (Application type:C494=4D mode distant:K5:5)
				$L_ref:=4D_Progression_Open("")
				C_OBJECT:C1216($O_Progression)
				OB SET:C1220($O_Progression; \
					"progress ref"; $L_ref; \
					"progress titel"; "Activité"; \
					"progress message"; "Calcul en cours... "; \
					"progress compteur"; -1; \
					"progress max"; -1; \
					"progress stop"; -1\
					)
				4D_Progression_Send(->$O_Progression)
			End if 
			
			// Modifié par : Kevin HASSAL (06/12/2018)
			// On passe la valeur de la variable <>ref_soc_active
			// pour les méhodes qui s'exécutent côté serveur
			
			P_ActiviteEnCours_serveur5(->$O_Objet; <>ref_soc_active)
			
			If (Application type:C494=4D mode distant:K5:5)
				4D_Progression_Close($L_ref)
			End if 
			
			<>va_T_RefusCHRS:=OB Get:C1224($O_Objet; "<>va_T_RefusCHRS"; Est un texte:K8:3)
			<>va_T_RefusDEMANDEUR:=OB Get:C1224($O_Objet; "<>va_T_RefusDEMANDEUR"; Est un texte:K8:3)
			rReports:=OB Get:C1224($O_Objet; "rReports"; Est un entier long:K8:6)
			OB GET ARRAY:C1229($O_Objet; "tl_ActiviteEtatcivil"; tl_ActiviteEtatcivil)
			OB GET ARRAY:C1229($O_Objet; "tl_ActiviteFiches"; tl_ActiviteFiches)
			OB GET ARRAY:C1229($O_Objet; "tl_ActivitePersonnes"; tl_ActivitePersonnes)
			
			CLEAR VARIABLE:C89($O_Objet)
			
			CLOSE WINDOW:C154
		End if 
		
	End if 
End if 

