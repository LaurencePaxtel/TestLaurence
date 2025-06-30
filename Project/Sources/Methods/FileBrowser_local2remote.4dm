//%attributes = {"executedOnServer":true}
// Method FileBrowser_local2remote déplace les documents du dossier temporaire vers le dossier cibe  
// 
// #SYNTAX: $L_Erreur:=FileBrowser_local2remote ($X_BLOB;$O_Param;->$T_Text_error)
// #PARAMETE //     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : Accès au dossier local
//     $2 Text            : Accès au dossier cible
//     $3 Pointer         : Message d'erreur

// #DATE CREATION: 10/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// #20180511-1

// on est sur le serveur

C_LONGINT:C283($0; $L_MyError)
$L_MyError:=1

C_BLOB:C604($1; $X_BLOB)
$X_BLOB:=$1
C_OBJECT:C1216($2; $O_Param)
$O_Param:=$2
C_POINTER:C301($3; $P_Message)
$P_Message:=$3

C_TEXT:C284($T_remoteFolder)
$T_remoteFolder:=$O_Param.remotefolder
$T_remoteFolder_cle:=$O_Param.remotefolder_cle
$T_File:=$O_Param.file
Case of 
	: (Test path name:C476($T_remoteFolder)#Est un dossier:K24:2)
		$L_MyError:=-2
	Else 
		
		CREATE FOLDER:C475($T_remoteFolder_cle; *)
		BLOB TO DOCUMENT:C526($T_File; $X_BLOB)
		If (OK=0)
			$L_MyError:=-1
		End if 
End case 

C_TEXT:C284($T_Message)
Case of 
	: ($L_MyError=-1)
		$T_Message:="le document n'a pas été deblobé"
	: ($L_MyError=-2)
		$T_Message:="Le dossier distant des documents n'a pas été trouvé"
	Else 
		$T_Message:="OK"
End case 

$0:=$L_MyError
$P_Message->:=$T_Message

// EOM

