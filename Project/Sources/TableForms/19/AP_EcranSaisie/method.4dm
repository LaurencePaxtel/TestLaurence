If (Form event code:C388=Sur chargement:K2:1)
	
	If (Is new record:C668([APpels:19]))
		[APpels:19]AP_UserID:1:=<>vl_UserRéfU
		[APpels:19]AP_Date:2:=Current date:C33
		[APpels:19]AP_Heure:3:=Current time:C178
		
		If ([APpels:19]AP_Heure:3>=?08:00:00?) & ([APpels:19]AP_Heure:3<=?20:00:00?)
			[APpels:19]AP_Nuit:4:=False:C215
		Else 
			[APpels:19]AP_Nuit:4:=True:C214
		End if 
		
		[APpels:19]AP_Libellé:5:=<>ta_Appels{<>ta_Appels}
		[APpels:19]Ref_Structure:7:=<>ref_soc_active
	Else 
		
		If (Size of array:C274(<>ta_Appels)>0)
			<>ta_Appels:=Find in array:C230(<>ta_Appels; [APpels:19]AP_Libellé:5)
		End if 
		
	End if 
	
End if 