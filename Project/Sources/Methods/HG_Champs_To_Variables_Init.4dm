//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21/02/20, 08:39:14
// ----------------------------------------------------
// Method: HG_Champs_To_Variables_Init
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i)


For ($i; 1; Get last field number:C255(->[HeberGement:5]))
	
	If (Is field number valid:C1000(->[HeberGement:5]; $i))
		
		EXECUTE FORMULA:C63("var_"+Field name:C257(Table:C252(->[HeberGement:5]); $i)+"+:=[HeberGement]"+Field name:C257(Table:C252(->[HeberGement:5]); $i))
		
	End if 
	
End for 
