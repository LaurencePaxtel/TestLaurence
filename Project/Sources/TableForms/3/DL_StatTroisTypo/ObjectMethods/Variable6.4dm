
If (ta_MoisColDemande>0)
	If (ta_MoisColDemande{ta_MoisColDemande}=ta_MoisColDemande{0})
	Else 
		
		If (P_DatesMoisEnCours(1))
		End if 
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="…"
		
		
		If (ta_MoisColDemande=2)
			OBJECT SET ENABLED:C1123(bCentres; True:C214)
		Else 
			P_CritèreCentreLES(5)
			OBJECT SET ENABLED:C1123(bCentres; False:C215)
		End if 
		
		ta_MoisColDemande{0}:=ta_MoisColDemande{ta_MoisColDemande}
		
	End if 
End if 