//%attributes = {"executedOnServer":true,"preemptive":"capable"}
// Method FileBrowser_creer_folder créé le dossier racine des documents ou le dossier d'une clé 
// 
// #SYNTAX: $L_Erreur:=FileBrowser_creer_folder(dossier1:dossierB) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Text            : Enfilade de dossier à créer
//     $2 Pointer         : Message d'erreur

// #DATE CREATION: 11/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE: La méthode est exécutée sur le serveur

// #HEADER VERSION: 2


// #20180511-1
C_LONGINT:C283($0)
C_POINTER:C301($1)

C_TEXT:C284($T_Data_folder; $T_remoteFolder; $T_Cle)
C_LONGINT:C283($L_MyError; $pos_el)
C_POINTER:C301($P_O_Sub)  // les dossiers à tester et créer
C_OBJECT:C1216($O_Sub)

$L_MyError:=1
$P_O_Sub:=$1

$O_Sub:=OB Copy:C1225($P_O_Sub->)

$T_Data_folder:=$O_Sub.remotefolder_root
$T_remoteFolder:=$O_Sub.remotefolder

If (Length:C16($T_Data_folder)=0)  // #20180608-1
	$T_Data_folder:=Get 4D folder:C485(Dossier données:K5:33)  // le dossier qui contient le data
Else 
	
	// Modified by: Scanu Rémy - remy@connect-io.fr (24/02/2021)
	// Si la machine du client et du serveur ne tourne pas sur le même système d'exploitation ça ne va pas pour le séparateur dossier
	If (Is macOS:C1572)
		$T_Data_folder:=Replace string:C233($T_Data_folder; "\\"; Séparateur dossier:K24:12)
	Else 
		// On doit tenir compte de la chaine ":\\" sinon le chemin n'est pas bon
		$pos_el:=Position:C15(":"+Séparateur dossier:K24:12; $T_Data_folder)
		
		If ($pos_el>0)
			$T_Data_folder:=Substring:C12($T_Data_folder; 0; $pos_el+1)+Replace string:C233(Substring:C12($T_Data_folder; $pos_el+2); ":"; Séparateur dossier:K24:12)
		Else 
			$T_Data_folder:=Replace string:C233($T_Data_folder; ":"; Séparateur dossier:K24:12)
		End if 
		
	End if 
	
End if 

// Modified by: Scanu Rémy - remy@connect-io.fr (24/02/2021)
// Si la machine du client et du serveur ne tourne pas sur le même système d'exploitation ça ne va pas pour le séparateur dossier
If (Is macOS:C1572)
	$T_remoteFolder:=Replace string:C233($T_remoteFolder; "\\"; Séparateur dossier:K24:12)
Else 
	$T_remoteFolder:=Replace string:C233($T_remoteFolder; ":"; Séparateur dossier:K24:12)
End if 

$T_Cle:=$T_Data_folder+$T_remoteFolder+Séparateur dossier:K24:12
CREATE FOLDER:C475($T_Cle; *)  // création du dossier de la clé 

If (Test path name:C476($T_Cle)#Est un dossier:K24:2)
	$L_MyError:=-1
End if 

$O_Sub.remotefolder_root:=$T_Data_folder  // chemin vers le doissier "Documents usagers"
$O_Sub.remotefolder:=$T_Cle

$P_O_Sub->:=OB Copy:C1225($O_Sub)

$0:=$L_MyError