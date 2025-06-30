//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15/02/20, 08:21:23
// ----------------------------------------------------
// Method: MAIL_Check_Error
// Description
// 
//
// Parameters
// ----------------------------------------------------

If ($1=-1000000000)
	ARRAY LONGINT:C221(tb_error; 0)
	ARRAY TEXT:C222(tb_function; 0)
	ARRAY TEXT:C222(tb_lib_er; 0)
	MAIL_Send_Check_Error
Else 
	If ($1>0)
		APPEND TO ARRAY:C911(tb_error; $1)
		APPEND TO ARRAY:C911(tb_function; $2)
		$ou:=Find in array:C230(tb_ref_erreur; $1)
		If ($ou>0)
			APPEND TO ARRAY:C911(tb_lib_er; tb_txt_erreur{$ou})
		Else 
			APPEND TO ARRAY:C911(tb_lib_er; String:C10($1))
		End if 
	End if 
End if 