If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[SOciete:18]SO_CheminRepertoireDistant:89:=""
Else 
	vt_Chem:=""
	vt_Chem:=Select folder:C670("Sélectionnez le dossier de distant.")
	If (vt_Chem>"")
		[SOciete:18]SO_CheminRepertoireDistant:89:=vt_Chem
	End if 
End if 

