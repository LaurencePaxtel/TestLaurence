If (Form event code:C388=Sur clic:K2:4)
	
	If (Size of array:C274(<>ta_xLibellé)>0)
		
		If (<>te_xCheck{1}=1)
			
			For ($ii; 1; Size of array:C274(<>ta_xLibellé))
				<>te_xCheck{$ii}:=0
			End for 
			
		Else 
			
			For ($ii; 1; Size of array:C274(<>ta_xLibellé))
				<>te_xCheck{$ii}:=1
			End for 
			
		End if 
		
	End if 
	
End if 