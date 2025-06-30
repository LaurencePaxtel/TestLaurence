If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (vd_DtDéb>!00-00-00!)
				vd_DtDéb:=vd_DtDéb+1
			Else 
				vd_DtDéb:=Current date:C33
			End if 
			If (vd_DtFin>!00-00-00!)
				vd_DtFin:=vd_DtFin+1
			Else 
				vd_DtFin:=vd_DtDéb
			End if 
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If (vd_DtDéb>!00-00-00!)
				vd_DtDéb:=vd_DtDéb-1
			Else 
				vd_DtDéb:=Current date:C33
			End if 
			If (vd_DtFin>!00-00-00!)
				vd_DtFin:=vd_DtFin-1
			Else 
				vd_DtFin:=vd_DtDéb
			End if 
		Else 
			vd_DtDéb:=Current date:C33
			vd_DtFin:=vd_DtDéb
	End case 
End if 
