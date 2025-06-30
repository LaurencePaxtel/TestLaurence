// Method [DiaLogues].DL_Départ.logoClient  
// 
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_Départ.logoClient(param_1;->param_N) 
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
	: (Form event code:C388=Sur chargement:K2:1)
		
		
		// le nom du client est positionné par rapport au logo
		C_LONGINT:C283($G; $H; $D; $B; $L_Droite)
		OBJECT GET COORDINATES:C663(*; "@logoClient"; $G; $H; $D; $B)
		$L_Droite:=$D
		OBJECT GET COORDINATES:C663(*; "label_nom_client"; $G; $H; $D; $B)
		OBJECT SET COORDINATES:C1248(*; "label_nom_client"; $L_Droite; $H; $D; $B)
		
End case 