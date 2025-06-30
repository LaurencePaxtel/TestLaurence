Case of 
	: (Form event code:C388=Sur après frappe clavier:K2:26)
		$texte:=Get edited text:C655
		
		If (Length:C16($texte)>0)
			OBJECT SET ENABLED:C1123(enr_rech; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(enr_rech; False:C215)
		End if 
		
End case 