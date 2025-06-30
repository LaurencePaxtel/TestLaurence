If (Form event code:C388=Sur clic:K2:4)
	
	If (False:C215)
		C_BOOLEAN:C305($B_Dummy)
		
		$B_Dummy:=P_TranchesEnCours(5)
	Else 
		C_LONGINT:C283($L_ref)
		C_OBJECT:C1216($O_Progression; $O_Objet)
		
		D_Date:=[DiaLogues:3]DL_Date:2
		D_Date2:=[DiaLogues:3]DL_Date2:8
		
		If (Application type:C494=4D mode distant:K5:5)
			$L_ref:=4D_Progression_Open("")
			
			OB SET:C1220($O_Progression; \
				"progress ref"; $L_ref; \
				"progress titel"; "Supervision par tranche"; \
				"progress message"; "Statistique du "+String:C10(D_Date)+" au "+String:C10(D_Date2); \
				"progress compteur"; -1; \
				"progress max"; -1; \
				"progress stop"; -1)
			
			4D_Progression_Send(->$O_Progression)
		End if 
		
		If (True:C214)
			OB SET:C1220($O_Objet; "vl_MoisLigneEtatCivil"; vl_MoisLigneEtatCivil)
			OB SET:C1220($O_Objet; "date"; [DiaLogues:3]DL_Date:2)
			OB SET:C1220($O_Objet; "date2"; [DiaLogues:3]DL_Date2:8)
			
			// Modifié par : Scanu Rémy - remy@connect-io.fr (15/04/2021)    
			$O_Objet.trancheDemande:=ta_TrancheDemande
			
			OB SET ARRAY:C1227($O_Objet; "ta_TrancheDemande"; ta_TrancheDemande)
			OB SET ARRAY:C1227($O_Objet; "te_TrancheAfficheDebut"; te_TrancheAfficheDebut)
			OB SET ARRAY:C1227($O_Objet; "te_TrancheAfficheFin"; te_TrancheAfficheFin)
			OB SET ARRAY:C1227($O_Objet; "te_xCentre"; te_xCentre)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheHGTemp"; tl_TrancheHGTemp)
			OB SET ARRAY:C1227($O_Objet; "tl_TrancheOK"; tl_TrancheOK)
			OB SET ARRAY:C1227($O_Objet; "tl_TranchePersOld"; tl_TranchePersOld)
			OB SET ARRAY:C1227($O_Objet; "tl_xCentre"; tl_xCentre)
			
			OB SET:C1220($O_Objet; "vl_TrancheCol1"; vl_TrancheCol1)
			OB SET:C1220($O_Objet; "vl_TrancheCol10"; vl_TrancheCol10)
			OB SET:C1220($O_Objet; "vl_TrancheCol11"; vl_TrancheCol11)
			OB SET:C1220($O_Objet; "vl_TrancheCol12"; vl_TrancheCol12)
			OB SET:C1220($O_Objet; "vl_TrancheCol2"; vl_TrancheCol2)
			OB SET:C1220($O_Objet; "vl_TrancheCol3"; vl_TrancheCol3)
			OB SET:C1220($O_Objet; "vl_TrancheCol4"; vl_TrancheCol4)
			OB SET:C1220($O_Objet; "vl_TrancheCol5"; vl_TrancheCol5)
			OB SET:C1220($O_Objet; "vl_TrancheCol6"; vl_TrancheCol6)
			OB SET:C1220($O_Objet; "vl_TrancheCol7"; vl_TrancheCol7)
			OB SET:C1220($O_Objet; "vl_TrancheCol8"; vl_TrancheCol8)
			OB SET:C1220($O_Objet; "vl_TrancheCol9"; vl_TrancheCol9)
			OB SET:C1220($O_Objet; "vl_TrancheColTotal"; vl_TrancheColTotal)
			OB SET:C1220($O_Objet; "vl_TrancheLigneEtatCivil"; vl_TrancheLigneEtatCivil)
		End if 
		
		// Modifié par : Kevin HASSAL (06/12/2018)
		// On passe la valeur de la variable <>ref_soc_active
		// pour les méhodes qui s'exécutent côté serveur
		P_TranchesEnCours_server5(->$O_Objet; <>ref_soc_active)
		
		If (True:C214)
			OB GET ARRAY:C1229($O_Objet; "ta_TrancheDemande"; ta_TrancheDemande)
			OB GET ARRAY:C1229($O_Objet; "te_TrancheAfficheDebut"; te_TrancheAfficheDebut)
			OB GET ARRAY:C1229($O_Objet; "te_TrancheAfficheFin"; te_TrancheAfficheFin)
			OB GET ARRAY:C1229($O_Objet; "te_xCentre"; te_xCentre)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheHGTemp"; tl_TrancheHGTemp)
			OB GET ARRAY:C1229($O_Objet; "tl_TrancheOK"; tl_TrancheOK)
			OB GET ARRAY:C1229($O_Objet; "tl_TranchePersOld"; tl_TranchePersOld)
			OB GET ARRAY:C1229($O_Objet; "tl_xCentre"; tl_xCentre)
			
			vl_TrancheCol1:=OB Get:C1224($O_Objet; "vl_TrancheCol1"; Est un entier long:K8:6)
			vl_TrancheCol10:=OB Get:C1224($O_Objet; "vl_TrancheCol10"; Est un entier long:K8:6)
			vl_TrancheCol11:=OB Get:C1224($O_Objet; "vl_TrancheCol11"; Est un entier long:K8:6)
			vl_TrancheCol12:=OB Get:C1224($O_Objet; "vl_TrancheCol12"; Est un entier long:K8:6)
			vl_TrancheCol2:=OB Get:C1224($O_Objet; "vl_TrancheCol2"; Est un entier long:K8:6)
			vl_TrancheCol3:=OB Get:C1224($O_Objet; "vl_TrancheCol3"; Est un entier long:K8:6)
			vl_TrancheCol4:=OB Get:C1224($O_Objet; "vl_TrancheCol4"; Est un entier long:K8:6)
			vl_TrancheCol5:=OB Get:C1224($O_Objet; "vl_TrancheCol5"; Est un entier long:K8:6)
			vl_TrancheCol6:=OB Get:C1224($O_Objet; "vl_TrancheCol6"; Est un entier long:K8:6)
			vl_TrancheCol7:=OB Get:C1224($O_Objet; "vl_TrancheCol7"; Est un entier long:K8:6)
			vl_TrancheCol8:=OB Get:C1224($O_Objet; "vl_TrancheCol8"; Est un entier long:K8:6)
			vl_TrancheCol9:=OB Get:C1224($O_Objet; "vl_TrancheCol9"; Est un entier long:K8:6)
			vl_TrancheColTotal:=OB Get:C1224($O_Objet; "vl_TrancheColTotal"; Est un entier long:K8:6)
			vl_TrancheLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_TrancheLigneEtatCivil"; Est un entier long:K8:6)
		End if 
		
		CLOSE WINDOW:C154
		BEEP:C151
		
		4D_Progression_Close($L_ref)
	End if 
	
End if 