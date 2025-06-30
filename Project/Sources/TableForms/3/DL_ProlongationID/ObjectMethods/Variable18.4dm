If (Form event code:C388=Sur clic:K2:4)
	<>vb_ProLg_Prolongation:=(w1=1)
	<>vb_AvecProlongation:=<>vb_ProLg_Prolongation
	<>vb_ProLg_FinMois:=(r1=1)
	<>ve_ProLg_Le:=ve_ProLg_Le
	<>ve_ProLg_MaxMois:=ve_ProLg_MaxMois
	$vb_OK:=True:C214
	
	If (<>vb_ProLg_FinMois=False:C215)
		If (<>ve_ProLg_Le>0) & (<>ve_ProLg_Le<=28)
		Else 
			REJECT:C38
		End if 
	End if 
	
	DébutInitProLg(1)
End if 