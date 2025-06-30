//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15/03/20, 08:34:44
// ----------------------------------------------------
// Method: MAIL_HTML_Generate
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_TEXT:C284($msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4; $message; $BR)

SOC_Get_Config

$msg_text_1:=$1
$msg_text_2:=$2
$msg_text_3:=$3
$msg_text_4:=$4

$BR:="<br/>"

$message:="<html>"
$message:=$message+"<head>"
$message:=$message+"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"+Char:C90(13)
$message:=$message+MAIL_CSS
$message:=$message+"</head>"
$message:=$message+"<body>"

$message:=$msg_text_1+$BR+$BR

If ($msg_text_2#"")
	
	If ($msg_text_3="@<table@")
		$message:=$message+$msg_text_2+$BR
	Else 
		$message:=$message+$msg_text_2+$BR+$BR
	End if 
	
End if 

If ($msg_text_3#"")
	
	If ($msg_text_3="@<table@")
		$message:=$message+$msg_text_3+$BR
	Else 
		$message:=$message+$msg_text_3+$BR+$BR
	End if 
	
End if 

If ($msg_text_4#"")
	$message:=$message+$msg_text_4+$BR+$BR
End if 

$message:=$message+"Cordialement,<br/>"
$message:=$message+"--<br/>"
$message:=$message+txt_strc_nom
$message:=$message+"<br/>"
$message:=$message+txt_strc_nom_suite
$message:=$message+"<br/>"
$message:=$message+txt_strc_adresse

$message:=$message+"</body>"
$message:=$message+"</html>"

$0:=$message