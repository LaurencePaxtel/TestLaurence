// Method [SOciete].SO_EcranSaisie.Bouton  
// 
// 
// #SYNTAX: $L_Erreur:=[SOciete].SO_EcranSaisie.Bouton(param_1;->param_N) 
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

// #DATE CREATION: 04/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Handle couleurs accueil(Form event code:C388)  // #20180504-5
End case 