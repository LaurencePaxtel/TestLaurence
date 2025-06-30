// Method [DiaLogues].DL_Fiche_Conso.LB1  
// 
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_Fiche_Conso.LB1(param_1;->param_N) 
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

// #DATE CREATION: 19/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


If (Size of array:C274(<>ta_ConsoB_Document)>0)
	
	P_VarParamConsoVoir(2)
	
	If (<>ta_ConsoB_Document>0)
		P_ConsoVoir(<>ta_ConsoB_Document)
	End if 
End if 