If (Form event code:C388=Sur clic:K2:4)
	
	// Modifié par : Scanu Rémy (05/09/2022)
	If ([LesCentres:9]LC_GL_Nom_Suite:63="")
		[LesCentres:9]LC_GL_Nom_Suite:63:=[LesCentres:9]LC_Nom:4
	End if 
	
	If (ta_Page{ta_Page}="Paramètre Rétroplanning")
		FORM GOTO PAGE:C247(6)
	End if 
	
End if 