Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		Form:C1466.voirVariable:=False:C215
		
		OBJECT SET ENTERABLE:C238(*; "WParea"; (Current user:C182="apaxtel"))
		
		OBJECT SET ENABLED:C1123(*; "Bouton image1"; (User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		OBJECT SET ENABLED:C1123(*; "Bouton image5"; (User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		OBJECT SET ENABLED:C1123(*; "Bouton image8"; (User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		OBJECT SET ENABLED:C1123(*; "Bouton image9"; (User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		OBJECT SET ENABLED:C1123(*; "Bouton image10"; (User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		
		outilsWProCreerDocument("auto"; "NOUVEAU DOCUMENT")
	: (Form event code:C388=Sur case de fermeture:K2:21)
		
		If ([DOCWPRO:121]fichier:4#Null:C1517) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			CONFIRM:C162("Voulez-vous enregistrer le document ?"; "Oui"; "Non")
			
			If (OK=1)
				SAVE RECORD:C53([DOCWPRO:121])
				
				ALERT:C41("Sauvegarde du document effectuée")
			End if 
			
		End if 
		
		ACCEPT:C269
		UNLOAD RECORD:C212([DOCWPRO:121])
End case 