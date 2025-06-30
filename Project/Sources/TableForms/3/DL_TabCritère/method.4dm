// Method [DiaLogues].DL_TabCritère  
// 
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_TabCritère(param_1;->param_N) 
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

// #DATE CREATION: 21/12/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		SET TIMER:C645(1)
	: (Form event code:C388=Sur minuteur:K2:25)
		SET TIMER:C645(0)
		
		LISTBOX SORT COLUMNS:C916(*; "LB1"; 2; >)
End case 