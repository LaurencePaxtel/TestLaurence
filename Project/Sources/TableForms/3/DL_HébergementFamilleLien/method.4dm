If (Form event code:C388=Sur chargement:K2:1)
	If (vb_EstChéf=False:C215)
		OBJECT SET ENABLED:C1123(b_NewChef; False:C215)
	End if 
End if 
