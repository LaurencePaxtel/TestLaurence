If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			[DiaLogues:3]DL_Date:2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 1; 0)
			[DiaLogues:3]DL_Date2:8:=Add to date:C393([DiaLogues:3]DL_Date2:8; 0; 1; 0)
			[DiaLogues:3]DL_Date2:8:=F_DateFinDeMois([DiaLogues:3]DL_Date2:8)
		: (Macintosh option down:C545 | Windows Alt down:C563)
			[DiaLogues:3]DL_Date:2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; -1; 0)
			[DiaLogues:3]DL_Date2:8:=Add to date:C393([DiaLogues:3]DL_Date2:8; 0; -1; 0)
			[DiaLogues:3]DL_Date2:8:=F_DateFinDeMois([DiaLogues:3]DL_Date2:8)
		Else 
			
			If (vd_LastDate>!00-00-00!)
				[DiaLogues:3]DL_Date:2:=vd_LastDate
				[DiaLogues:3]DL_Date2:8:=vd_LastDate
			Else 
				[DiaLogues:3]DL_Date:2:=Current date:C33(*)
				[DiaLogues:3]DL_Date2:8:=Current date:C33(*)
			End if 
			If (Day of:C23([DiaLogues:3]DL_Date:2+1)=1)
				[DiaLogues:3]DL_Date2:8:=[DiaLogues:3]DL_Date:2
			Else 
				[DiaLogues:3]DL_Date2:8:=F_DateFinDeMois([DiaLogues:3]DL_Date:2)
			End if 
			
	End case 
	P_HébergementProlongFind(0)
	
End if 
