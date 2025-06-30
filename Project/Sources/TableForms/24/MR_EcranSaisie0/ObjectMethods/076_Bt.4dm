If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72}; -><>ta_MRss; ->[Maraude:24]MR_SuiviS1:76)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72}; -><>va_DSsuivi_R; -><>ta_DSsuivi; ->[Maraude:24]MR_SuiviS1:76; ->[Maraude:24]MR_SuiviS2:77; vPtrT1_Tri)
End if 