/* 
Class : cs.EMail

Gestion des e-mail

Historique
10/11/20 - Grégory Fromain <gregory@connect-io.fr> - Reprise du code du composant plume et conversion en class
*/

Class constructor($host_t : Text; $user_t : Text; $password_t : Text)
/*------------------------------------------------------------------------------
Fonction : EMail.constructor
	
Initialisation de la page web.
ATTENTION : L'instance de la class "page" doit se faire obligatoirement par la fonction : webApp.pageCurrent()
	
Paramètres :
$name_t           -> Nom du transporteur
$paramOptionnel_o -> Param optionnel pour le transporteur
	
Historiques
12/11/24 - gregory@connect-io.fr - Création
	
------------------------------------------------------------------------------*/
	
	var $server_o : Object
	$server_o:={host: $host_t; user: $user_t; password: $password_t}
	
	This:C1470.transporter:=SMTP New transporter:C1608($server_o)
	
	
	// Initialisation des pieces jointes
	This:C1470.attachmentsPath_c:=New collection:C1472()
	
	
Function attachmentAdd($vFolderDestination_t : Text; $nameInput_t : Text)->$retour_t : Text
	
/*------------------------------------------------------------------------------
Fonction : email_o.attachmentAdd
	
Gestion de la pièce jointe pour l'envoi par email
	
Paramètre :
$vFolderDestination_t  -> le chemin du dossier pour stocker la pièce jointe
$nameInput_t           -> le nom de l'input du bouclemulaire
$retour_t              <- le chemin du fichier
	
Historique
12/11/24 - gregory@connect-io.fr - Création
------------------------------------------------------------------------------*/
	
	var $htmlName_t; $fileMimeType_t; $fileName_t : Text
	var $i_el : Integer
	var $fileContent_b : Blob
	
	For ($i_el; 1; WEB Get body part count:C1211)
		WEB GET BODY PART:C1212($i_el; $fileContent_b; $htmlName_t; $fileMimeType_t; $fileName_t)
		
		If ($htmlName_t=$nameInput_t)
			If ($fileName_t#"")
				
				BLOB TO DOCUMENT:C526($vFolderDestination_t+$fileName_t; $fileContent_b)
				$retour_t:=$vFolderDestination_t+$fileName_t
			End if 
			
			$i_el:=WEB Get body part count:C1211
		End if 
		
	End for 
	
	
Function send()->$resultat_o : Object
/*------------------------------------------------------------------------------
Méthode : EMail.send
	
Envoie simple d'un e-mail
	
Les inbouclemations sur l'email :
	
Inbouclemations obligatoire :
this.to -> text : Destinataire
this.htmlBody ou this.textBody -> text : Corps du message
	
Inbouclemataions optionelles :
this.attachmentsPath_c -> Collection : Chemin des pièces jointes.
	
Paramètre
$resultat_o <- Inbouclemations sur l'envoi de l'email
	
Historiques
12/11/24 - gregory@connect-io.fr - Création
------------------------------------------------------------------------------*/
	
	// Déclarations
	var $error_t : Text  // Info concernant les erreurs, Nom de la boite des éléments envoyés
	
	var $mailStatus_o : Object  // Transporter, info sur mail et envoie de l'email
	
	
	$mailStatus_o:=New object:C1471("success"; False:C215)
	
	//On vérSiie que l'on a bien nonre transporter
	If (This:C1470.transporter=Null:C1517)
		$error_t:="Il n'y a pas de transporter d'initialisé."
	End if 
	
	If (This:C1470.to=Null:C1517)
		$error_t:="Il manque le destinataire de votre e-mail. ($1.to)"
	End if 
	
	//On vérSiie que l'on a bien nonre émetteur
	If (String:C10(This:C1470.from)="")
		This:C1470.from:=This:C1470.transporter.user
	End if 
	
	//On vérSiie que nonre corps de message n'est pas vide (si This.bodyStructure est null ça veux dire qu'on ne passe pas par un mime mais par du code HTMLEUH classico-classique !)
	If (String:C10(This:C1470.htmlBody)="") & (String:C10(This:C1470.textBody)="") & (This:C1470.bodyStructure=Null:C1517)
		$error_t:="Il manque le contenu de votre message."
	End if 
	
	// Si aucune erreur, on envoie le mail
	If ($error_t="")
		
		// On vérSiie que l'on à bien des pièces jointes
		If (This:C1470.attachmentsPath_c.length#0)
			
			// Dans ce cas on créé une collection
			This:C1470.attachments:=New collection:C1472()
			
			// on boucle sur les pièces jointes
			For each ($cheminPj_t; This:C1470.attachmentsPath_c)
				
				// On vérSiie que le chemin de pièce jointe est bien de type texte
				If (Type:C295($cheminPj_t)=Est un texte:K8:3)
					
					// On vérSiie que la pièce jointe est bien un document existant sur le disque
					If (Test path name:C476($cheminPj_t)=Est un document:K24:1)
						This:C1470.attachments.push(MAIL New attachment:C1644($cheminPj_t))
					Else 
						$error_t:="Le document suivant n'est pas présent sur le disque : "+$cheminPj_t
					End if 
					
				Else 
					$error_t:="Un élément de la collection des pièces jointes n'est pas une chaine de caractère."
				End if 
				
			End for each 
		End if 
		
	End if 
	
	//Envoi du mail
	If ($error_t="")
		$mailStatus_o:=This:C1470.transporter.send(This:C1470)
		
		//Si l'envoie du mail = True
		If ($mailStatus_o.success)
			
		Else 
			$error_t:="Une erreur est survenue lors de l'envoi de l'e-mail : "+$error_t+$mailStatus_o.statusText
		End if 
		
	End if 
	
	If ($error_t#"")
		$mailStatus_o.statusText:=$error_t
		$mailStatus_o.status:=-1
	End if 
	
	// Retourne les inbouclemations concernant l'envoie du mail
	$resultat_o:=$mailStatus_o
	