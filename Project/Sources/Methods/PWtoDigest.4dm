//%attributes = {}
// Method PWtoDigest crypte le password de l'utilisateur et l'emballe dans un passphrase
// 
// #SYNTAX: $T_Digest:=PWtoDigest(PW) 
// #PARAMETERS:
//     $0 Text            : Digest
//     $1 Text            : PW

// #DATE CREATION: 11/10/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_TEXT:C284($0)
C_TEXT:C284($1; $T_PW)
$T_PW:=$1

C_TEXT:C284($T_Passphrase)
$T_Passphrase:="CogemServicePassword"

$0:=Generate digest:C1147(($T_Passphrase+$T_PW+$T_Passphrase); Digest SHA1:K66:2)

// EOM

