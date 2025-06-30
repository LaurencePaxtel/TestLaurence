// Method [APPOINTMENTS].Entrée.pop_statut  
// 
// 
// #SYNTAX: $L_Erreur:=[APPOINTMENTS].Entrée.pop_statut(param_1;->param_N) 
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

// #DATE CREATION: 09/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_POINTER:C301($P_Pop)
$P_Pop:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pop_type")

Case of 
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		C_LONGINT:C283($L_Ref)
		C_TEXT:C284($T_Label)
		GET LIST ITEM:C378(*; "pop_type"; *; $L_Ref; $T_Label)
		
		[APPOINTMENTS:73]TypeRDV:14:=$L_Ref
		SAVE RECORD:C53([APPOINTMENTS:73])
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		VARIABLE TO VARIABLE:C635(Current process:C322; $P_Pop->; L_ListeTypeRDV)
		
		SELECT LIST ITEMS BY REFERENCE:C630($P_Pop->; [APPOINTMENTS:73]TypeRDV:14)
		
	: (Form event code:C388=Sur libération:K2:2)
		
		CLEAR LIST:C377($P_Pop->)
	Else 
		
End case 