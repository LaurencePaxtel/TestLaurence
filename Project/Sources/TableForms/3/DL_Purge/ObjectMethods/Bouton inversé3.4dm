If (Form event code:C388=Sur clic:K2:4)
	Case of 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			If (vd_DtDébTr>!00-00-00!)
				vd_DtDébTr:=vd_DtDébTr+1
			Else 
				vd_DtDébTr:=Current date:C33
			End if 
			If (vd_DtFinTr>!00-00-00!)
				vd_DtFinTr:=vd_DtFinTr+1
			Else 
				vd_DtFinTr:=vd_DtDébTr
			End if 
			
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If (vd_DtDébTr>!00-00-00!)
				vd_DtDébTr:=vd_DtDébTr-1
			Else 
				vd_DtDébTr:=Current date:C33
			End if 
			If (vd_DtFinTr>!00-00-00!)
				vd_DtFinTr:=vd_DtFinTr-1
			Else 
				vd_DtFinTr:=vd_DtDébTr
			End if 
		Else 
			vd_DtDébTr:=Current date:C33
			vd_DtFinTr:=vd_DtDébTr
	End case 
End if 
