// #20180608-1


C_POINTER:C301($P_Field)
$P_Field:=->[SOciete:18]SO_Chemin_GED:96

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	$P_Field->:=""
Else 
	
	C_TEXT:C284($T_Folder)
	$T_Folder:=Select folder:C670("Sélectionnez le dossier de recevant le dossier Documents usagers:")
	If ($T_Folder#"") & (OK=1)
		$P_Field->:=$T_Folder
	End if 
End if 

