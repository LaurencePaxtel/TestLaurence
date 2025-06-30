If (Form event code:C388=Sur clic:K2:4)
	P_HébergementProlongFind(2)
	POST CLICK:C466(20; 145)
	If ([GrouPe:36]GP_ReferenceID:1>0)
		P_Tab_PR(4; 0)
	Else 
		P_Tab_PR(0; 0)
	End if 
End if 