//%attributes = {}
// ----------------------------------------------------
// Method: UTL_Segur_Actif
// Return TRUE if Segur option is enabled in settings table
// ----------------------------------------------------

C_BOOLEAN($0)

$settings:=ds.RaisonSociale.all().first()
If ($settings#Null)
$0:=($settings.Segur=1)
Else
$0:=False
End if
