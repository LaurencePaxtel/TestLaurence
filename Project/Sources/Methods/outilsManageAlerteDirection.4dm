//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 29/09/22, 14:54:23
// ----------------------------------------------------
// Méthode : outilsManageAlerteDirection
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Text
var $3 : Date

var $messageBug_t : Text
var $transporter_o; $email_o; $statut_o : Object

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

var $intervenant_e : cs:C1710.INtervenantsEntity

$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID = :1"; $1)

If ($heberge_es.length=1)
	$heberge_e:=$heberge_es.first()
	
	If ($heberge_e.HB_AlerteDirection#Null:C1517)
		
		If (Bool:C1537($heberge_e.HB_AlerteDirection.activer)=True:C214)
			ref_soc_active:=$heberge_e.Ref_Structure
			
			$transporter_o:=outilsMailGestion(1)
			$intervenant_e:=ds:C1482.INtervenants.get($heberge_e.HB_AlerteDirection.userID)
			
			If ($intervenant_e#Null:C1517)
				
				Case of 
					: (SO_Email="") | (strc_smtp_server="") | (strc_smtp_port=0) | (strc_smtp_username="") | (strc_smtp_password="")
						$transporter_o:=outilsMailGestion(1; New object:C1471("host"; "in-v3.mailjet.com"; "port"; 587; "user"; "bb20878e0cbad41df53be8d0721d5ef2"; "password"; "cdd093160ca45cf63c3a688842066cbf"))
						
						$email_o:=New object:C1471("emetteur"; "l.phanchi@paxtel.fr"; \
							"destinataire"; "l.phanchi@paxtel.fr"; \
							"cc"; "remy@connect-io.fr"; \
							"objet"; "Bug alerte direction - Niveau 1 "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom; \
							"message"; "Une « alerte direction » sur l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+" est en place sur la structure "+[HeberGement:5]Ref_Structure:169+" mais des éléments nécessaires à"+\
							" l'envoi des emails sont manquants."+Char:C90(Retour chariot:K15:38)+"Email structure : "+SO_Email+Char:C90(Retour chariot:K15:38)+"SMTP serveur : "+strc_smtp_server+\
							Char:C90(Retour chariot:K15:38)+"SMTP port : "+String:C10(strc_smtp_port)+Char:C90(Retour chariot:K15:38)+"SMTP user : "+strc_smtp_username+Char:C90(Retour chariot:K15:38)+"SMTP password :"+strc_smtp_password)
					: (SO_Email#"") & (strc_smtp_server#"") & (strc_smtp_port#0) & (strc_smtp_username#"") & (strc_smtp_password#"")
						$email_o:=New object:C1471("emetteur"; SO_Email; \
							"destinataire"; $intervenant_e.IN_Email; \
							"cc"; SO_Email; \
							"objet"; "Alerte "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom; \
							"message"; "Un utilisateur vient de créer une fiche pour "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+" : "+$2+" à la date du "+String:C10($3))
					: ($intervenant_e.IN_Email="")
						$messageBug_t:="L'intervenant "+$intervenant_e.IN_NomPrénom+" a programmé une « alerte direction » sur l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+" mais n'a pas d'adresse email."
				End case 
				
			Else 
				$messageBug_t:="Une « alerte direction » sur l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom+" est programmé mais l'intervenant qui l'a mis en place n'a pas pu être trouvé dans la base de donnée."
			End if 
			
			If ($messageBug_t#"")
				$email_o:=New object:C1471("emetteur"; SO_Email; \
					"destinataire"; SO_Email; \
					"cc"; "l.phanchi@paxtel.fr"; \
					"objet"; "Bug alerte direction "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom; \
					"message"; $messageBug_t)
			End if 
			
		End if 
		
	End if 
	
End if 

If ($email_o#Null:C1517)
	$statut_o:=outilsMailGestion(2; $transporter_o; $email_o)
End if 