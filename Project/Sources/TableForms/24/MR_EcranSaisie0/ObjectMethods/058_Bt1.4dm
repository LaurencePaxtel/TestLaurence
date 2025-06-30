//Script b_Couv
If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48}; -><>ta_MRcs; ->[Maraude:24]MR_CouvSoc1_1:58)
End if 

If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48}; -><>va_DScs_R; -><>ta_DScs; ->[Maraude:24]MR_CouvSoc1_1:58; ->[Maraude:24]MR_CouvSoc1_2:59; vPtrT1_Tri)
End if 