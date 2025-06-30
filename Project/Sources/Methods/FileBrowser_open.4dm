//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 14/06/23, 12:13:20
// ----------------------------------------------------
// Méthode : FileBrowser_open
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($T_Cle_folder; $T_remoteFolder; $T_sharedFolder; $T_Remote_rootFolder; $position_t)
C_LONGINT:C283($L_Trouve; $L_Erreur)
C_OBJECT:C1216($O_Sub)

$T_Cle_folder:=$1

SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Trouve)

// Modifié par : Scanu Rémy (06/03/2023)
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$T_Cle_folder; *)
QUERY:C277([HeBerge:4];  & ; [HeBerge:4]Ref_Structure:67=<>ref_soc_active)

SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)

Case of 
	: ($T_Cle_folder="")
		$L_Erreur:=-2
	: ($L_Trouve#1)
		$L_Erreur:=-3
	Else 
		$T_Cle_folder:=Replace string:C233($T_Cle_folder; "/"; "-")
		
		// Le remoteFolder est à coté du data
		// La table SOCIETE peut contenir un chemin customisé   // #20180608-1
		ALL RECORDS:C47([SOciete:18])  // #20180608-1
		MultiSoc_Filter(->[SOciete:18])
		
		$T_Remote_rootFolder:=[SOciete:18]SO_Chemin_GED:96+"base_documentaire"+Séparateur dossier:K24:12+<>ref_soc_active+Séparateur dossier:K24:12  // #20180608-1
		$T_sharedFolder:="Documents usagers"
		$T_remoteFolder:=$T_sharedFolder+Séparateur dossier:K24:12+$T_Cle_folder
		
		UNLOAD RECORD:C212([SOciete:18])  // #20180608-1
		
		// Ici on paramètre les nom des dossiers et les chemins
		$O_Sub:=New object:C1471
		$O_Sub.remotefolder_cle:=$T_Cle_folder  // la clé de l"usagé
		$O_Sub.remotefolder_shared:=$T_sharedFolder  // le nom du dossier normalement : "Documents usagers"
		$O_Sub.remotefolder:=$T_remoteFolder  // chemin vers le dossier de l'usager
		$O_Sub.remotefolder_root:=$T_Remote_rootFolder  // chemin vers le dossier qui reçoit le dossier $T_sharedFolder
		$O_Sub.customtitel:="Documents disponibles pour "+Replace string:C233($T_Cle_folder; "-"; "/")+" à "+String:C10(Current time:C178)
		
		$L_Erreur:=FileBrowser_creer_folder(->$O_Sub)  // exécutée sur le serveur
		
		If ($L_Erreur=1)
			$position_t:="center"
			outilsCreateWindowsForm("Documents_Usagers_Host"; ->$position_t; $O_Sub)
		End if 
		
End case 

Case of 
	: ($L_Erreur=-1)
		ALERT:C41("Une erreur est survenue lors de la création du dossier de la clé")
	: ($L_Erreur=-2)
		ALERT:C41("Veuillez passer une clé non nulle en paramètre")
	: ($L_Erreur=-3)
		ALERT:C41("La clé "+$T_Cle_folder+" existe "+String:C10($L_Trouve)+" fois")
	Else 
End case 