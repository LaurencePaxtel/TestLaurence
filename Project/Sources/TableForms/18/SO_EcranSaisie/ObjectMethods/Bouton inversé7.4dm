If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[SOciete:18]SO_CheminBoite:90:=""
Else 
	vt_Chem:=""
	vt_Chem:=Select folder:C670("Sélectionnez le dossier de boîte au lettres.")
	If (vt_Chem>"")
		[SOciete:18]SO_CheminBoite:90:=vt_Chem
	End if 
End if 

