//%attributes = {}
// ----------------------------------------------------
// Method: UTL_Get_Intervenant_Courant
// Return normalized login of current user
// ----------------------------------------------------

C_TEXT($0)

$0:=UTL_Normalize_Login(Current user)
