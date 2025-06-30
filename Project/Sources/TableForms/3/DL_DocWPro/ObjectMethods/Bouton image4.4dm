C_OBJECT:C1216($position_o)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$position_o:=New object:C1471("ecartHautEcran"; 90; "ecartBasEcran"; 70)
		
		If (WP Get text:C1575([DOCWPRO:121]fichier:4; wk expressions as value:K81:255)="@<p@") | (WP Get text:C1575([DOCWPRO:121]fichier:4; wk expressions as value:K81:255)="@<html@")
			outilsCreateWindowsForm("FormApercuEmail"; ->$position_o)
		Else 
			ALERT:C41("Le document 4D WPro ne contient pas de code html")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 