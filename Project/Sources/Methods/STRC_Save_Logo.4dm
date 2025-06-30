//%attributes = {"executedOnServer":true}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30/06/19, 08:41:47
// ----------------------------------------------------
// Method: STRC_Save_Logo
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Text

var $base_documentaire_path : Text
var $logo : Blob

READ ONLY:C145([Structures:79])
QUERY:C277([Structures:79]; [Structures:79]UID:1=$1)

QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)

If (Records in selection:C76([Structures:79])=1)
	// Sauvegarde du logo pour l'usage HTML
	$base_documentaire_path:=[SOciete:18]SO_Chemin_GED:96+"base_documentaire"+Séparateur dossier:K24:12+[Structures:79]STRC_Initiales:2+Séparateur dossier:K24:12
	
	If (Test path name:C476($base_documentaire_path)#0)
		CREATE FOLDER:C475($base_documentaire_path)
	End if 
	
	If (Test path name:C476($base_documentaire_path+[Structures:79]STRC_Initiales:2+".png")=Est un document:K24:1)
		DELETE DOCUMENT:C159($base_documentaire_path+[Structures:79]STRC_Initiales:2+".png")
	End if 
	
	PICTURE TO BLOB:C692([Structures:79]STRC_Logo:5; $logo; ".png")
	BLOB TO DOCUMENT:C526($base_documentaire_path+"logo.png"; $logo)
End if 