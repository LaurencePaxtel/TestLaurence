//%attributes = {}
// Method hm_Cal_Droits lit les droits de modification du planning 
//  
// #SYNTAX: hm_Cal_Droits(selecteur;->$L_Ajouter;->$L_Modifier) 
// #PARAMETERS:
//     $1 Text            : get ou set
//     $2 Pointer         : pointeur sur la variable du droit ajouter
//     $3 Pointer         : pointeur sur la variable du droit modifier

// #DATE CREATION: 08/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_TEXT:C284($1; $T_Selecteur)
$T_Selecteur:=$1
C_POINTER:C301($2; $P_ajouter)
$P_ajouter:=$2
C_POINTER:C301($3; $P_Modifier)
$P_Modifier:=$3
C_POINTER:C301($4; $P_Elargi)
$P_Elargi:=$4



C_POINTER:C301($P_Check)
Case of 
	: ($T_Selecteur="get")
		
		$P_Check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "bcoche_ajout")
		$P_ajouter->:=$P_Check->
		
		$P_Check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "bcoche_modification")
		$P_Modifier->:=$P_Check->
		
		$P_Check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "bcoche_elargi")
		$P_Elargi->:=$P_Check->
		
	: ($T_Selecteur="set")
		
		$P_Check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "bcoche_ajout")
		$P_Check->:=$P_ajouter->
		
		$P_Check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "bcoche_modification")
		$P_Check->:=$P_Modifier->
		
		$P_Check:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "bcoche_elargi")
		$P_Check->:=$P_Elargi->
		
	Else 
		TRACE:C157
End case 

