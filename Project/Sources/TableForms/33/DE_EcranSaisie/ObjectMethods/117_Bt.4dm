
_O_CREATE SUBRECORD:C72([DossierSante:33]DE_Examens:117)
[DossierSante]DE_Examens'Date:=Current date:C33
$Pos:=Find in array:C230(<>ta_InMéd; <>va_User)
If ($Pos>0)
	[DossierSante]DE_Examens'Médecin:=<>va_User
End if 