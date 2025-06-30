If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{42}; -><>ta_MRrg; ->[DossierSocial:25]DS_Régime1:67)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{42}; -><>va_DSrég_R; -><>ta_DSrég; ->[DossierSocial:25]DS_Régime1:67; ->[DossierSocial:25]DS_Régime2:68; vPtrT1_Tri)
End if 