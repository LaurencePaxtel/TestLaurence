// Method host_navigateur.sub_navigateur  
// 
// #20180511-1

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_POINTER:C301($Pointer_Sub)
		$Pointer_Sub:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "sub_navigateur")
		
		C_TEXT:C284($T_localFolder)
		$T_localFolder:=System folder:C487(Dossier documents:K41:18)+"Paxtel file browser local"+Séparateur dossier:K24:12
		CREATE FOLDER:C475($T_localFolder; *)
		
		// $T_localFolder est un dossier sur la machine client.
		// Tous les docs à mettre sur le remote passent par $T_localFolder
		
		Form:C1466.localfolder:=$T_localFolder
		
		$Pointer_Sub->:=Form:C1466  // le container passe au sous formulaire le contenu de la listbox
		
	: (Form event code:C388=-1)
		
		// On a double cliqué sur une ligne
		// on lit le chemin du doc
		OPEN URL:C673(OB Get:C1224(Form:C1466; "thispath"; Est un texte:K8:3))
		
	: (Form event code:C388=-2)
		
		ALERT:C41("Vous devez être dans le groupe "+<>Groupe_documents_serveur+" Pour consulter ce document")
End case 



