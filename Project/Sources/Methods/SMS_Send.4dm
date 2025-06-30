//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 03:11:06
// ----------------------------------------------------
// Method: SMS_Send
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $recipient; $2; $body; $3; $sender)
C_TEXT:C284($body_txt; $response_txt)
C_BOOLEAN:C305($status; $0)
C_LONGINT:C283($status_http)

$recipient:=$1
$body:=$2
$sender:=SMS_PARAM_SENDER
$status:=True:C214

If (Count parameters:C259>2)
	$sender:=$3
End if 

$body_txt:=""
TRACE:C157
If (($recipient#"") & ($body#"") & ($sender#""))
	$status_http:=HTTP Request:C1158(HTTP méthode GET:K71:1; "https://api.smsfactor.com/send?text="+$body+"&to="+$recipient+"&sender="+$sender+"&token="+SMS_PARAM_TOKEN; $body_txt; $response_txt)
Else 
	$status:=False:C215
End if 

$0:=$status