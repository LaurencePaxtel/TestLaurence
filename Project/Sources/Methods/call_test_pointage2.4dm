//%attributes = {}
// Method call_test_pointage2  
// 
// 
// #SYNTAX: $L_Erreur:=call_test_pointage2(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 25/01/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

LOAD RECORD:C52([HeBerge:4])  // #20180119-1
If ([HeBerge:4]HB_ReferenceID:1>0)
	
	CREATE SET:C116([HeberGement:5]; "temp")
	
	test_pointage2([HeBerge:4]HB_Clé:2)
	
	ADD TO SET:C119([HeberGement:5]; "temp")
	USE SET:C118("temp")
	CLEAR SET:C117("temp")
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
	
End if 