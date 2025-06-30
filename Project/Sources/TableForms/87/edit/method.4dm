Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If ([Factures:86]FAC_Cloture:10)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "btn_annuler"; True:C214)
			OBJECT SET ENABLED:C1123(*; "tab@"; True:C214)
		End if 
		
		If ([Factures:86]FAC_Montant_TTC:8<=0)
			OBJECT SET ENABLED:C1123(*; "@"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "@"; True:C214)
		End if 
		
End case 