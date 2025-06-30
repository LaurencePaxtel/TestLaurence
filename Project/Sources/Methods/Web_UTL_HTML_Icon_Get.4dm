//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 12/04/20, 10:40:46
// ----------------------------------------------------
// Method: Web_UTL_HTML_Icon_Get
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $icon; $0; $result)

$icon:=$1

Case of 
	: ($icon="@icon_email@")
		$result:="<i class=\"fa fa-envelope-o\"></i>"
	: ($icon="@icon_sms@")
		$result:="<i class=\"fa fa-comment\"></i>"
	: ($icon="@icon_new@")
		$result:="<i class=\"fa fa-file\"></i>"
End case 

$0:=$result