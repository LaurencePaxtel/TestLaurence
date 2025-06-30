//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 24/12/20, 11:36:15
// ----------------------------------------------------
// Méthode : outilsMailGestion
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_OBJECT:C1216($0)

C_LONGINT:C283($1)
C_OBJECT:C1216($2)  // Transporteur
C_OBJECT:C1216($3)  // Objet email

C_OBJECT:C1216($transporteur_o; $email_o)

SOC_Get_Config

Case of 
	: ($1=1)  // Initialisation nouveau transporteur
		$transporteur_o:=New object:C1471
		
		If (Count parameters:C259=2)
			$transporteur_o.host:=String:C10($2.host)
			$transporteur_o.port:=Num:C11($2.port)
			$transporteur_o.user:=String:C10($2.user)
			$transporteur_o.password:=String:C10($2.password)
		Else 
			$transporteur_o.host:=strc_smtp_server
			$transporteur_o.port:=strc_smtp_port
			$transporteur_o.user:=strc_smtp_username
			$transporteur_o.password:=strc_smtp_password
		End if 
		
		$0:=SMTP New transporter:C1608($transporteur_o)
	: ($1=2)  // Envoi d'un email
		
		If (Count parameters:C259=3)
			
			If ($3.message="@<br@") | ($3.message="@<p>@") | ($3.message="@<body@") | ($3.message="@</html>@")
				$email_o:=New object:C1471("htmlBody"; $3.message)
			Else 
				$email_o:=New object:C1471("textBody"; $3.message)
			End if 
			
			$email_o.from:=$3.emetteur
			$email_o.to:=$3.destinataire
			$email_o.subject:=$3.objet
			
			If ($3.cc#Null:C1517)
				
				If (outilsRegexValidate(1; $3.cc)=True:C214)
					$email_o.cc:=$3.cc
				End if 
				
			End if 
			
			If ($3.pieceJointe#Null:C1517)
				$email_o.attachments:=$3.pieceJointe
			End if 
			
			If (outilsRegexValidate(1; $email_o.from)=True:C214) & (outilsRegexValidate(1; $email_o.to)=True:C214)
				ON ERR CALL:C155("i_Error")
				$0:=$2.send($email_o)
				ON ERR CALL:C155("")
			Else 
				$0:=New object:C1471("success"; False:C215; "statusText"; "Email invalide")
			End if 
			
		End if 
		
End case 