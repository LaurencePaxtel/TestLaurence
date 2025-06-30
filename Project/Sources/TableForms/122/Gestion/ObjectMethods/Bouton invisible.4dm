Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Case of 
			: (Num:C11(Form:C1466.goToPage)>=Form:C1466.pageMinimum) & (Num:C11(Form:C1466.goToPage)<=Form:C1466.pageMaximum)
				POST OUTSIDE CALL:C329(Current process:C322)
			: (Form:C1466.pageMinimum=Form:C1466.pageMaximum)
				ALERT:C41("La page souhaitée ne peut être que « "+String:C10(Form:C1466.pageMinimum)+" »")
			Else 
				ALERT:C41("La page souhaitée doit être compris entre « "+String:C10(Form:C1466.pageMinimum)+" » et « "+String:C10(Form:C1466.pageMaximum)+" »")
		End case 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 