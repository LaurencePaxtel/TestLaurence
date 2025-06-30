
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($pos)
		
		
		$pos:=Find in array:C230(<>ta_TVA; String:C10([LesCentres:9]LC_TVA_2:75))
		If ($pos>0)
			<>ta_TVA:=$pos
		End if 
		
	Else 
		[LesCentres:9]LC_TVA_2:75:=Num:C11(<>ta_TVA{<>ta_TVA})
End case 

