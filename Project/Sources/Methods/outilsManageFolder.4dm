//%attributes = {}
// ----------------------------------------------------
// User name (OS): Scanu Rémy - remy@connect-io.fr
// Date and time: 17/02/21, 14:32:29
// ----------------------------------------------------
// Method: outilsManageFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)  // Chemin d'entrée
C_TEXT:C284($2)  // Chemin du répertoire à créer
C_BOOLEAN:C305($3)  // Indique si on doit répercuter le changement sur le serveur

C_LONGINT:C283($numProc_el; $longueur_el)
C_OBJECT:C1216($chemin_o)

Case of 
	: ($1=1)  // Création d'un dossier
		
		If ($3=True:C214)
			$chemin_o:=Path to object:C1547($2; Chemin est  système:K24:25)
			
			$numProc_el:=Execute on server:C373("outilsManageFolder"; 0; "Création du dossier "+$chemin_o.name; $1; $2; False:C215)
		End if 
		
		If (Application type:C494=4D Server:K5:6)
			
			Case of 
				: ($2="@Resources@")
					$longueur_el:=Length:C16(Séparateur dossier:K24:12)
					
					$2:=Replace string:C233($2; Substring:C12($2; 0; Position:C15("Resources"; $2)+8+$longueur_el); Get 4D folder:C485(Dossier Resources courant:K5:16))
			End case 
			
		End if 
		
		If (Test path name:C476($2)#Est un dossier:K24:2)
			CREATE FOLDER:C475($2; *)
		End if 
		
End case 