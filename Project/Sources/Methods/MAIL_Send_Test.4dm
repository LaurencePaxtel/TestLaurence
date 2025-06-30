//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21/03/20, 10:39:59
// ----------------------------------------------------
// Method: MAIL_Send_Test
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($subject; strc_smtp_server; strc_smtp_password; strc_smtp_username)
C_LONGINT:C283(strc_smtp_port; strc_param_ssl)
ARRAY TEXT:C222($tb_destinataire; 0)
ARRAY TEXT:C222($pieces_jointes; 0)


strc_smtp_server:="smtp-relay.sendinblue.com"
strc_smtp_username:="hassal.it@gmail.com"
strc_smtp_password:="RaCAgHxGQpJSyb2W"
strc_smtp_port:=587
strc_param_ssl:=0  //0,1,2

APPEND TO ARRAY:C911($tb_destinataire; "kevin@hassal.net")

$message:="this is a ossdk"
$subject:="this is i"

$error:=MAIL_Send($subject; strc_smtp_server; [SOciete:18]SO_Email:116; ->$tb_destinataire; $message; strc_smtp_username; strc_smtp_password; ->$pieces_jointes)


