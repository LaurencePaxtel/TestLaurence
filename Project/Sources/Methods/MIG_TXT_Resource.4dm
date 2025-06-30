//%attributes = {}
// Method MIG_TXT_Resource  
// 
// 
// #SYNTAX: $L_Erreur:=MIG_TXT_Resource(param_1;->param_N) 
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

// #DATE CREATION: 31/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($L_Start; $L_End)
$L_Start:=30000
$L_End:=30212

C_TEXT:C284($T_Path)
$T_Path:=System folder:C487(Bureau:K41:16)+"TXT_Replace"+Séparateur dossier:K24:12
CREATE FOLDER:C475($T_Path; *)

While ($L_Start<=$L_End)
	
	C_TEXT:C284($T_Data)
	$T_Data:=Get text resource:C504($L_Start)
	
	If (Length:C16($T_Data)>0)
		
		C_TIME:C306($H_Doc)
		$H_Doc:=Create document:C266($T_Path+String:C10($L_Start)+".txt")
		If (OK=1)
			SEND PACKET:C103($H_Doc; $T_Data)
			CLOSE DOCUMENT:C267($H_Doc)
		End if 
	End if 
	
	$L_Start:=$L_Start+1
End while 

