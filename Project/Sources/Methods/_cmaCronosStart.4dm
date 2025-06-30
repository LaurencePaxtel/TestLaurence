//%attributes = {"executedOnServer":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 17/01/24, 16:20:31
// ----------------------------------------------------
// Méthode : _cmaCronosStart
// Description
// Démarre Cronos du composant Marketing Automation
//
// Paramètres
// ----------------------------------------------------
var $startCronos_b : Boolean

$startCronos_b:=(Application type:C494=4D mode local:K5:1) | (Application type:C494=4D Volume Desktop:K5:2)

If ($startCronos_b=False:C215)
	CONFIRM:C162("Souhaitez-vous démarrer Cronos du composant CIO Marketing Automation ?"; "Oui"; "Non")
	$startCronos_b:=(OK=1)
End if 

If ($startCronos_b=True:C214)
	// *************************************************
	// *****  Ajout composant cioWeb & cioMarketingAutomation *****
	// *************************************************
	<>webApp_o:=cwToolGetClass("webApp").new("WebApp")
	cwEMailConfigLoad
	
	cwMarketingAutomationStart(True:C214)
	WEB SET ROOT FOLDER:C634(Get 4D folder:C485(Dossier base:K5:14)+"DossierWeb"+Séparateur dossier:K24:12)
End if 