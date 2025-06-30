//%attributes = {}
// Method FEN_OpenFormWindow ouvre une fenêtre  formulaire 
// 
// #SYNTAX: $L_Ref:=FEN_OpenFormWindow(->Table;"form";{titre};{type}) 
// #PARAMETERS:
//     $0 Long            : Ref window
//     $1 Pointer         : table
//     $2 text            : nom du formulaire
//     $3 Text            : Titre de la fenêtre, vide par défaut
//     $4 Long            : Type fentre, 8 par defaut

// #DATE CREATION: 01/12/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_TEXT:C284($T_Titre; $T_Form)
C_LONGINT:C283($L_Type; $L_W)
C_POINTER:C301($P_Table)

$P_Table:=$1
$T_Form:=$2

$L_Type:=Form fenêtre standard:K39:10

If (Count parameters:C259>=3)
	$L_Type:=$3
	
	If (Count parameters:C259>=4)
		$T_Titre:=$4
	End if 
	
End if 

$L_W:=Open form window:C675($P_Table->; $T_Form; $L_Type; Centrée horizontalement:K39:1; Centrée verticalement:K39:4; *)
SET WINDOW TITLE:C213($T_Titre; $L_W)

$0:=$L_W