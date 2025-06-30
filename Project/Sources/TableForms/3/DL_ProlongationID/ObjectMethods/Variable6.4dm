If (Form event code:C388=Sur clic:K2:4)
	If (r1=1)
		OBJECT SET VISIBLE:C603(*; "OuBien_@"; False:C215)
		ve_ProLg_Le:=0
	Else 
		OBJECT SET VISIBLE:C603(*; "OuBien_@"; True:C214)
	End if 
End if 