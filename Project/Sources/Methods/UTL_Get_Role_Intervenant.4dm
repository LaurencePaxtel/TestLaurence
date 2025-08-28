//%attributes = {}
// ----------------------------------------------------
// Method: UTL_Get_Role_Intervenant
// Return primary group/role of current user
// ----------------------------------------------------

C_TEXT($0)

$groups:=Get group(1)
If (Size of array($groups)>0)
$0:=$groups{1}
Else 
$0:=""
End if
