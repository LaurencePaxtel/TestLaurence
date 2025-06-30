//%attributes = {}
// Method cal_Get_Pointer  
// 
// 
// #SYNTAX: cal_Get_Pointer(param_1;->param_N) 
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

C_POINTER:C301($1; $P_Usagers_cle)
C_POINTER:C301($2; $P_Usagers_nom)
C_POINTER:C301($3; $P_Usagers_pk)
C_POINTER:C301($4; $P_Permanenciers_nom)
C_POINTER:C301($5; $P_Permanenciers_pk_invisible)
C_POINTER:C301($6; $P_Date_end_export)
C_POINTER:C301($7; $P_Date_start_export)
C_POINTER:C301($8; $P_pop_filtre_export)

// Usagers
$P_Usagers_cle:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "cle")
$P_Usagers_nom:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "nom")
$P_Usagers_pk:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pk")
// Permanenciers
$P_Permanenciers_nom:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pop_permanencier")
$P_Permanenciers_pk_invisible:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pop_permanencier_pk")

$P_Date_end_export:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Date_end_export")
$P_Date_start_export:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Date_start_export")
$P_pop_filtre_export:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pop_filtre_export")

$1->:=$P_Usagers_cle
$2->:=$P_Usagers_nom
$3->:=$P_Usagers_pk
$4->:=$P_Permanenciers_nom
$5->:=$P_Permanenciers_pk_invisible
$6->:=$P_Date_end_export
$7->:=$P_Date_start_export
$8->:=$P_pop_filtre_export


If (False:C215)
	
	C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible; $P_Date_end_export; $P_Date_start_export; $P_pop_filtre_export)
	Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible; ->$P_Date_end_export; ->$P_Date_start_export; ->$P_pop_filtre_export)
	
	
End if 
// EOM