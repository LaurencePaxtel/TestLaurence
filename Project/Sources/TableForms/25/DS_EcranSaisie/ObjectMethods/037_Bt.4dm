If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{27}; -><>ta_CpAct; ->[DossierSocial:25]DS_Compagnie:37)
End if 
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{27}; -><>va_DScomp_R; -><>ta_DScomp; ->[DossierSocial:25]DS_Compagnie:37; ->[DossierSocial:25]DS_Compagnie2:38; vPtrT1_Tri)
End if 