If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (vd_DtDébR>!00-00-00!)
				vd_DtDébR:=vd_DtDébR+1
			Else 
				vd_DtDébR:=Current date:C33
			End if 
			If (vd_DtFinR>!00-00-00!)
				vd_DtFinR:=vd_DtFinR+1
			Else 
				vd_DtFinR:=vd_DtDébR
			End if 
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If (vd_DtDébR>!00-00-00!)
				vd_DtDébR:=vd_DtDébR-1
			Else 
				vd_DtDébR:=Current date:C33
			End if 
			If (vd_DtFinR>!00-00-00!)
				vd_DtFinR:=vd_DtFinR-1
			Else 
				vd_DtFinR:=vd_DtDébR
			End if 
		Else 
			vd_DtDébR:=Current date:C33
			vd_DtFinR:=vd_DtDébR
	End case 
End if 
