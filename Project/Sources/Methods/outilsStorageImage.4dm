//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 02/03/21, 10:36:07
// ----------------------------------------------------
// Méthode : outilsStorageImage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_PICTURE:C286($image_i)
C_BLOB:C604($blob_b)
C_OBJECT:C1216($image_o; $dossier_o; $fichier_o)

$image_o:=New object:C1471()
$dossier_o:=Folder:C1567(Get 4D folder:C485(Dossier Resources courant:K5:16)+"Images"+Séparateur dossier:K24:12+"cio"+Séparateur dossier:K24:12; fk chemin plateforme:K87:2)

Use (Storage:C1525)
	Storage:C1525.image:=New shared object:C1526
End use 

For each ($fichier_o; $dossier_o.files(fk ignorer invisibles:K87:22))
	$blob_b:=$fichier_o.getContent()
	
	BLOB TO PICTURE:C682($blob_b; $image_i)
	
	Use (Storage:C1525.image)
		Storage:C1525.image[$fichier_o.name]:=$image_i
	End use 
	
End for each 