//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 10/12/18, 16:26:55
// ----------------------------------------------------
// Méthode : outilsProgressBar
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_REAL:C285($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($nonTempo_b)

Case of 
	: ($2="Initialisation")
		C_LONGINT:C283(progressBar_el)
		
		progressBar_el:=Progress New  // on crée une nouvelle barre
		
		Progress SET BUTTON ENABLED(progressBar_el; $3)
		Progress SET ICON(progressBar_el; Storage:C1525.image["progress-bar"]; True:C214)
	: ($2="arrêt") | (Progress Stopped(progressBar_el)=True:C214)
		
		If (progressBar_el>0)  // Si la barre de progression n'a pas été arrêté
			Progress QUIT(progressBar_el)
			
			If (Progress Stopped(progressBar_el)=True:C214)  // Si l'utilisateur a cliqué sur le bouton stop on stop tout
				CLEAR VARIABLE:C89(progressBar_el)
			End if 
			
		End if 
		
	Else 
		Progress SET PROGRESS(progressBar_el; $1; $2; True:C214)
		
		If (Count parameters:C259=3)
			$nonTempo_b:=$3
		End if 
		
		If ($nonTempo_b=False:C215)
			DELAY PROCESS:C323(Current process:C322; 5)
		End if 
		
End case 