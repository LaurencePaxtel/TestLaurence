//%attributes = {}
// ----------------------------------------------------
// Method: UTL_ISO_Now
// Returns current date/time in ISO 8601 format
// ----------------------------------------------------

C_TEXT($0)

$0:=ISO Date(Current date)+"T"+ISO Time(Current time)
