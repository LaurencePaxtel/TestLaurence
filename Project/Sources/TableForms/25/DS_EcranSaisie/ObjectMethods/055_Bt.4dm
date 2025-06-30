//Script b_Couv
If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{54}; -><>ta_MRcs; ->[DossierSocial:25]DS_CouvSoc3_1:55)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{54}; -><>va_DScs_R; -><>ta_DScs; ->[DossierSocial:25]DS_CouvSoc3_1:55; ->[DossierSocial:25]DS_CouvSoc3_2:56; vPtrT1_Tri)
End if 