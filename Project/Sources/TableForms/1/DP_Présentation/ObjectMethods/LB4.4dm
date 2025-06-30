// Method [DePart].DP_FusionEtCv.LB  
// 
// 
// #SYNTAX: $L_Erreur:=[DePart].DP_FusionEtCv.LB(param_1;->param_N) 
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

// #DATE CREATION: 18/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_yCtreH)>0)
		Tab_Présentation_CtrH(4; ta_yCtreH; 2)
	End if 
End if 