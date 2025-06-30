Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var pdfViewer_o : Object
		
		Form:C1466.notification_cs:=cuToolGetClass("Notification").new()
		pdfViewer_o:=New object:C1471("document"; Folder:C1567(fk dossier ressources:K87:11; *).file("document/cgu.pdf"))
End case 