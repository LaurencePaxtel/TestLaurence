//%attributes = {}
// ----------------------------------------------------
// Method: UTL_Normalize_Login
// Normalize a login string (trim and uppercase)
// ----------------------------------------------------

C_TEXT($1;$0)

$0:=Uppercase(Trim($1))
