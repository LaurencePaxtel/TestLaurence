If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{46}; -><>ta_MRss; ->[DossierSocial:25]DS_SuiviS1:70)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{46}; -><>va_DSsuivi_R; -><>ta_DSsuivi; ->[DossierSocial:25]DS_SuiviS1:70; ->[DossierSocial:25]DS_SuiviS2:71; vPtrT1_Tri)
End if 