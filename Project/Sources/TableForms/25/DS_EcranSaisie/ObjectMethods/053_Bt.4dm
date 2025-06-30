//Script b_Couv
If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{52}; -><>ta_MRcs; ->[DossierSocial:25]DS_CouvSoc2_1:53)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{52}; -><>va_DScs_R; -><>ta_DScs; ->[DossierSocial:25]DS_CouvSoc2_1:53; ->[DossierSocial:25]DS_CouvSoc2_2:54; vPtrT1_Tri)
End if 