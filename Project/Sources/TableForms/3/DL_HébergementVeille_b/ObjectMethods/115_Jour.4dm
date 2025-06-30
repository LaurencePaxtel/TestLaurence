If (Form event code:C388=Sur clic:K2:4)
	
	If (<>vb_T_ModeCHRS)
		OBJECT SET VISIBLE:C603(rSurDateEcheance; False:C215)
		
		rSurDateEcheance:=0
	End if 
	
	P_HébergementVeilleFind
End if 