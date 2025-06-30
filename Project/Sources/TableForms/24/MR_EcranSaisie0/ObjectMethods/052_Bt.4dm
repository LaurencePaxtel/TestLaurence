If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44}; -><>ta_CpAct; ->[Maraude:24]MR_Compagnie:52)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44}; -><>va_DScomp_R; -><>ta_DScomp; ->[Maraude:24]MR_Compagnie:52; ->[Maraude:24]MR_Compagnie2:53; vPtrT1_Tri)
End if 