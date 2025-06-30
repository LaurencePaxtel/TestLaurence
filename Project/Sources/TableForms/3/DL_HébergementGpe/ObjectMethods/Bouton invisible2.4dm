Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Records in selection:C76([HeberGement:5])>0)
			F_Passages(1; 0)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 