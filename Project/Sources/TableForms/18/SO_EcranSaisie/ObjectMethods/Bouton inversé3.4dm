
C_TEXT:C284($vt_Texte; $vt_Texte2)
C_LONGINT:C283($ii)
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[SOciete:18]SO_RépertoireSite:12:=""
Else 
	$vt_Texte:=""
	$vt_Texte:=Select folder:C670("Sélectionnez le répertoire du site.")
	If ($vt_Texte>"")
		$vt_Texte:=Substring:C12($vt_Texte; 1; Length:C16($vt_Texte)-1)
		$jj:=0
		$ii:=Length:C16($vt_Texte)
		Repeat 
			If ($vt_Texte[[$ii]]=Séparateur dossier:K24:12)
				$vt_Texte2:=Substring:C12($vt_Texte; $ii+1)
				[SOciete:18]SO_RépertoireSite:12:=$vt_Texte2
				$ii:=0
			Else 
				$ii:=$ii-1
			End if 
		Until ($ii<=0)
		
		
		If (7=8)
			$vt_Texte2:=""
			$vt_Texte2:=F_RépertoireCréer($vt_Texte; 0)
			If ($vt_Texte2>"")
				$ii:=Length:C16($vt_Texte2)
				Repeat 
					$ii:=$ii-1
				Until ($vt_Texte2[[$ii]]=Séparateur dossier:K24:12)
				
				[SOciete:18]SO_RépertoireSite:12:=Substring:C12($vt_Texte2; $ii+1; Length:C16($vt_Texte2)-$ii-1)
			End if 
			
		End if 
		
	End if 
End if 
