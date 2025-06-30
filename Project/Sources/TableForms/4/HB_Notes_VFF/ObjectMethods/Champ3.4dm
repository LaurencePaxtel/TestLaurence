// Method [HeBerge].HB_Notes4.Champ3  
// 
// 
// #SYNTAX: $L_Erreur:=[HeBerge].HB_Notes4.Champ3(param_1;->param_N) 
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
	: (Form event code:C388=Sur après modification:K2:43)
		
		Handle saisie note hebergement("edit")
		
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		Handle saisie note hebergement("curseur_fin")  // #Fix20170428-2
		
End case 