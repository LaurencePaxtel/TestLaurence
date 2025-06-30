C_TEXT:C284($webCode_t)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Records in selection:C76([DOCWPRO:121])=1)
			$webCode_t:=WP Get text:C1575([DOCWPRO:121]fichier:4; wk expressions as value:K81:255)
			$webCode_t:=Replace string:C233($webCode_t; "Indéfinie"; "")
			
			WA OPEN URL:C1020(*; "MaZoneW"; "about:blank")
			WA SET PAGE CONTENT:C1037(*; "MaZoneW"; $webCode_t; "about:blank")
		End if 
		
End case 