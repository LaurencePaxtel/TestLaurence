//Script b_Couv
If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{52}; -><>ta_MRcs; ->[Maraude:24]MR_CouvSoc3_1:62)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{52}; -><>va_DScs_R; -><>ta_DScs; ->[Maraude:24]MR_CouvSoc3_1:62; ->[Maraude:24]MR_CouvSoc3_2:63; vPtrT1_Tri)
End if 