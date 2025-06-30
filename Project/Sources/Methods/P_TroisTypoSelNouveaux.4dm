//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

Case of 
	: ($1="Nuit")
		i_Message("Recherche…")
		<>vp_PointeurMois:=Get pointer:C304("tl_MoisColFicN"+String:C10($2)+"_"+String:C10($3))
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; <>vp_PointeurMois->)
		P_HébergementVeilleSort(2)
		<>vp_PointeurMois:=Get pointer:C304("va_MoisAffiché"+String:C10($2))
		vt_ColRéf_Libellé:=<>vp_PointeurMois->+" : "+"Nb. de demandes : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+<>vp_PointeurMois->+" : "+"Nb. de demandes "+("satisfaites"*Num:C11(ta_MoisColDemande=2))+("non satisfaites"*Num:C11(ta_MoisColDemande=3))
		CLOSE WINDOW:C154
		
	: ($1="New")
		If (7=8)
			ALERT:C41("Développement en cours…")
		Else 
			i_Message("Recherche…")
			<>vp_PointeurMois:=Get pointer:C304("tl_MoisColPersNew"+String:C10($2))
			
			QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; <>vp_PointeurMois->)
			P_HébergementVeilleSort(2)
			<>vp_PointeurMois:=Get pointer:C304("va_MoisAffiché"+String:C10($2))
			
			vt_ColRéf_Libellé:=<>vp_PointeurMois->+" : "+"Nouveaux : "+String:C10(Records in selection:C76([HeberGement:5]))
			vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+<>vp_PointeurMois->+" : "+"Nouveaux"
			vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+<>vp_PointeurMois->+" : "+"Nouveaux "+("satisfaits"*Num:C11(ta_MoisColDemande=2))+("non satisfaits"*Num:C11(ta_MoisColDemande=3))
			CLOSE WINDOW:C154
			
			CLOSE WINDOW:C154
		End if 
		
	: ($1="Dif")
		i_Message("Recherche…")
		<>vp_PointeurMois:=Get pointer:C304("tl_MoisColPersDif"+String:C10($2))
		
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; <>vp_PointeurMois->)
		
		
		P_HébergementVeilleSort(2)
		<>vp_PointeurMois:=Get pointer:C304("va_MoisAffiché"+String:C10($2))
		
		vt_ColRéf_Libellé:=<>vp_PointeurMois->+" : "+"Nouveaux : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+<>vp_PointeurMois->+" : "+"Personne(s) différente(s)"
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+<>vp_PointeurMois->+" : "+"Personne(s) différente(s) "+("satisfaite(s)"*Num:C11(ta_MoisColDemande=2))+("non satisfaite(s)"*Num:C11(ta_MoisColDemande=3))
		
		CLOSE WINDOW:C154
		
		
End case 