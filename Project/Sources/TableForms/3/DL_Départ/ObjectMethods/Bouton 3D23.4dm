C_BOOLEAN:C305($vb_OK)
$vb_OK:=<>vb_UserMessagerie
$vb_OK:=$vb_OK | User in group:C338(Current user:C182; <>Groupe_DEVELOP)
$vb_OK:=$vb_OK | User in group:C338(Current user:C182; <>Groupe_ADMIN)
If ($vb_OK)
	Process_Go3(-><>PR_Messagerie115; "Go_Messagerie"; <>va_Messagerie115; 64; <>Va_Messagerie115)
Else 
	StrAlerte(6; "")
End if 