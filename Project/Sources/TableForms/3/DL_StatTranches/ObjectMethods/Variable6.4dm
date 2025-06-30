
If (ta_TrancheDemande>0)
	If (ta_TrancheDemande{ta_TrancheDemande}=ta_TrancheDemande{0})
	Else 
		
		If (P_TranchesEnCours(2))
		End if 
		
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vt_ColRéf_Libellé:="…"
		
		
		If (ta_TrancheDemande=2)
			OBJECT SET ENABLED:C1123(b_Centres; True:C214)
		Else 
			P_CritèreCentre(3)
			OBJECT SET ENABLED:C1123(b_Centres; False:C215)
		End if 
		
		ta_TrancheDemande{0}:=ta_TrancheDemande{ta_TrancheDemande}
		
	End if 
End if 