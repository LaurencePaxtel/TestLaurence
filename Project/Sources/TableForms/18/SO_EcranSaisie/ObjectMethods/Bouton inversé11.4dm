If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[SOciete:18]SO_ConsoRégion_DosPour115:47:=""
Else 
	vt_Chem:=""
	vt_Chem:=Select folder:C670("Sélectionnez le répertoire Régional du 115 .")
	If (vt_Chem>"")
		[SOciete:18]SO_ConsoRégion_DosPour115:47:=vt_Chem
	End if 
End if 