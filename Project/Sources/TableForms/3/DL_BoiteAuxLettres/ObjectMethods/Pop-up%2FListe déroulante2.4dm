If (Size of array:C274(<>ta_FMGrp)>0)
	If (<>ta_FMGrp>0)
		<>va_Trans_Groupe:=<>ta_FMGrp{<>ta_FMGrp}
		If (<>vb_Trans_FicheYaDéja=False:C215) & (<>vl_Trans_CentreRéf>0) & (<>ve_Trans_NuitTotal>0) & (<>va_Trans_Groupe>"") & (<>va_Trans_Plateforme>"")
			OBJECT SET ENABLED:C1123(b_OK; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_OK; False:C215)
		End if 
		
	End if 
End if 