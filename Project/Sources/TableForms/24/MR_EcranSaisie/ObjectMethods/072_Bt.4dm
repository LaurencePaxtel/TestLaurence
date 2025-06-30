If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68}; -><>ta_MRrg; ->[Maraude:24]MR_Régime1:72)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68}; -><>va_DSrég_R; -><>ta_DSrég; ->[Maraude:24]MR_Régime1:72; ->[Maraude:24]MR_Régime2:73; vPtrT1_Tri)
End if 