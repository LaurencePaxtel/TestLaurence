If (<>va_Trans_CentrePlateforme>"")
	vd_DateRecherche:=<>vd_Trans_FicheDate
	If (F_HebergementCible(3; <>vb_T_ModeCHRS; "H"; False:C215; ""; 0))
	End if 
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_CentresBauxL")
	$vl_Fenetre:=i_FenêtreNo(457; 508; 16; "Sélectionner un "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; 1; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3]; *)
	CLOSE WINDOW:C154($vl_Fenetre)
	If (vb_RecHéb)
		vb_RecHéb:=False:C215
		<>vl_Trans_CentreRéf:=[LesCentres:9]LC_RéférenceID:1
		<>va_Trans_CentreNom:=[LesCentres:9]LC_Nom:4
	End if 
	READ ONLY:C145([DiaLogues:3])
	If (<>vb_Trans_FicheYaDéja=False:C215) & (<>vl_Trans_CentreRéf>0) & (<>ve_Trans_NuitTotal>0) & (<>va_Trans_Groupe>"") & (<>va_Trans_Plateforme>"")
		OBJECT SET ENABLED:C1123(b_OK; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_OK; False:C215)
	End if 
	
End if 