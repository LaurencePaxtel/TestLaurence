// Method hmCal.input  
// 
// 
// #SYNTAX: $L_Erreur:=hmCal.input(param_1;->param_N) 
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

// #DATE CREATION: 06/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2



Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		//C_TEXT($T_Object)
		//$T_Object:=OBJECT Get name(Object current)
		
		ARRAY TEXT:C222(rT_Filter_column; 1)
		rT_Filter_column{1}:="nom"
		
	: (Form event code:C388=Sur après frappe clavier:K2:26)
		
		LBAR_Row_Hide
		reu_display_count
End case 