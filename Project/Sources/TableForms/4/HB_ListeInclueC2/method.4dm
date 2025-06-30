If (Form event code:C388=Sur affichage corps:K2:22)
	
	If ([HeBerge:4]HB_ReferenceID:1>0)
		
		vl_NbHGi:=0  // #20180421-1
		vl_NbSii:=0
		
		// Modified by: Kevin HASSAL (26/09/2019)
		// Pour régler le bug d'affichage de nombre des fiches d'hébergement
		// l'ancien code commenté ci-dessous ne fonctionne pas correctelent et a été remplacé 
		// par la méthode HEB_Get_Nb_hebergements ci-dessous
		
		//SET QUERY DESTINATION(Into variable;vl_NbHGi)
		//QUERY([HeberGement];[HeberGement]HG_HB_ID=[HeBerge]HB_ReferenceID)
		//MultiSoc_Filter (->[HeberGement])
		
		vl_NbHGi:=HEB_Get_Nb_hebergements([HeBerge:4]HB_ReferenceID:1)
		vL_Nb_HG_F:=vl_NbHGi
		
		SET QUERY DESTINATION:C396(Vers variable:K19:4; vl_NbSii)
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demandeur_ID:21=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[SIAO:50])
		
		SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
		
		ve_NbSP:=Num:C11([HeBerge:4]HB_Status:18)
		
		vl_NbSii:=F_SiaoEnCours([HeBerge:4]HB_ReferenceID:1)
		
	End if 
	
End if 