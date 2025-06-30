If (Size of array:C274(ta_SIAO_Page)>0)
	If (ta_SIAO_Page>0)
		FORM GOTO PAGE:C247(te_SIAO_PageNo{ta_SIAO_Page})
		va_SIAO_PageTitre:=ta_SIAO_PageTitre{ta_SIAO_Page}
		
		OBJECT SET ENABLED:C1123(b_Next; True:C214)
		OBJECT SET ENABLED:C1123(b_Previous; True:C214)
		If (ta_SIAO_Page=12)
			OBJECT SET ENABLED:C1123(b_Next; False:C215)
		End if 
		If (ta_SIAO_Page=1)
			OBJECT SET ENABLED:C1123(b_Previous; False:C215)
		End if 
		
	End if 
End if 
