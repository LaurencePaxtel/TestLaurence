// Method [APPOINTMENTS].Entrée  
// 
// 
// #SYNTAX: $L_Erreur:=[APPOINTMENTS].Entrée(param_1;->param_N) 
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

// #DATE CREATION: 11/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


RDV placeholders
RDV help tip
RDV interface

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		RELATE ONE:C42([APPOINTMENTS:73]UserID:10)
		
		reu_Lire_Participants([APPOINTMENTS:73]ID:1)
		
		C_POINTER:C301($P_Liste)
		$P_Liste:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Colonne1")
		SELECTION TO ARRAY:C260([HeBerge:4]HB_Nom:3; $P_Liste->)
		
End case 