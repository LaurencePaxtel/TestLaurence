If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (vd_Date1>!00-00-00!)
				vd_Date1:=vd_Date1+1
			Else 
				vd_Date1:=Current date:C33
			End if 
			
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If (vd_Date1>!00-00-00!)
				vd_Date1:=vd_Date1-1
			Else 
				vd_Date1:=Current date:C33
			End if 
			
		Else 
			vd_Date1:=Current date:C33
	End case 
	
	
	
End if 

