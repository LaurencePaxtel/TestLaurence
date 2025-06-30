//%attributes = {}
// La méthode init_constantes initialise les constantes de l'application 
// 
// #SYNTAX: init_constantes
// #PARAMETERS:
//     Aucun

// #DATE CREATION: 11/04/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

Case of 
	: (Application type:C494=4D Server:K5:6) | (Application type:C494=4D mode local:K5:1) | (Application type:C494=4D Volume Desktop:K5:2)
		C_TEXT:C284(<>T_Filtre_ISO8859_1_C)
		C_LONGINT:C283(<>L_Pile_defaut_C)
		
		<>L_Pile_defaut_C:=0  // on laisse 4D gérer
		<>T_Filtre_ISO8859_1_C:="ISO-8859-1"
	Else 
		GET PROCESS VARIABLE:C371(-1; <>L_Pile_defaut_C; <>L_Pile_defaut_C)
		GET PROCESS VARIABLE:C371(-1; <>T_Filtre_ISO8859_1_C; <>T_Filtre_ISO8859_1_C)
End case 