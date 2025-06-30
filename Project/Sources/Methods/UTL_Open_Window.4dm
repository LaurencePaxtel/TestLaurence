//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/01/20, 17:44:59
// ----------------------------------------------------
// Method: UTL_Open_Window
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($ref_el)

$ref_el:=Open form window:C675($1->; $2; Form fenêtre palette:K39:9; Centrée verticalement:K39:4; *)
DIALOG:C40($1->; $2)

CLOSE WINDOW:C154($ref_el)