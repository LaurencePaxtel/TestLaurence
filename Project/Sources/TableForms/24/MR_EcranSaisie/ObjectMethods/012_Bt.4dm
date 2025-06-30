//Script b_Sgnlt
If (vb_MRferme=False:C215)
	If (7=8)
		var $va_Sglt_R : Text
		$va_Sglt_R:="002/1@"
		Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7}; ->$va_Sglt_R; -><>ta_TBSglt; ->[Maraude:24]MR_Signalt:12; ->[Maraude:24]MR_SignaltSuite:13; vPtrT1_Tri)
	End if 
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7}; -><>va_MRsg_R; -><>ta_MRsg; ->[Maraude:24]MR_Signalt:12; ->[Maraude:24]MR_SignaltSuite:13; vPtrT1_Tri)
	
End if 
