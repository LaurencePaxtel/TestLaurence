// Method Dupliquer_Hebergement.col_check  
// 
// 
// #SYNTAX: $L_Erreur:=Dupliquer_Hebergement.col_check(param_1;->param_N) 
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

// #DATE CREATION: 31/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

Case of 
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		Dupliquer_hebergement_field_NV("check_pk")
End case 