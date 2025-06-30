Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Form:C1466.appel=Null:C1517)  // Le formulaire est appelé en tant que sous-formulaire
			WA OPEN URL:C1020(*; "Zone Web"; Folder:C1567(fk dossier ressources:K87:11).file("document/chargement.gif").platformPath)
			SET TIMER:C645(180)
		Else 
			Form:C1466.pdfPath:=Select document:C905(""; ".pdf"; "Sélection d'un fichier pdf"; 0)
			Form:C1466.pdfPath:="file://"+Convert path system to POSIX:C1106(Document)
		End if 
		
	: (Form event code:C388=Sur minuteur:K2:25)
		
		If (OBJECT Get pointer:C1124(Objet conteneur sous formulaire:K67:4)->document#Null:C1517)
			WA OPEN URL:C1020(*; "Zone Web"; OBJECT Get pointer:C1124(Objet conteneur sous formulaire:K67:4)->document.platformPath)
		End if 
		
		SET TIMER:C645(0)
End case 