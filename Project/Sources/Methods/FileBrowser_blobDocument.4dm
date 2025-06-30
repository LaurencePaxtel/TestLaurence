//%attributes = {"executedOnServer":true}
// Method FileBrowser_blobDocument blobe les documents du dossier local
// 
// 
// #SYNTAX: $L_Erreur:=FileBrowser_blobDocument($X_BLOB;path) 
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

// #DATE CREATION: 07/06/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($T_Path)
C_LONGINT:C283($L_MyError)
C_POINTER:C301($P_Output_BLOB)

// #20180607-1
// On est sur le client
$L_MyError:=1
$P_Output_BLOB:=$1
$T_Path:=$2

Case of 
	: (Test path name:C476($T_Path)#Est un document:K24:1)
		$L_MyError:=-1
	Else   // Sur le serveur
		DOCUMENT TO BLOB:C525($T_Path; $P_Output_BLOB->)
		
		If (OK=0)
			$L_MyError:=-2
		End if 
		
End case 

$0:=$L_MyError