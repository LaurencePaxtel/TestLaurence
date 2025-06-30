If (7=8)
	If (Form event code:C388=Sur après frappe clavier:K2:26)
		P_HébergementProlongFind(3)  //(3)
		POST CLICK:C466(20; 145)
		If ([GrouPe:36]GP_ReferenceID:1>0)
			P_Tab_PR(4; 0)
		Else 
			P_Tab_PR(0; 0)
		End if 
	End if 
End if 
