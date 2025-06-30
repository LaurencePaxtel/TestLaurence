//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 19:10:56
// ----------------------------------------------------
// Method: Web_Detect_Error
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($erreur)

ARRAY TEXT:C222($lib; 0)
ARRAY TEXT:C222($composantInterne; 0)

ARRAY LONGINT:C221($code; 0)

If (Error#0)
	GET LAST ERROR STACK:C1015($code; $composantInterne; $lib)
	
	OB SET:C1220($erreur; \
		"libelle"; $lib{1}; \
		"methode"; Error Method; \
		"ligne"; Error Line; \
		"code"; Error)
	
	If (Current user:C182="apaxtel")
		TRACE:C157
	End if 
	
End if 

Web_Error:=True:C214