//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30/07/19, 18:38:46
// ----------------------------------------------------
// Method: UTL_Log_Time
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($file_path; $1; $content; $3; $txt)
C_POINTER:C301($seconds; $2)

$file_path:=$1
$seconds:=$2
$txt:=$3
$content:=""

$ref:=Open document:C264($file_path; Lecture et écriture:K24:3)
$content:=Document to text:C1236($file_path; UTF8 texte sans longueur:K22:17)
$content:=$content+Char:C90(13)+"- Ligne "+$txt+" : "+String:C10((Milliseconds:C459-$seconds->)/1000)

$seconds->:=Milliseconds:C459

SEND PACKET:C103($ref; $content)
CLOSE DOCUMENT:C267($ref)