// Method [HeBerge].HB_Notes4.Variable1  
// 
// 
// #SYNTAX: $L_Erreur:=[HeBerge].HB_Notes4.Variable1(param_1;->param_N) 
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
	: (Form event code:C388=Sur clic:K2:4)
		
		Handle saisie note hebergement("tab")
		
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_POINTER:C301($P_Liste)
		$P_Liste:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "objet_onglet")
		VARIABLE TO VARIABLE:C635(Current process:C322; $P_Liste->; <>L_Onglet_notes_C)
		
End case 