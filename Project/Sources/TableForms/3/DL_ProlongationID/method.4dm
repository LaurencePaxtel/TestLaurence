If (Form event code:C388=Sur chargement:K2:1)
	w1:=Num:C11(<>vb_ProLg_Prolongation)
	w2:=Num:C11(<>vb_ProLg_Prolongation=False:C215)
	r1:=Num:C11(<>vb_ProLg_FinMois)
	r2:=Num:C11(<>vb_ProLg_FinMois=False:C215)
	ve_ProLg_Le:=<>ve_ProLg_Le
	ve_ProLg_MaxMois:=<>ve_ProLg_MaxMois
	If (r1=1)
		OBJECT SET VISIBLE:C603(*; "OuBien_@"; False:C215)
		ve_ProLg_Le:=0
	Else 
		OBJECT SET VISIBLE:C603(*; "OuBien_@"; True:C214)
	End if 
	
End if 
