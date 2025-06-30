If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56}; -><>ta_TBPIdté; ->[Maraude:24]MR_Papier1:55)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56}; -><>va_DSidté_R; -><>ta_DSidté; ->[Maraude:24]MR_Papier1:55; ->[Maraude:24]MR_Papier2:56; vPtrT1_Tri)
End if 