//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16-02-20, 15:40:11
// ----------------------------------------------------
// Method: MAIL_Send
// Description
// 
//
// Parameters
//$1 L'objet de l'email
//$2 Le serveur de messagerie
//$3 L'expéditeur (Email)
//$4 Pointeur dépointant vers un tableau contenant la liste des destinataires
//$5 Le message 
//$6 Identifiant de l'authentification au serveur de messagerie
//$7 Mot de passe de l'authentification au serveur de messagerie
//$8 Pointeur dépointant vers un tableau contenant la liste des pièces joints (facultatif)
// ----------------------------------------------------

#DECLARE($subject : Text; $to : Text; $message : Text; $piece_jointe : Pointer) : Text


var $Email_o : cs:C1710.EMail
var $state_o : Object

SOC_Get_Config

$Email_o:=cs:C1710.EMail.new(strc_smtp_server; strc_smtp_username; strc_smtp_password)

$Email_o.to:=$to
$Email_o.from:=SO_Email
$Email_o.htmlBody:=$message

ARRAY TO COLLECTION:C1563($Email_o.attachmentsPath_c; $piece_jointe->)

$state_o:=$Email_o.send()

If ($state_o.success)
	return ""
Else 
	return $state_o.statusText
End if 


/*
C_BLOB($blob)
C_ENTIER LONG($id_message; $error)

C_POINTEUR($to; $4)
C_POINTEUR($piece_jointe; $8)
C_POINTEUR($Type_envoi; $9)
C_TEXTE($0; $err_message)

$subject:=$1
$host:=$2
$from:=$3
$to:=$4
$message:=$5
$utilisateur:=$6
$MdP:=$7
Si (Nombre de paramètres>7)
$piece_jointe:=$8
Fin de si 
Si (Nombre de paramètres>8)
$Type_envoi:=$9
Fin de si 

MAIL_Check_Error(-1000000000)  //`Initialisation des tableaux d'erreurs
$error:=SMTP_New($id_message)
MAIL_Check_Error($error; "SMTP_New")
$error:=SMTP_Host($id_message; $host; 0)
MAIL_Check_Error($error; "SMTP_Host")
$error:=SMTP_From($id_message; $from; 0)
MAIL_Check_Error($error; "SMTP_From")
$error:=SMTP_ReplyTo($id_message; $from; 0)
MAIL_Check_Error($error; "SMTP_ReplyTo")
$error:=SMTP_AddHeader($id_message; "Content-Type:"; "text/html;charset=UTF-8"; 1)
MAIL_Check_Error($error; "SMTP_AddHeader")
Si (Taille tableau($to->)>0)  //controle de la présence de destinataires (1 minimum)
//destinataires
Boucle ($i; 1; Taille tableau($to->))
Si (Nombre de paramètres<9)
Si ($to->{$i}#"")
$error:=SMTP_To($id_message; $to->{$i}; 0)
Fin de si 
Sinon 
Au cas ou 
: ($Type_envoi->{$i}="pour@")
$error:=SMTP_To($id_message; $to->{$i}; 0)
: ($Type_envoi->{$i}="copie à@")
$error:=SMTP_Cc($id_message; $to->{$i}; 0)
: ($Type_envoi->{$i}="copie cachée@")
$error:=SMTP_Bcc($id_message; $to->{$i}; 0)
Fin de cas 
Fin de si 
Fin de boucle 

//pièces jointes
Si ($piece_jointe#Null)
Si (Taille tableau($piece_jointe->)>0)
Boucle ($i; 1; Taille tableau($piece_jointe->))
$fichier:=$piece_jointe->{$i}
$error:=SMTP_Attachment($id_message; $fichier; 2; 0)  //Le 2 indique un codage en base 64 de la piece jointe et le 0 l'ajout de la piece au mail
Fin de boucle 
Fin de si 
Fin de si 

//message : sujet et contenu
CONVERTIR DEPUIS TEXTE($subject; "UTF-8"; $blob)
//$subject:=BLOB to text($blob;Mac text without length)
$error:=SMTP_Subject($id_message; $subject; 0)
MAIL_Check_Error($error; "SMTP_Subject")
CONVERTIR DEPUIS TEXTE($message; "UTF-8"; $blob)
//$message:=BLOB to text($blob;Mac text without length)
$error:=SMTP_Body($id_message; $message; 0)
MAIL_Check_Error($error; "SMTP_Body")
//envoi du message
Si (($utilisateur#"") & ($MdP#""))
$error:=SMTP_Auth($id_message; $utilisateur; $MdP; 0)
MAIL_Check_Error($error; "SMTP_Auth")
Fin de si 
$error:=IT_SetPort(2; strc_smtp_port)  //587
$error:=SMTP_Send($id_message; strc_param_ssl)
MAIL_Check_Error($error; "SMTP_Send")
$error:=SMTP_Clear($id_message)
MAIL_Check_Error($error; "SMTP_Clear")

Si (Taille tableau(tb_error)=0)
$0:=""
Sinon 

Boucle ($i; 1; Taille tableau(tb_lib_er))
$err_message:=tb_lib_er{$i}+Caractère(13)
Fin de boucle 

$0:=$err_message
Fin de si 
Sinon 
$0:="Envoi impossible, pas de destinataire"
Fin de si 

*/