//%attributes = {"executedOnServer":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/07/23, 15:50:05
// ----------------------------------------------------
// Méthode : P_FusionBD
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text  // [HeBerge]Ref_Structure
var $2 : Integer  // [HeBerge]HB_ReferenceID

var $file_f; $fileCopy_f : 4D:C1709.File
var $folderOld_f; $folderNew_f : 4D:C1709.Folder

var $heberge_e; $hebergeB_e : cs:C1710.HeBergeEntity
var $societe_e : cs:C1710.SOcieteEntity

outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]Ref_Structure:97; $1; ->$societe_e; "first")

If ($societe_e#Null:C1517)
	outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; [Base_documentaire:90]DOC_Origine_ID:4; ->$heberge_e; "first")
	outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; $2; ->$hebergeB_e; "first")
	
	If ($heberge_e#Null:C1517) & ($hebergeB_e#Null:C1517)
		$folderOld_f:=Folder:C1567($societe_e.SO_Chemin_GED+"base_documentaire"+Séparateur dossier:K24:12+$1+Séparateur dossier:K24:12+"Documents usagers"+Séparateur dossier:K24:12+\
			Replace string:C233($heberge_e.HB_Clé; "/"; "-"); fk chemin plateforme:K87:2)
		$folderNew_f:=Folder:C1567($societe_e.SO_Chemin_GED+"base_documentaire"+Séparateur dossier:K24:12+$1+Séparateur dossier:K24:12+"Documents usagers"+Séparateur dossier:K24:12+\
			Replace string:C233($hebergeB_e.HB_Clé; "/"; "-"); fk chemin plateforme:K87:2)
		
		For each ($file_f; $folderOld_f.files())
			$fileCopy_f:=$file_f.copyTo($folderNew_f; fk écraser:K87:5)
			$file_f.delete()
		End for each 
		
	End if 
	
End if 

[Base_documentaire:90]DOC_Origine_ID:4:=$2