If (7=8)
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{38}; -><>ta_TBPIdté; ->[DossierSocial:25]DS_Papier1:48)
End if 
//Script b_TBPidté
If (vb_MRferme=False:C215)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{38}; -><>va_DSidté_R; -><>ta_DSidté; ->[DossierSocial:25]DS_Papier1:48; ->[DossierSocial:25]DS_Papier2:49; vPtrT1_Tri)
End if 