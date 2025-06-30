//Script b_Couv
If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{50}; -><>ta_MRcs; ->[DossierSocial:25]DS_CouvSoc1_1:51)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{50}; -><>va_DScs_R; -><>ta_DScs; ->[DossierSocial:25]DS_CouvSoc1_1:51; ->[DossierSocial:25]DS_CouvSoc1_2:52; vPtrT1_Tri)
End if 