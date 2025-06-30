If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (vd_DtDébL>!00-00-00!)
				vd_DtDébL:=vd_DtDébL+1
			Else 
				vd_DtDébL:=Current date:C33
			End if 
			If (vd_DtFinL>!00-00-00!)
				vd_DtFinL:=vd_DtFinL+1
			Else 
				vd_DtFinL:=vd_DtDébL
			End if 
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If (vd_DtDébL>!00-00-00!)
				vd_DtDébL:=vd_DtDébL-1
			Else 
				vd_DtDébL:=Current date:C33
			End if 
			If (vd_DtFinL>!00-00-00!)
				vd_DtFinL:=vd_DtFinL-1
			Else 
				vd_DtFinL:=vd_DtDébL
			End if 
		Else 
			vd_DtDébL:=Current date:C33
			vd_DtFinL:=vd_DtDébL
	End case 
End if 
