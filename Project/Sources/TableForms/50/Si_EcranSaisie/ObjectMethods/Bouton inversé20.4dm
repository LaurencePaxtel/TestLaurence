If (ta_SIAO_Page>1)
	ta_SIAO_Page:=ta_SIAO_Page-1
	If (ta_SIAO_Page=1)
		OBJECT SET ENABLED:C1123(b_Previous; False:C215)
	End if 
	
	If (ta_SIAO_Page<12)
		OBJECT SET ENABLED:C1123(b_Next; True:C214)
	End if 
	
	vl_SIAO_PageNo:=ta_SIAO_Page
	ta_SIAO_PageTitre:=vl_SIAO_PageNo
	te_SIAO_PageNo:=vl_SIAO_PageNo
	va_SIAO_PageTitre:=ta_SIAO_PageTitre{vl_SIAO_PageNo}
	FORM GOTO PAGE:C247(ta_SIAO_Page)
End if 