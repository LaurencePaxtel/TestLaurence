If (Size of array:C274(<>ta_Plateforme)>0)
	If (<>ta_Plateforme>0)
		<>va_Trans_Plateforme:=<>ta_Plateforme{<>ta_Plateforme}
		If (<>vb_Trans_FicheYaDéja=False:C215) & (<>vl_Trans_CentreRéf>0) & (<>ve_Trans_NuitTotal>0) & (<>va_Trans_Groupe>"")
			// ACTIVER BOUTON(b_OK)
		Else 
			// INACTIVER BOUTON(b_OK)
		End if 
		
	End if 
End if 