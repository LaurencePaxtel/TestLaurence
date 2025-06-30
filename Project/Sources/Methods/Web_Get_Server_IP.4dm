//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30/06/19, 21:26:51
// ----------------------------------------------------
// Method: Web_Get_Server_IP
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($filename; $0; $url)
C_BLOB:C604($blob)
C_LONGINT:C283($port)
WEB GET OPTION:C1209(15; $port)

$filename:=Get 4D folder:C485(Dossier base:K5:14)+"Resources"+Séparateur dossier:K24:12+"parametrage_serveur.txt"

If (Test path name:C476($filename)=Est un document:K24:1)
	
	DOCUMENT TO BLOB:C525($filename; $blob)
	$url:=BLOB to text:C555($blob; Mac texte sans longueur:K22:10)+":"+String:C10($port)
	
Else   // return the local host 
	$url:="localhost"+":"+String:C10($port)
End if 

$0:=$url
