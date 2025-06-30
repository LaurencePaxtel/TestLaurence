//%attributes = {}
$va_LibD:=Request:C163("Vous allez en utilisation directe."+Char:C90(13)+"Tapez le mot de passe."; "")
If (OK=1)
	If ($va_LibD="SGBDPAXTEL")
		<>vb_UtDirect:=False:C215
		CANCEL:C270
		i_PPrincipalShow
	Else 
		ALERT:C41("Mauvais mot de passe !")
	End if 
End if 