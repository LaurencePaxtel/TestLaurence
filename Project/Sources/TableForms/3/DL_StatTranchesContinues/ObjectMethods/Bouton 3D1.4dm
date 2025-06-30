If (Form event code:C388=Sur clic:K2:4)
	If (False:C215)
		
		
	Else 
		
		C_OBJECT:C1216($O_Objet)
		OB SET:C1220($O_Objet; "date"; [DiaLogues:3]DL_Date:2)
		OB SET:C1220($O_Objet; "date2"; [DiaLogues:3]DL_Date2:8)
		
		OB SET:C1220($O_Objet; "vt_ColRéf_LibelléRupture"; vt_ColRéf_LibelléRupture)
		OB SET:C1220($O_Objet; "vL_NbFichesRupture"; vL_NbFichesRupture)
		OB SET:C1220($O_Objet; "vl_TrancheLigneEtatCivil"; vl_TrancheLigneEtatCivil)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
		OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
		OB SET ARRAY:C1227($O_Objet; "tl_HGRupture"; tl_HGRupture)
		
		OB SET ARRAY:C1227($O_Objet; "te_TrancheAfficheDebut"; te_TrancheAfficheDebut)
		OB SET ARRAY:C1227($O_Objet; "te_TrancheAfficheFin"; te_TrancheAfficheFin)
		
		C_LONGINT:C283($L_ref)
		If (Application type:C494=4D mode distant:K5:5)
			$L_ref:=4D_Progression_Open("")
			C_OBJECT:C1216($O_Progression)
			OB SET:C1220($O_Progression; \
				"progress ref"; $L_ref; \
				"progress titel"; "Supervision durée prise en charge"; \
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
		
		P_TranchesDureeSansInter(->$O_Objet; <>ref_soc_active)
		
		If (Application type:C494=4D mode distant:K5:5)
			4D_Progression_Close($L_ref)
		End if 
		
		CLOSE WINDOW:C154
		
		C_OBJECT:C1216($O_Objet)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
		OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
		OB GET ARRAY:C1229($O_Objet; "tl_HGRupture"; tl_HGRupture)
		vl_TrancheCol1:=OB Get:C1224($O_Objet; "vl_TrancheCol1")
		vl_TrancheCol2:=OB Get:C1224($O_Objet; "vl_TrancheCol2")
		vl_TrancheCol3:=OB Get:C1224($O_Objet; "vl_TrancheCol3")
		vl_TrancheCol4:=OB Get:C1224($O_Objet; "vl_TrancheCol4")
		vl_TrancheCol5:=OB Get:C1224($O_Objet; "vl_TrancheCol5")
		vl_TrancheCol6:=OB Get:C1224($O_Objet; "vl_TrancheCol6")
		vl_TrancheCol7:=OB Get:C1224($O_Objet; "vl_TrancheCol7")
		vl_TrancheCol8:=OB Get:C1224($O_Objet; "vl_TrancheCol8")
		vl_TrancheCol9:=OB Get:C1224($O_Objet; "vl_TrancheCol9")
		vl_TrancheCol10:=OB Get:C1224($O_Objet; "vl_TrancheCol10")
		vl_TrancheCol11:=OB Get:C1224($O_Objet; "vl_TrancheCol11")
		vl_TrancheCol12:=OB Get:C1224($O_Objet; "vl_TrancheCol12")
		vt_ColRéf_LibelléRupture:=OB Get:C1224($O_Objet; "vt_ColRéf_LibelléRupture")
		vL_NbFichesRupture:=OB Get:C1224($O_Objet; "vL_NbFichesRupture")
		vl_TrancheLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_TrancheLigneEtatCivil")
	End if 
	
	
	
	OBJECT SET VISIBLE:C603(b_Voir; (vL_NbFichesRupture>0))
End if 
