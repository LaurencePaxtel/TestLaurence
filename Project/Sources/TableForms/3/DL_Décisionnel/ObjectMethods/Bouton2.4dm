If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If ([DiaLogues:3]DL_Date:2>!00-00-00!)
				[DiaLogues:3]DL_Date:2:=[DiaLogues:3]DL_Date:2+1
			Else 
				[DiaLogues:3]DL_Date:2:=Current date:C33
			End if 
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If ([DiaLogues:3]DL_Date:2>!00-00-00!)
				[DiaLogues:3]DL_Date:2:=[DiaLogues:3]DL_Date:2-1
			Else 
				[DiaLogues:3]DL_Date:2:=Current date:C33
			End if 
		Else 
			[DiaLogues:3]DL_Date:2:=Current date:C33
	End case 
End if 
