Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_TEXT:C284($path_t)
		
		CONFIRM:C162("Voulez-vous exporter le document vers le format word (.docx) ?"; "Oui"; "Non")
		
		If (OK=1)
			SET TEXT TO PASTEBOARD:C523([DOCWPRO:121]nom:3)
			$path_t:=Select document:C905(System folder:C487(Bureau:K41:16); ".docx"; "Saisie du nom du fichier :"; Saisie nom de fichier:K24:17)
			
			If ($path_t#"")
				WP EXPORT DOCUMENT:C1337([DOCWPRO:121]fichier:4; document; wk docx:K81:277)
			Else 
				ALERT:C41("Une erreur est survenue, impossible d'exporter le document")
			End if 
			
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 