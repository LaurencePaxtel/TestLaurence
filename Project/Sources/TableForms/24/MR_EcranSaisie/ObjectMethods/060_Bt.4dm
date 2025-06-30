//Script b_Couv
If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{50}; -><>ta_MRcs; ->[Maraude:24]MR_CouvSoc2_1:60)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{50}; -><>va_DScs_R; -><>ta_DScs; ->[Maraude:24]MR_CouvSoc2_1:60; ->[Maraude:24]MR_CouvSoc2_2:61; vPtrT1_Tri)
End if 