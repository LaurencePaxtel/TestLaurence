var $nomDocument_t : Text

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$nomDocument_t:=Request:C163("Enregistrer sous... (nom du document) ?"; [DOCWPRO:121]nom:3; "Enregistrer sous"; "Annuler")
		
		If ($nomDocument_t#"")
			outilsWProCreerDocument("autoEnregistrerSous"; $nomDocument_t)
			
			If ($nomDocument_t=[DOCWPRO:121]nom:3)
				SET WINDOW TITLE:C213("Modification de la lettre "+[DOCWPRO:121]nom:3)
			End if 
			
		Else 
			ALERT:C41("Merci de saisir un nom de document non-vide")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 